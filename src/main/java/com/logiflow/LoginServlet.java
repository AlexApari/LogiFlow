package com.logiflow;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if ("Admin".equals(username) && "Admin123".equals(password)) {
            response.sendRedirect(request.getContextPath() + "/Dashboard.jsp");
        } else {
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
    }
}
