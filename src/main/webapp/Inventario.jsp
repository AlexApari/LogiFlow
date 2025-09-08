<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LogiFlow - Inventario</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Style.css">
</head>
<body>
   <%@ include file= "includes/Header.jsp" %>
    <div class="container">
       <%@ include file="includes/Sidebar.jsp" %>
        <main class="main-content">
            <!-- Inventario Section -->
            <section id="inventario" class="form-section active">
                <div class="page-header">
                    <h2 class="page-title">Control de Inventario</h2>
                    <p class="page-subtitle">Gestionar movimientos de inventario</p>
                </div>
                <div class="content-card">
                    <h3>Movimiento de Inventario</h3>
                    <form id="inventoryForm">
                        <div class="form-row">
                            <div class="form-group">
                                <label for="tipoMovimiento">Tipo de Movimiento</label>
                                <select id="tipoMovimiento" name="tipoMovimiento" required>
                                    <option value="">Seleccionar tipo</option>
                                    <option value="entrada">Entrada</option>
                                    <option value="salida">Salida</option>
                                    <option value="ajuste">Ajuste de Inventario</option>
                                    <option value="transferencia">Transferencia</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="fechaMovimiento">Fecha</label>
                                <input type="date" id="fechaMovimiento" name="fechaMovimiento" required>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <label for="productoInventario">Producto</label>
                                <select id="productoInventario" name="productoInventario" required>
                                    <option value="">Seleccionar producto</option>
                                    <option value="1">PROD001 - Laptop Dell Inspiron</option>
                                    <option value="2">PROD002 - Mouse Inalámbrico</option>
                                    <option value="3">PROD003 - Teclado Mecánico</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="cantidad">Cantidad</label>
                                <input type="number" id="cantidad" name="cantidad" required>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <label for="almacen">Almacén</label>
                                <select id="almacen" name="almacen" required>
                                    <option value="">Seleccionar almacén</option>
                                    <option value="principal">Almacén Principal</option>
                                    <option value="secundario">Almacén Secundario</option>
                                    <option value="deposito">Depósito Norte</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="responsable">Responsable</label>
                                <input type="text" id="responsable" name="responsable" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="motivoMovimiento">Motivo</label>
                            <textarea id="motivoMovimiento" name="motivoMovimiento" rows="2"></textarea>
                        </div>
                        <div class="form-group">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i> Registrar Movimiento
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