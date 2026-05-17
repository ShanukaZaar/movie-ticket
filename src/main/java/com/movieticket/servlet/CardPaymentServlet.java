package com.movieticket.servlet;

import com.movieticket.dao.BookingDAO;
import com.movieticket.dao.PaymentDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/card-payment")
public class CardPaymentServlet extends HttpServlet {

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

        String bookingId = request.getParameter("bookingId");
        String amount = request.getParameter("amount");
        request.setAttribute("bookingId", bookingId);
        request.setAttribute("amount", amount);
        request.getRequestDispatcher("/views/payment/card-payment.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check login
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            double amount = Double.parseDouble(request.getParameter("amount"));
            String cardHolderName = request.getParameter("cardHolderName");
            String cardNumber = request.getParameter("cardNumber");
            String expiryMonth = request.getParameter("expiryMonth");
            String expiryYear = request.getParameter("expiryYear");
            String cvv = request.getParameter("cvv");
            String paymentMethod = request.getParameter("paymentMethod");
            if (paymentMethod == null)
                paymentMethod = "credit_card";

            // Validate card
            String error = validateCard(cardHolderName, cardNumber,
                    expiryMonth, expiryYear, cvv);

            if (error != null) {
                request.setAttribute("error", error);
                request.setAttribute("bookingId", bookingId);
                request.setAttribute("amount", amount);
                request.getRequestDispatcher("/views/payment/card-payment.jsp")
                        .forward(request, response);
                return;
            }

            // Save payment
            boolean saved = paymentDAO.createPayment(
                    bookingId, amount, paymentMethod, cardHolderName);

            if (saved) {
                bookingDAO.updateBookingStatusToPaid(bookingId);
                response.sendRedirect(request.getContextPath() +
                        "/payment?action=success&bookingId=" + bookingId);
            } else {
                request.setAttribute("error", "Payment processing failed. Please try again.");
                request.setAttribute("bookingId", bookingId);
                request.setAttribute("amount", amount);
                request.getRequestDispatcher("/views/payment/card-payment.jsp")
                        .forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() +
                    "/payment?action=success&bookingId=" +
                    request.getParameter("bookingId"));
        }
    }

    private String validateCard(String cardHolderName, String cardNumber,
            String expiryMonth, String expiryYear, String cvv) {
        if (cardHolderName == null || cardHolderName.trim().isEmpty())
            return "Cardholder name is required.";
        if (cardNumber == null || !cardNumber.replaceAll("\\s", "").matches("\\d{16}"))
            return "Card number must be exactly 16 digits.";
        if (expiryMonth == null || expiryMonth.trim().isEmpty())
            return "Expiry month is required.";
        if (expiryYear == null || expiryYear.trim().isEmpty())
            return "Expiry year is required.";
        if (cvv == null || !cvv.matches("\\d{3,4}"))
            return "CVV must be 3 or 4 digits.";
        return null;
    }
}