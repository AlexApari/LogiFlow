<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LogiFlow - Reportes</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Style.css">
</head>
<body>
   <%@ include file= "includes/Header.jsp" %>
    <div class="container">
       <%@ include file="includes/Sidebar.jsp" %>
        <main class="main-content">
            <!-- Reportes Section -->
            <section id="reportes" class="form-section active">
                <div class="page-header">
                    <h2 class="page-title">Reportes y Analytics</h2>
                    <p class="page-subtitle">Generar reportes del sistema</p>
                </div>
                <div class="content-card">
                    <h3>Generar Reportes</h3>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="tipoReporte">Tipo de Reporte</label>
                            <select id="tipoReporte" name="tipoReporte" required>
                                <option value="">Seleccionar reporte</option>
                                <option value="ventas">Reporte de Ventas</option>
                                <option value="inventario">Reporte de Inventario</option>
                                <option value="clientes">Reporte de Clientes</option>
                                <option value="productos">Reporte de Productos</option>
                                <option value="entregas">Reporte de Entregas</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="fechaInicio">Fecha Inicio</label>
                            <input type="date" id="fechaInicio" name="fechaInicio">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="fechaFin">Fecha Fin</label>
                            <input type="date" id="fechaFin" name="fechaFin">
                        </div>
                        <div class="form-group">
                            <label for="formatoReporte">Formato</label>
                            <select id="formatoReporte" name="formatoReporte">
                                <option value="pdf">PDF</option>
                                <option value="excel">Excel</option>
                                <option value="csv">CSV</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <button type="button" class="btn btn-primary" onclick="generarReporte()">
                            <i class="fas fa-file-download"></i> Generar Reporte
                        </button>
                        <button type="button" class="btn btn-success">
                            <i class="fas fa-eye"></i> Vista Previa
                        </button>
                    </div>
                </div>
                <div class="content-card">
                    <h3>Reportes Frecuentes</h3>
                    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 15px;">
                        <button class="btn btn-primary" style="padding: 20px; text-align: left;">
                            <i class="fas fa-chart-line" style="font-size: 1.5rem; margin-bottom: 10px; display: block;"></i>
                            <strong>Ventas del Mes</strong><br>
                            <small>Resumen de ventas mensuales</small>
                        </button>
                        <button class="btn btn-primary" style="padding: 20px; text-align: left;">
                            <i class="fas fa-boxes" style="font-size: 1.5rem; margin-bottom: 10px; display: block;"></i>
                            <strong>Stock Bajo</strong><br>
                            <small>Productos con stock mínimo</small>
                        </button>
                        <button class="btn btn-primary" style="padding: 20px; text-align: left;">
                            <i class="fas fa-truck-moving" style="font-size: 1.5rem; margin-bottom: 10px; display: block;"></i>
                            <strong>Entregas Pendientes</strong><br>
                            <small>Pedidos por entregar</small>
                        </button>
                        <button class="btn btn-primary" style="padding: 20px; text-align: left;">
                            <i class="fas fa-users" style="font-size: 1.5rem; margin-bottom: 10px; display: block;"></i>
                            <strong>Clientes Top</strong><br>
                            <small>Mejores clientes del periodo</small>
                        </button>
                    </div>
                </div>
            </section>
        </main>
    </div>
</body>
</html>