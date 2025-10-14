<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.logiflow.*" %>    
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LogiFlow - Dashboard</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Style.css">
</head>
<body>
<%
Usuario user = (Usuario) session.getAttribute("usuario");
String rolUsur = (String) session.getAttribute("rolUsuario");

System.out.println("[DASHBOARD] Usuario en sesión: " + (user != null ? user.getUsername() : "Ninguno"));
System.out.println("[DASHBOARD] RolUsuario: " + rolUsur);
%>
   <%@ include file= "includes/Header.jsp" %>
   <%
if (usuario != null) {
%>
    <div class="container">
    <% System.out.println("[JSP] Iniciando container"); %>
       <%@ include file="includes/Sidebar.jsp" %>
        <main class="main-content">
        <% System.out.println("[JSP] Iniciando main-content"); %>
            <!-- Dashboard Section -->
            <section id="dashboard" class="form-section active">
                <div class="page-header">
                    <h2 class="page-title">Dashboard</h2>
                    <p class="page-subtitle">Resumen general del sistema logístico</p>
                </div>

                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-icon blue">
                            <i class="fas fa-box"></i>
                        </div>
                        <div class="stat-info">
                            <h3>1,247</h3>
                            <p>Productos Totales</p>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon green">
                            <i class="fas fa-shopping-cart"></i>
                        </div>
                        <div class="stat-info">
                            <h3>89</h3>
                            <p>Pedidos Activos</p>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon orange">
                            <i class="fas fa-truck"></i>
                        </div>
                        <div class="stat-info">
                            <h3>23</h3>
                            <p>Envíos en Tránsito</p>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon purple">
                            <i class="fas fa-users"></i>
                        </div>
                        <div class="stat-info">
                            <h3>456</h3>
                            <p>Clientes Activos</p>
                        </div>
                    </div>
                </div>

                <div class="content-card">
                    <h3>Actividad Reciente</h3>
                    <div class="table-container">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Fecha</th>
                                    <th>Actividad</th>
                                    <th>Usuario</th>
                                    <th>Estado</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>2024-03-15 10:30</td>
                                    <td>Nuevo pedido #001234</td>
                                    <td>Juan Pérez</td>
                                    <td><span style="color: #28a745;">Completado</span></td>
                                </tr>
                                <tr>
                                    <td>2024-03-15 09:15</td>
                                    <td>Actualización de inventario</td>
                                    <td>María García</td>
                                    <td><span style="color: #ffc107;">Pendiente</span></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </section>
        </main>
    
    </div>
    <%
} else {
    System.out.println("[DASHBOARD] No se renderiza main-content: usuario null");
}
%>
</body>
</html>