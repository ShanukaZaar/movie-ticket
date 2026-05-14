package com.movieticket.servlet;

import com.movieticket.dao.BookingDAO;
import com.movieticket.dao.PaymentDAO;
import com.movieticket.model.Payment;
import com.movieticket.util.EmailUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.UUID;

@WebServlet("/card-payment")
public class CardPaymentServlet extends HttpServlet {

    private final PaymentDAO paymentDAO = new PaymentDAO();
    private final BookingDAO bookingDAO = new BookingDAO();

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

            String error = validateCard(cardholderName, cardNumber, expiryMonth, expiryYear, cvv, billingEmail);

            if (error != null) {
                request.setAttribute("error", error);
                request.setAttribute("bookingId", bookingId);
                request.setAttribute("amount", amount);
                request.getRequestDispatcher("/views/card-payment.jsp").forward(request, response);
                return;
            }

            String transactionId = "TXN-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
            String lastFourDigits = cardNumber.substring(cardNumber.length() - 4);

            boolean emailSent = EmailUtil.sendPaymentConfirmation(billingEmail, transactionId, amount);

            Payment payment = new Payment(
                    bookingId,
                    amount,
                    "credit_card",
                    "success",
                    cardholderName,
                    lastFourDigits,
                    billingEmail,
                    transactionId,
                    emailSent ? "YES" : "NO"
            );

            boolean saved = paymentDAO.addPayment(payment);

            if (saved) {
                bookingDAO.updateBookingStatusToPaid(bookingId);
                response.sendRedirect(request.getContextPath() + "/receipt?txn=" + transactionId);
            } else {
                response.sendRedirect(request.getContextPath() + "/views/payment-failed.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/views/payment-failed.jsp");
        }
    }

    private String validateCard(String cardholderName, String cardNumber, String expiryMonth,
                                String expiryYear, String cvv, String billingEmail) {

        if (cardholderName == null || cardholderName.trim().isEmpty()) return "Cardholder name is required.";
        if (cardNumber == null || !cardNumber.matches("\\d{16}")) return "Card number must be exactly 16 digits.";
        if (expiryMonth == null || expiryMonth.trim().isEmpty()) return "Expiry month is required.";
        if (expiryYear == null || expiryYear.trim().isEmpty()) return "Expiry year is required.";
        if (cvv == null || !cvv.matches("\\d{3}")) return "CVV must be exactly 3 digits.";
        if (billingEmail == null || !billingEmail.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) return "Valid email is required.";

        return null;
    }
}