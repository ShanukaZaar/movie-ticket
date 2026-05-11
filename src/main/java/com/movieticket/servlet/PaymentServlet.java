package com.movieticket.servlet;

import com.movieticket.dao.PaymentDAO;
import com.movieticket.model.Payment;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/payment")
public class PaymentServlet extends HttpServlet {

    private final PaymentDAO paymentDAO = new PaymentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            request.getRequestDispatcher("/views/payment.jsp").forward(request, response);
            return;
        }

        switch (action) {
            case "list":
                request.setAttribute("payments", paymentDAO.getAllPayments());
                request.getRequestDispatcher("/views/payment-list.jsp").forward(request, response);
                break;

            case "edit":
                int editId = Integer.parseInt(request.getParameter("id"));
                request.setAttribute("payment", paymentDAO.getPaymentById(editId));
                request.getRequestDispatcher("/views/payment-edit.jsp").forward(request, response);
                break;

            case "delete":
                int deleteId = Integer.parseInt(request.getParameter("id"));
                paymentDAO.deletePayment(deleteId);
                response.sendRedirect(request.getContextPath() + "/payment?action=list");
                break;

            default:
                request.getRequestDispatcher("/views/payment.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            if ("update".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String status = request.getParameter("status");

                paymentDAO.updatePaymentStatus(id, status);
                response.sendRedirect(request.getContextPath() + "/payment?action=list");

            } else {
                int bookingId = Integer.parseInt(request.getParameter("bookingId"));
                double amount = Double.parseDouble(request.getParameter("amount"));
                String paymentMethod = request.getParameter("paymentMethod");

                Payment payment = new Payment(bookingId, amount, paymentMethod, "success");
                boolean isSaved = paymentDAO.addPayment(payment);

                if (isSaved) {
                    response.sendRedirect(request.getContextPath() + "/views/payment-success.jsp");
                } else {
                    response.sendRedirect(request.getContextPath() + "/views/payment-fail.jsp");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/views/payment-fail.jsp");
        }
    }
}