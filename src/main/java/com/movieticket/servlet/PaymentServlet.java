package com.movieticket.servlet;

import com.movieticket.dao.BookingDAO;
import com.movieticket.dao.PaymentDAO;
import com.movieticket.model.Payment;

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

        String action = request.getParameter("action");

        // View payment records
        if ("list".equals(action)) {
            request.setAttribute("payments", paymentDAO.getAllPayments());
            request.getRequestDispatcher("/views/payment-list.jsp").forward(request, response);
            return;
        }

        // Select payment method
        if ("selectMethod".equals(action)) {
            String paymentMethod = request.getParameter("paymentMethod");

            if ("credit_card".equals(paymentMethod)) {
                request.setAttribute("bookingId", request.getParameter("bookingId"));
                request.setAttribute("amount", request.getParameter("amount"));
                request.getRequestDispatcher("/views/card-payment.jsp").forward(request, response);
                return;
            }

            response.sendRedirect(request.getContextPath() + "/views/payment-fail.jsp");
            return;
        }

        // Default payment checkout page
        request.getRequestDispatcher("/views/payment.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            double amount = Double.parseDouble(request.getParameter("amount"));

            String cardholderName = request.getParameter("cardholderName");
            String cardNumber = request.getParameter("cardNumber");
            String expiryMonth = request.getParameter("expiryMonth");
            String expiryYear = request.getParameter("expiryYear");
            String cvv = request.getParameter("cvv");
            String billingEmail = request.getParameter("billingEmail");

            String error = validatePayment(cardholderName, cardNumber, expiryMonth, expiryYear, cvv, billingEmail);

            if (error != null) {
                request.setAttribute("error", error);
                request.setAttribute("bookingId", bookingId);
                request.setAttribute("amount", amount);
                request.getRequestDispatcher("/views/card-payment.jsp").forward(request, response);
                return;
            }

            String lastFourDigits = cardNumber.substring(cardNumber.length() - 4);

            Payment payment = new Payment(
                    bookingId,
                    amount,
                    "credit_card",
                    "success",
                    cardholderName,
                    lastFourDigits,
                    billingEmail
            );

            boolean saved = paymentDAO.addPayment(payment);

            if (saved) {
                bookingDAO.updateBookingStatusToPaid(bookingId);
                response.sendRedirect(request.getContextPath() + "/views/payment-success.jsp");
            } else {
                request.setAttribute("error", "Payment failed. Please try again.");
                request.setAttribute("bookingId", bookingId);
                request.setAttribute("amount", amount);
                request.getRequestDispatcher("/views/card-payment.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Something went wrong while processing payment.");
            request.getRequestDispatcher("/views/card-payment.jsp").forward(request, response);
        }
    }

    private String validatePayment(String cardholderName, String cardNumber, String expiryMonth,
                                   String expiryYear, String cvv, String billingEmail) {

        if (cardholderName == null || cardholderName.trim().isEmpty()) {
            return "Cardholder name is required.";
        }

        if (cardNumber == null || !cardNumber.matches("\\d{16}")) {
            return "Card number must be exactly 16 digits.";
        }

        if (expiryMonth == null || expiryMonth.trim().isEmpty()) {
            return "Expiry month is required.";
        }

        if (expiryYear == null || expiryYear.trim().isEmpty()) {
            return "Expiry year is required.";
        }

        if (cvv == null || !cvv.matches("\\d{3}")) {
            return "CVV must be exactly 3 digits.";
        }

        if (billingEmail == null || !billingEmail.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
            return "Valid billing email is required.";
        }

        return null;
    }
}