package com.movieticket.servlet;

import com.movieticket.dao.BookingDAO;
import com.movieticket.dao.PaymentDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/receipt")
public class ReceiptServlet extends HttpServlet {

    private final PaymentDAO paymentDAO = new PaymentDAO();
    private final BookingDAO bookingDAO = new BookingDAO();

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
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            request.setAttribute("payment", paymentDAO.getPaymentByBookingId(bookingId));
            request.setAttribute("booking", bookingDAO.getBookingById(bookingId));
            request.getRequestDispatcher("/views/payment/payment-success.jsp")
                    .forward(request, response);
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
}