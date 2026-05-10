package com.movieticket.servlet;

import com.movieticket.dao.PaymentDAO;
import com.movieticket.model.Payment;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/payment")
public class PaymentServlet extends HttpServlet {

    // Show payment page when user opens /payment
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/payment.jsp").forward(request, response);
    }

    // Process payment form submission
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            double amount = Double.parseDouble(request.getParameter("amount"));
            String paymentMethod = request.getParameter("paymentMethod");

            Payment payment = new Payment(bookingId, amount, paymentMethod, "success");

            PaymentDAO paymentDAO = new PaymentDAO();
            boolean isSaved = paymentDAO.addPayment(payment);

            if (isSaved) {
                response.sendRedirect(request.getContextPath() + "/views/payment-success.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/views/payment-fail.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/views/payment-fail.jsp");
        }
    }
}