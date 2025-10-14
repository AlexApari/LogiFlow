package com.logiflow.controller;

import com.logiflow.model.Usuario;
import com.logiflow.DAO.loginDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpSession;
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

        loginDAO loginDao = new loginDAO();
        Usuario usuario = loginDao.obtenerPorUsername(username, password);
        
        if (usuario != null) {
        	
            HttpSession session = request.getSession();
            session.setAttribute("usuario", usuario);
            // Guardar el rol principal en la sesión en mayúsculas y sin espacios
            String rolUsuario = "USER";
            if (usuario.getRoles() != null && !usuario.getRoles().isEmpty()) {
                rolUsuario = usuario.getRoles().iterator().next().getNombre();
                if (rolUsuario != null) {
                    rolUsuario = rolUsuario.toUpperCase().trim();
                } else {
                    rolUsuario = "USER";
                }
            }
            System.out.println("[LOGIN] Usuario logueado: " + usuario.getUsername());
            System.out.println("[LOGIN] Rol principal: " + rolUsuario);
            System.out.println("[LOGIN] Roles completos: " + usuario.getRoles());
            session.setAttribute("rolUsuario", rolUsuario);
            response.sendRedirect("Dashboard.jsp");
        } else {
        	  System.out.println("Login fallido para usuario: " + username);
            request.setAttribute("error", "Usuario o contraseña incorrectos");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        }
    }
}