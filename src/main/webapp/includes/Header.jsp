<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.logiflow.model.Usuario" %>
<%@ page import="com.logiflow.model.Rol" %>
<%@ page import="java.util.Set" %>
<%@ page import="com.logiflow.controller.LoginServlet" %>
<%
Usuario usuario = (Usuario) session.getAttribute("usuario");
String nombreUsuario = "Invitado";
String rolUsuario = "USUARIO";

if (usuario != null) {
    nombreUsuario = usuario.getNombre() != null ? usuario.getNombre() : "Sin nombre";

    Set<Rol> roles = usuario.getRoles();
    if (roles != null && !roles.isEmpty()) {
        rolUsuario = roles.iterator().next().getNombre();
    }
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

 <header class="header">
        <div class="logo-section">
            <i class="fas fa-truck" style="font-size: 2rem;"></i>
            <h1>LogiFlow</h1>
        </div>
        <div class="user-section">
            <div class="user-info">
                <strong><%= nombreUsuario %></strong> • <%= rolUsuario %>
            </div>
             <form action="<%= request.getContextPath() %>/LogoutServlet" method="post" style="display:inline;">
            <button class="logout-btn">
                <i class="fas fa-sign-out-alt"></i>
            </button>
            </form>
        </div>
    </header>
</body>
</html>