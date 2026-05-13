package com.movieticket.servlet;

import com.movieticket.dao.UserDAO;
import com.movieticket.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String type = request.getParameter("type");
        if ("admin".equals(type)) {
            request.setAttribute("registerType", "admin");
        } else {
            request.setAttribute("registerType", "customer");
        }
        request.getRequestDispatcher("/views/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String registerType = request.getParameter("registerType");
        String adminCode = request.getParameter("adminCode");

        try {
            // Check passwords match
            if (!password.equals(confirmPassword)) {
                request.setAttribute("error", "Passwords do not match!");
                request.setAttribute("registerType", registerType);
                request.getRequestDispatcher("/views/register.jsp").forward(request, response);
                return;
            }

            // Check email exists
            if (userDAO.emailExists(email)) {
                request.setAttribute("error", "Email already registered!");
                request.setAttribute("registerType", registerType);
                request.getRequestDispatcher("/views/register.jsp").forward(request, response);
                return;
            }

            // If admin registration, verify admin code
            String role = "customer";
            if ("admin".equals(registerType)) {
                if (adminCode == null || !userDAO.isValidAdminCode(adminCode)) {
                    request.setAttribute("error", "Invalid admin code!");
                    request.setAttribute("registerType", "admin");
                    request.getRequestDispatcher("/views/register.jsp").forward(request, response);
                    return;
                }
                role = "admin";
            }

            // Create user
            User user = new User();
            user.setName(name);
            user.setEmail(email);
            user.setPassword(password);
            user.setRole(role);

            boolean success = userDAO.registerUser(user);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/login?registered=true");
            } else {
                request.setAttribute("error", "Registration failed! Try again.");
                request.setAttribute("registerType", registerType);
                request.getRequestDispatcher("/views/register.jsp").forward(request, response);
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
