<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LogiFlow - Transportes</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Style.css">
</head>
<body>
   <%@ include file= "includes/Header.jsp" %>
    <div class="container">
       <%@ include file="includes/Sidebar.jsp" %>
        <main class="main-content">
            <!-- Transportes Section -->
            <section id="transportes" class="form-section active">
                <div class="page-header">
                    <h2 class="page-title">Gestión de Transportes</h2>
                    <p class="page-subtitle">Administrar vehículos y rutas de entrega</p>
                </div>
                <div class="content-card">
                    <h3>Nuevo Transporte</h3>
                    <form id="transportForm">
                        <div class="form-row">
                            <div class="form-group">
                                <label for="placaVehiculo">Placa del Vehículo</label>
                                <input type="text" id="placaVehiculo" name="placaVehiculo" required>
                            </div>
                            <div class="form-group">
                                <label for="tipoVehiculo">Tipo de Vehículo</label>
                                <select id="tipoVehiculo" name="tipoVehiculo" required>
                                    <option value="">Seleccionar tipo</option>
                                    <option value="camion">Camión</option>
                                    <option value="van">Van</option>
                                    <option value="motocicleta">Motocicleta</option>
                                    <option value="auto">Automóvil</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <label for="conductor">Conductor</label>
                                <input type="text" id="conductor" name="conductor" required>
                            </div>
                            <div class="form-group">
                                <label for="licenciaConductor">Licencia de Conducir</label>
                                <input type="text" id="licenciaConductor" name="licenciaConductor" required>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <label for="capacidadCarga">Capacidad de Carga (kg)</label>
                                <input type="number" id="capacidadCarga" name="capacidadCarga" step="0.1" required>
                            </div>
                            <div class="form-group">
                                <label for="estadoVehiculo">Estado del Vehículo</label>
                                <select id="estadoVehiculo" name="estadoVehiculo" required>
                                    <option value="disponible">Disponible</option>
                                    <option value="en_ruta">En Ruta</option>
                                    <option value="mantenimiento">En Mantenimiento</option>
                                    <option value="fuera_servicio">Fuera de Servicio</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i> Registrar Vehículo
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