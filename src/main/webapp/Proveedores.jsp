<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LogiFlow - Proveedores</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Style.css">
</head>
<body>
   <%@ include file= "includes/Header.jsp" %>
    <div class="container">
       <%@ include file="includes/Sidebar.jsp" %>
        <main class="main-content">
            <!-- Proveedores Section -->
            <section id="proveedores" class="form-section active">
                <div class="page-header">
                    <h2 class="page-title">Gestión de Proveedores</h2>
                    <p class="page-subtitle">Administrar proveedores y distribuidores</p>
                </div>
                <div class="content-card">
                    <h3>Nuevo Proveedor</h3>
                    <form id="supplierForm">
                        <div class="form-row">
                            <div class="form-group">
                                <label for="rucProveedor">RUC</label>
                                <input type="text" id="rucProveedor" name="rucProveedor" required>
                            </div>
                            <div class="form-group">
                                <label for="razonSocial">Razón Social</label>
                                <input type="text" id="razonSocial" name="razonSocial" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="direccionProveedor">Dirección</label>
                            <input type="text" id="direccionProveedor" name="direccionProveedor" required>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <label for="telefonoProveedor">Teléfono</label>
                                <input type="tel" id="telefonoProveedor" name="telefonoProveedor" required>
                            </div>
                            <div class="form-group">
                                <label for="emailProveedor">Email</label>
                                <input type="email" id="emailProveedor" name="emailProveedor" required>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <label for="contacto">Persona de Contacto</label>
                                <input type="text" id="contacto" name="contacto">
                            </div>
                            <div class="form-group">
                                <label for="condicionPago">Condición de Pago</label>
                                <select id="condicionPago" name="condicionPago">
                                    <option value="contado">Contado</option>
                                    <option value="credito30">Crédito 30 días</option>
                                    <option value="credito60">Crédito 60 días</option>
                                    <option value="credito90">Crédito 90 días</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i> Guardar Proveedor
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