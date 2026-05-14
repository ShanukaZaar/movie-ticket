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

        String action = request.getParameter("action");

        if ("list".equals(action)) {
            request.setAttribute("payments", paymentDAO.getAllPayments());
            request.getRequestDispatcher("/views/payment-list.jsp").forward(request, response);
            return;
        }

        if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            request.setAttribute("payment", paymentDAO.getPaymentById(id));
            request.getRequestDispatcher("/views/payment-edit.jsp").forward(request, response);
            return;
        }

        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            paymentDAO.deletePayment(id);
            response.sendRedirect(request.getContextPath() + "/payment?action=list");
            return;
        }

        if ("selectMethod".equals(action)) {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            String paymentMethod = request.getParameter("paymentMethod");

            double calculatedAmount = bookingDAO.calculateBookingAmount(bookingId);

            if ("credit_card".equals(paymentMethod)) {
                request.setAttribute("bookingId", bookingId);
                request.setAttribute("amount", calculatedAmount);
                request.getRequestDispatcher("/views/card-payment.jsp").forward(request, response);
                return;
            }

            response.sendRedirect(request.getContextPath() + "/views/payment-failed.jsp");
            return;
        }

        request.getRequestDispatcher("/views/payment.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String paymentStatus = request.getParameter("paymentStatus");

            paymentDAO.updatePaymentStatus(id, paymentStatus);
            response.sendRedirect(request.getContextPath() + "/payment?action=list");
        }
    }
}