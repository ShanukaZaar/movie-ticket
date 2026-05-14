package com.movieticket.servlet;

import com.movieticket.dao.ReportDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;


public class DashboardServlet extends HttpServlet {

    private final ReportDAO reportDAO = new ReportDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Basic session/role check
       // HttpSession session = request.getSession(false);
        //if (session == null || !"admin".equals(session.getAttribute("role"))) {
            //response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            //return;
        //}

        try {
            request.setAttribute("totalUsers",    reportDAO.getTotalUsers());
            request.setAttribute("totalBookings", reportDAO.getTotalBookings());
            request.setAttribute("totalRevenue",  reportDAO.getTotalRevenue());
            request.setAttribute("totalMovies",   reportDAO.getTotalMovies());

            request.getRequestDispatcher("/views/dashboard.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            throw new ServletException("Dashboard error: " + e.getMessage(), e);
        }
    }
}