package com.movieticket.servlet;

import com.movieticket.dao.BookingDAO;
import com.movieticket.dao.TheaterDAO;
import com.movieticket.model.Seat;
import com.movieticket.model.Show;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/reservation")
public class ReservationServlet extends HttpServlet {

    private TheaterDAO theaterDAO = new TheaterDAO();
    private BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check login
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            int movieId = Integer.parseInt(request.getParameter("movieId"));
            request.setAttribute("movieId", movieId);

            // Get shows for this movie
            List<Show> shows = bookingDAO.getShowsByMovie(movieId);
            request.setAttribute("shows", shows);

            // If a show is selected, load seats
            String showIdParam = request.getParameter("showId");
            if (showIdParam != null && !showIdParam.isEmpty()) {
                int showId = Integer.parseInt(showIdParam);
                Show selectedShow = theaterDAO.getShowById(showId);
                request.setAttribute("selectedShow", selectedShow);

                // Get seats with booked status
                List<Seat> seats = bookingDAO.getSeatsByShow(
                    showId, selectedShow.getScreenId());
                request.setAttribute("seats", seats);
            }

            request.getRequestDispatcher("/views/reservation.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            int userId = (int) session.getAttribute("userId");
            int showId = Integer.parseInt(request.getParameter("showId"));
            String[] selectedSeats = request.getParameterValues("selectedSeats");

            if (selectedSeats == null || selectedSeats.length == 0) {
                response.sendRedirect(request.getContextPath() +
                    "/reservation?movieId=" + request.getParameter("movieId") +
                    "&showId=" + showId + "&error=noSeats");
                return;
            }

            Show show = theaterDAO.getShowById(showId);
            double totalAmount = show.getPrice() * selectedSeats.length;

            // Create booking
            int bookingId = bookingDAO.createBooking(userId, showId, totalAmount);

            // Add seats
            java.util.List<Integer> seatIds = new java.util.ArrayList<>();
            for (String seatId : selectedSeats) {
                seatIds.add(Integer.parseInt(seatId));
            }
            bookingDAO.addBookingSeats(bookingId, seatIds);

            // Redirect to payment
            response.sendRedirect(request.getContextPath() +
                "/payment?action=selectMethod&bookingId=" + bookingId);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}