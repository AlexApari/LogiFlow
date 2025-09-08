<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LogiFlow - Pedidos</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Style.css">
</head>
<body>
   <%@ include file= "includes/Header.jsp" %>
    <div class="container">
       <%@ include file="includes/Sidebar.jsp" %>
        <main class="main-content">
            <!-- Pedidos Section -->
            <section id="pedidos" class="form-section active">
                <div class="page-header">
                    <h2 class="page-title">Gestión de Pedidos</h2>
                    <p class="page-subtitle">Crear y administrar pedidos</p>
                </div>
                <div class="content-card">
                    <h3>Nuevo Pedido</h3>
                    <form id="orderForm">
                        <div class="form-row">
                            <div class="form-group">
                                <label for="numeroPedido">Número de Pedido</label>
                                <input type="text" id="numeroPedido" name="numeroPedido" value="PED-2024-001" readonly>
                            </div>
                            <div class="form-group">
                                <label for="fechaPedido">Fecha de Pedido</label>
                                <input type="date" id="fechaPedido" name="fechaPedido" required>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <label for="clientePedido">Cliente</label>
                                <select id="clientePedido" name="clientePedido" required>
                                    <option value="">Seleccionar cliente</option>
                                    <option value="1">Juan Pérez Rodríguez</option>
                                    <option value="2">María García López</option>
                                    <option value="3">Carlos Mendoza Silva</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="estadoPedido">Estado</label>
                                <select id="estadoPedido" name="estadoPedido" required>
                                    <option value="pendiente">Pendiente</option>
                                    <option value="procesando">Procesando</option>
                                    <option value="enviado">Enviado</option>
                                    <option value="entregado">Entregado</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="direccionEntrega">Dirección de Entrega</label>
                            <textarea id="direccionEntrega" name="direccionEntrega" rows="2" required></textarea>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <label for="fechaEntrega">Fecha de Entrega Estimada</label>
                                <input type="date" id="fechaEntrega" name="fechaEntrega" required>
                            </div>
                            <div class="form-group">
                                <label for="prioridad">Prioridad</label>
                                <select id="prioridad" name="prioridad">
                                    <option value="normal">Normal</option>
                                    <option value="alta">Alta</option>
                                    <option value="urgente">Urgente</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="observaciones">Observaciones</label>
                            <textarea id="observaciones" name="observaciones" rows="3"></textarea>
                        </div>
                        <div class="form-group">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i> Crear Pedido
                            </button>
                            <button type="reset" class="btn btn-secondary">
                                <i class="fas fa-undo"></i> Limpiar
                            </button>
                        </div>
                    </form>
                </div>
            </section>
        </main>
    </div>
</body>
</html>