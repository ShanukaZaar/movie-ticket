package com.movieticket.servlet;

import com.movieticket.dao.ReportDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

@WebServlet("/reports")
public class ReportServlet extends HttpServlet {

    private ReportDAO reportDAO = new ReportDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check admin
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("userRole"))) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        try {
            // Get selected month and year
            Calendar cal = Calendar.getInstance();
            int currentYear = cal.get(Calendar.YEAR);
            int currentMonth = cal.get(Calendar.MONTH) + 1;

            String yearParam = request.getParameter("year");
            String monthParam = request.getParameter("month");

            int year = yearParam != null ? Integer.parseInt(yearParam) : currentYear;
            int month = monthParam != null ? Integer.parseInt(monthParam) : currentMonth;

            // Get all report data
            double monthlyRevenue = reportDAO.getMonthlyRevenue(year, month);
            int monthlyBookings = reportDAO.getMonthlyBookings(year, month);
            int monthlyCancellations = reportDAO.getMonthlyCancellations(year, month);
            double cancellationFees = reportDAO.getMonthlyCancellationFees(year, month);
            double monthlyRefunds = reportDAO.getMonthlyRefunds(year, month);
            String mostBookedMovie = reportDAO.getMostBookedMovie(year, month);
            List<Map<String, Object>> revenuePerMovie = reportDAO.getRevenuePerMovie(year, month);
            List<Map<String, Object>> dailyRevenue = reportDAO.getDailyRevenue(year, month);

            // Calculate cancellation rate
            int totalBookings = monthlyBookings + monthlyCancellations;
            double cancellationRate = totalBookings > 0 ? (double) monthlyCancellations / totalBookings * 100 : 0;

            // Set attributes
            request.setAttribute("year", year);
            request.setAttribute("month", month);
            request.setAttribute("monthlyRevenue", monthlyRevenue);
            request.setAttribute("monthlyBookings", monthlyBookings);
            request.setAttribute("monthlyCancellations", monthlyCancellations);
            request.setAttribute("cancellationFees", cancellationFees);
            request.setAttribute("monthlyRefunds", monthlyRefunds);
            request.setAttribute("mostBookedMovie", mostBookedMovie);
            request.setAttribute("revenuePerMovie", revenuePerMovie);
            request.setAttribute("dailyRevenue", dailyRevenue);
            request.setAttribute("cancellationRate",
                    String.format("%.1f", cancellationRate));
            request.setAttribute("currentYear", currentYear);

            request.getRequestDispatcher("/views/reports.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}