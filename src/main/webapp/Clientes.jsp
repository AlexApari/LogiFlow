<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LogiFlow - Clientes</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Style.css">
</head>
<body>
   <%@ include file= "includes/Header.jsp" %>
    <div class="container">
       <%@ include file="includes/Sidebar.jsp" %>
        <main class="main-content">
        <p>TEST: este contenido siempre debe mostrarse</p>
            <!-- Clientes Section -->
            <section id="clientes" class="form-section active">
                <div class="page-header">
                    <h2 class="page-title">Gestión de Clientes</h2>
                    <p class="page-subtitle">Administrar clientes y destinatarios</p>
                </div>
                <div class="content-card">
                    <h3>Nuevo Cliente</h3>
                    <form id="clientForm">
                        <div class="form-row">
                            <div class="form-group">
                                <label for="tipoDocumento">Tipo de Documento</label>
                                <select id="tipoDocumento" name="tipoDocumento" required>
                                    <option value="dni">DNI</option>
                                    <option value="ruc">RUC</option>
                                    <option value="pasaporte">Pasaporte</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="numeroDocumento">Número de Documento</label>
                                <input type="text" id="numeroDocumento" name="numeroDocumento" required>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <label for="nombreCliente">Nombre</label>
                                <input type="text" id="nombreCliente" name="nombreCliente" required>
                            </div>
                            <div class="form-group">
                                <label for="apellidoCliente">Apellido</label>
                                <input type="text" id="apellidoCliente" name="apellidoCliente" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="direccionCliente">Dirección</label>
                            <input type="text" id="direccionCliente" name="direccionCliente" required>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <label for="telefonoCliente">Teléfono</label>
                                <input type="tel" id="telefonoCliente" name="telefonoCliente" required>
                            </div>
                            <div class="form-group">
                                <label for="emailCliente">Email</label>
                                <input type="email" id="emailCliente" name="emailCliente" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i> Guardar Cliente
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