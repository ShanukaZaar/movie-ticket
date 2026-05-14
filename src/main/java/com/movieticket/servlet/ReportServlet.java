package com.movieticket.servlet;

import com.movieticket.dao.ReportDAO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

public class ReportServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ReportDAO reportDAO = new ReportDAO();

        try {
            request.setAttribute("monthlyData",    reportDAO.getMonthlyBookings());
            request.setAttribute("popularMovies",  reportDAO.getMoviePopularity());
            request.setAttribute("paymentMethods", reportDAO.getRevenueByPaymentMethod());
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("monthlyData",    new ArrayList<>());
            request.setAttribute("popularMovies",  new ArrayList<>());
            request.setAttribute("paymentMethods", new ArrayList<>());
        }

        request.getRequestDispatcher("/views/reports.jsp")
                .forward(request, response);
    }
}