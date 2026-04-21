package com.movieticket.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Test Servlet - Used to verify the project is running correctly.
 *
 * URL: http://localhost:8080/movie-ticket-reservation/test
 */
@WebServlet("/test")
public class TestServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head><title>Test Page</title></head>");
        out.println("<body style='text-align:center; margin-top:50px; font-family:Arial;'>");
        out.println("<h1 style='color:green;'>✅ Project is working!</h1>");
        out.println("<p>Online Movie Ticket Reservation System is running successfully.</p>");
        out.println("<a href='views/login.jsp'>Go to Login</a>");
        out.println("</body>");
        out.println("</html>");
    }
}
