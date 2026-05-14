package com.movieticket.servlet;

import com.movieticket.dao.PaymentDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/receipt")
public class ReceiptServlet extends HttpServlet {

    private final PaymentDAO paymentDAO = new PaymentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String txn = request.getParameter("txn");

        request.setAttribute("payment", paymentDAO.getPaymentByTransactionId(txn));
        request.getRequestDispatcher("/views/booking-receipt.jsp").forward(request, response);
    }
}