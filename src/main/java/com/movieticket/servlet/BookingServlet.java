package com.movieticket.servlet;

import com.movieticket.dao.BookingDAO;
import com.movieticket.model.Booking;
import com.movieticket.model.Seat;
import com.movieticket.model.Show;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/booking")
public class BookingServlet extends HttpServlet {

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

        String action = request.getParameter("action");
        if (action == null) action = "myBookings";

        try {
            switch (action) {
                case "shows": showShowsForMovie(request, response); break;
                case "selectSeats": showSeatSelection(request, response); break;
                case "confirmation": showConfirmation(request, response); break;
                case "myBookings": showMyBookings(request, response); break;
                case "cancel": cancelBooking(request, response); break;
                case "allBookings": showAllBookings(request, response); break;
                default: showMyBookings(request, response);
            }
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

        String action = request.getParameter("action");
        try {
            if ("confirmBooking".equals(action)) {
                confirmBooking(request, response);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void showShowsForMovie(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        int movieId = Integer.parseInt(request.getParameter("movieId"));
        List<Show> shows = bookingDAO.getShowsByMovie(movieId);
        request.setAttribute("shows", shows);
        request.setAttribute("movieId", movieId);
        request.getRequestDispatcher("/views/booking/show-list.jsp").forward(request, response);
    }

    private void showSeatSelection(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        int showId = Integer.parseInt(request.getParameter("showId"));
        Show show = bookingDAO.getShowById(showId);
        List<Seat> seats = bookingDAO.getSeatsByShow(showId, show.getScreenId());
        request.setAttribute("show", show);
        request.setAttribute("seats", seats);
        request.getRequestDispatcher("/views/booking/seat-selection.jsp").forward(request, response);
    }

    private void confirmBooking(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("userId");
        int showId = Integer.parseInt(request.getParameter("showId"));
        String[] selectedSeats = request.getParameterValues("selectedSeats");

        if (selectedSeats == null || selectedSeats.length == 0) {
            response.sendRedirect(request.getContextPath() +
                "/booking?action=selectSeats&showId=" + showId + "&error=noSeats");
            return;
        }

        Show show = bookingDAO.getShowById(showId);
        double totalAmount = show.getPrice() * selectedSeats.length;

        // Create booking
        int bookingId = bookingDAO.createBooking(userId, showId, totalAmount);

        // Add seats
        List<Integer> seatIds = new ArrayList<>();
        for (String seatId : selectedSeats) {
            seatIds.add(Integer.parseInt(seatId));
        }
        bookingDAO.addBookingSeats(bookingId, seatIds);

        response.sendRedirect(request.getContextPath() +
            "/booking?action=confirmation&bookingId=" + bookingId);
    }

    private void showConfirmation(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        Booking booking = bookingDAO.getBookingById(bookingId);
        request.setAttribute("booking", booking);
        request.getRequestDispatcher("/views/booking/confirmation.jsp").forward(request, response);
    }

    private void showMyBookings(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("userId");
        List<Booking> bookings = bookingDAO.getBookingsByUser(userId);
        request.setAttribute("bookings", bookings);
        request.getRequestDispatcher("/views/booking/my-bookings.jsp").forward(request, response);
    }

    private void cancelBooking(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        bookingDAO.cancelBooking(bookingId);
        response.sendRedirect(request.getContextPath() + "/booking?action=myBookings");
    }

    private void showAllBookings(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("userRole");
        if (!"admin".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        List<Booking> bookings = bookingDAO.getAllBookings();
        request.setAttribute("bookings", bookings);
        request.getRequestDispatcher("/views/booking/all-bookings.jsp").forward(request, response);
    }
}