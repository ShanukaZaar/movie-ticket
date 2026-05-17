package com.movieticket.servlet;

import com.movieticket.dao.BookingDAO;
import com.movieticket.dao.PaymentDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/payment")
public class PaymentServlet extends HttpServlet {

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

        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "list":
                    request.setAttribute("payments", paymentDAO.getAllPayments());
                    request.getRequestDispatcher("/views/payment/payment-list.jsp")
                           .forward(request, response);
                    break;

                case "edit":
                    int editId = Integer.parseInt(request.getParameter("id"));
                    request.setAttribute("payment", paymentDAO.getPaymentById(editId));
                    request.getRequestDispatcher("/views/payment/payment-edit.jsp")
                           .forward(request, response);
                    break;

                case "delete":
                    int deleteId = Integer.parseInt(request.getParameter("id"));
                    paymentDAO.deletePayment(deleteId);
                    response.sendRedirect(request.getContextPath() + "/payment?action=list");
                    break;

                case "selectMethod":
                    int bookingId = Integer.parseInt(request.getParameter("bookingId"));
                    // Fixed: use getBookingAmount instead of calculateBookingAmount
                    double amount = bookingDAO.getBookingAmount(bookingId);
                    request.setAttribute("bookingId", bookingId);
                    request.setAttribute("amount", amount);
                    request.getRequestDispatcher("/views/payment/payment-form.jsp")
                           .forward(request, response);
                    break;

                case "success":
                    int successBookingId = Integer.parseInt(request.getParameter("bookingId"));
                    request.setAttribute("booking",
                        bookingDAO.getBookingById(successBookingId));
                    request.getRequestDispatcher("/views/payment/payment-success.jsp")
                           .forward(request, response);
                    break;

                default:
                    request.getRequestDispatcher("/views/payment/payment-form.jsp")
                           .forward(request, response);
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
            if ("update".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String paymentStatus = request.getParameter("paymentStatus");
                paymentDAO.updatePaymentStatus(id, paymentStatus);
                response.sendRedirect(request.getContextPath() + "/payment?action=list");

            } else if ("processPayment".equals(action)) {
                int bookingId = Integer.parseInt(request.getParameter("bookingId"));
                double amount = Double.parseDouble(request.getParameter("amount"));
                String paymentMethod = request.getParameter("paymentMethod");
                String cardHolderName = request.getParameter("cardHolderName");

                // Save payment to database
                paymentDAO.createPayment(bookingId, amount, paymentMethod, cardHolderName);

                // Update booking status to confirmed
                bookingDAO.updateBookingStatusToPaid(bookingId);

                response.sendRedirect(request.getContextPath() +
                    "/payment?action=success&bookingId=" + bookingId);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}