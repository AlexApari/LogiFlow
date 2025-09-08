<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>LogiFlow - Productos</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Style.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<%@ include file= "includes/Header.jsp" %>
    <div class="container">
       <%@ include file="includes/Sidebar.jsp" %>
        <main class="main-content">
            <!-- Productos Section -->
            <section id="productos" class="form-section active">
                <div class="page-header">
                    <h2 class="page-title">Gestión de Productos</h2>
                    <p class="page-subtitle">Administrar catálogo de productos</p>
                </div>
                <div class="content-card">
                    <h3>Nuevo Producto</h3>
                    <form id="productForm">
                        <div class="form-row">
                            <div class="form-group">
                                <label for="codProducto">Código del Producto</label>
                                <input type="text" id="codProducto" name="codProducto" required>
                            </div>
                            <div class="form-group">
                                <label for="nombreProducto">Nombre del Producto</label>
                                <input type="text" id="nombreProducto" name="nombreProducto" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="descripcion">Descripción</label>
                            <textarea id="descripcion" name="descripcion" rows="3"></textarea>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <label for="categoria">Categoría</label>
                                <select id="categoria" name="categoria" required>
                                    <option value="">Seleccionar categoría</option>
                                    <option value="electronica">Electrónica</option>
                                    <option value="ropa">Ropa</option>
                                    <option value="hogar">Hogar</option>
                                    <option value="deportes">Deportes</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="precio">Precio</label>
                                <input type="number" id="precio" name="precio" step="0.01" required>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <label for="stock">Stock Inicial</label>
                                <input type="number" id="stock" name="stock" required>
                            </div>
                            <div class="form-group">
                                <label for="stockMinimo">Stock Mínimo</label>
                                <input type="number" id="stockMinimo" name="stockMinimo" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i> Guardar Producto
                            </button>
                            <button type="reset" class="btn btn-secondary">
                                <i class="fas fa-undo"></i> Limpiar
                            </button>
                        </div>
                    </form>
                </div>
                <div class="content-card">
                    <h3>Lista de Productos</h3>
                    <div class="table-container">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Código</th>
                                    <th>Nombre</th>
                                    <th>Categoría</th>
                                    <th>Precio</th>
                                    <th>Stock</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody id="productosTable">
                                <tr>
                                    <td>PROD001</td>
                                    <td>Laptop Dell Inspiron</td>
                                    <td>Electrónica</td>
                                    <td>$899.00</td>
                                    <td>25</td>
                                    <td class="action-buttons">
                                        <button class="btn btn-sm btn-primary">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="btn btn-sm btn-danger">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </section>

        </main>
        </div>
</body>
</html>