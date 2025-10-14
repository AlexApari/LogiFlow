<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.logiflow.model.*"%>
<%@ page import="com.logiflow.controller.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>



<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>LogiFlow - Gestión de Usuarios</title>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/Style.css">
</head>
<body>
	<%@ include file="includes/Header.jsp"%>
	
	<div class="container">
		<%@ include file="includes/Sidebar.jsp"%>
		<main class="main-content">
		<section id="usuarios" class="form-section active">
			<div class="page-header">
				<h2 class="page-title">
					<i class="fas fa-users-cog me-2"></i>Gestión de Usuarios
				</h2>
				<p class="page-subtitle">Administrar usuarios del sistema y
					asignar roles</p>
			</div>
			<!-- Formulario de Usuario -->
			<div class="content-card">
				<div class="d-flex justify-content-between align-items-center mb-4">
					<h3>
						<c:choose>
							<c:when test="${usuario.id ne null}">
								<i class="fas fa-user-edit me-2 text-warning"></i>Editar Usuario
                                    </c:when>
							<c:otherwise>
								<i class="fas fa-user-plus me-2 text-success"></i>Nuevo Usuario
                                    </c:otherwise>
						</c:choose>
					</h3>
					<button type="button" class="btn btn-outline-secondary"
						onclick="limpiarFormulario()">
						<i class="fas fa-plus me-2"></i>Nuevo
					</button>
				</div>
				<form action="${pageContext.request.contextPath}/usuarios/guardar"
					method="post">
					<input type="hidden" name="id" value="${usuario.id}" />
					<div class="row">
						<div class="col-md-4">
							<div class="mb-3">
								<label for="username" class="form-label">Usuario <span
									class="text-danger">*</span></label>
								<div class="input-group">
									<span class="input-group-text"><i class="fas fa-user"></i></span>
									<input id="username" name="username" class="form-control"
										placeholder="nombre.usuario" required
										pattern="[a-zA-Z0-9._]{3,50}"
										title="Solo letras, números, punto y guión bajo. Mínimo 3 caracteres"
										value="${usuario.username}" />
								</div>
								<small class="text-muted">Mínimo 3 caracteres, sin
									espacios</small>
							</div>
						</div>
						<div class="col-md-4">
							<div class="mb-3">
								<label for="email" class="form-label">Email <span
									class="text-danger">*</span></label>
								<div class="input-group">
									<span class="input-group-text"><i
										class="fas fa-envelope"></i></span> <input id="email" name="email" type="email"
										class="form-control" placeholder="usuario@logiflow.com"
										required value="${usuario.email}" />
								</div>
							</div>
						</div>
						<div class="col-md-4">
							<div class="mb-3">
								<label for="password" class="form-label"> <c:choose>
										<c:when test="${usuario.id ne null}">
                                                    Nueva Contraseña <span
												class="text-muted">(dejar vacío para mantener)</span>
										</c:when>
										<c:otherwise>
                                                    Contraseña <span
												class="text-danger">*</span>
										</c:otherwise>
									</c:choose>
								</label>
								<div class="input-group">
									<span class="input-group-text"><i class="fas fa-lock"></i></span>
									<input id="password" name="password" type="password" class="form-control"
										placeholder="••••••••"
										<c:if test="${usuario.id eq null}">required minlength="6"</c:if> />
									<button class="btn btn-outline-secondary" type="button"
										onclick="togglePassword()">
										<i class="fas fa-eye" id="toggleIcon"></i>
									</button>
								</div>
								<small class="text-muted">Mínimo 6 caracteres</small>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-4">
							<div class="mb-3">
								<label for="nombre" class="form-label">Nombre <span
									class="text-danger">*</span></label> <input id="nombre" name="nombre"
									class="form-control" placeholder="Nombre" required
									value="${usuario.nombre}" />
							</div>
						</div>
						<div class="col-md-4">
							<div class="mb-3">
								<label for="apellido" class="form-label">Apellido <span
									class="text-danger">*</span></label> <input id="apellido" name="apellido"
									class="form-control" placeholder="Apellido" required
									value="${usuario.apellido}" />
							</div>
						</div>
						<div class="col-md-4">
							<div class="mb-3">
								<label for="telefono" class="form-label">Teléfono</label>
								<div class="input-group">
									<span class="input-group-text"><i class="fas fa-phone"></i></span>
									<input id="telefono" name="telefono" class="form-control"
										placeholder="999888777" pattern="[0-9]{9}"
										value="${usuario.telefono}" />
								</div>
							</div>
						</div>
					</div>
					<div class="mb-3">
						<label for="direccion" class="form-label">Dirección</label>
						<textarea id="direccion" name="direccion" class="form-control" rows="2"
							placeholder="Dirección completa del usuario">${usuario.direccion}</textarea>
					</div>
					<!-- Asignación de Roles -->
					<div class="mb-3">
						<label class="form-label"><i class="fas fa-user-tag me-2"></i>Roles
							del Usuario <span class="text-danger">*</span></label>
						<div class="row">
							<c:if test="${not empty roles}">
								<c:set var="rolesUsuario" value="${usuario.roles}" />
								<c:forEach var="rol" items="${roles}">
									<c:set var="colorClass" value="" />
									<c:set var="descripcion" value="" />
									<c:choose>
										<c:when test="${rol.nombre eq 'ADMIN'}">
											<c:set var="colorClass" value="danger" />
											<c:set var="descripcion" value="Acceso completo al sistema" />
										</c:when>
										<c:when test="${rol.nombre eq 'OPERATOR'}">
											<c:set var="colorClass" value="success" />
											<c:set var="descripcion"
												value="Gestión operativa (productos, inventario)" />
										</c:when>
										<c:when test="${rol.nombre eq 'USER'}">
											<c:set var="colorClass" value="primary" />
											<c:set var="descripcion"
												value="Acceso básico (consultas, pedidos)" />
										</c:when>
										<c:when test="${rol.nombre eq 'SUPERVISOR'}">
											<c:set var="colorClass" value="warning" />
											<c:set var="descripcion" value="Supervisión de operaciones" />
										</c:when>
										<c:when test="${rol.nombre eq 'VENDEDOR'}">
											<c:set var="colorClass" value="info" />
											<c:set var="descripcion" value="Gestión de ventas" />
										</c:when>
									</c:choose>
									<div class="col-md-6 col-lg-4">
										<div class="card mb-3 usuario-card">
											<div class="card-body">
												<div class="form-check">
													<input type="checkbox" name="roles" value="${rol.id}"
														class="form-check-input" id="rol_${rol.id}"
														<c:if test="${rolesUsuario ne null and fn:contains(rolesUsuario, rol)}">checked</c:if> />
													<label class="form-check-label" for="rol_${rol.id}">
														<strong class="text-${colorClass}"><i
															class="fas fa-shield-alt me-1"></i>${rol.nombre}</strong><br>
														<small class="text-muted">${descripcion}</small>
													</label>
												</div>
											</div>
										</div>
									</div>
								</c:forEach>
							</c:if>
						</div>
						<small class="text-muted">Selecciona al menos un rol para
							el usuario</small>
					</div>
					<!-- Estado del Usuario -->
					<div class="row">
						<div class="col-md-6">
							<div class="form-check form-switch mb-3">
								<input type="checkbox" name="activo" class="form-check-input"
									id="activo" <c:if test="${usuario.activo}">checked</c:if> /> <label
									class="form-check-label" for="activo"> <strong>Usuario
										Activo</strong><br> <small class="text-muted">Usuarios
										inactivos no pueden iniciar sesión</small>
								</label>
							</div>
						</div>
						<c:if test="${usuario.id ne null}">
							<div class="col-md-6">
								<div class="form-check form-switch mb-3">
									<input type="checkbox" name="bloqueado"
										class="form-check-input" id="bloqueado"
										<c:if test="${usuario.bloqueado}">checked</c:if> /> <label
										class="form-check-label" for="bloqueado"> <strong
										class="text-danger">Usuario Bloqueado</strong><br> <small
										class="text-muted">Bloquear por seguridad</small>
									</label>
								</div>
							</div>
						</c:if>
					</div>
					<!-- Botones de acción -->
					<div class="d-flex gap-2">
						<button type="submit" class="btn btn-primary">
							<i class="fas fa-save me-2"></i>
							<c:choose>
								<c:when test="${usuario.id ne null}">Actualizar Usuario</c:when>
								<c:otherwise>Crear Usuario</c:otherwise>
							</c:choose>
						</button>
						<button type="reset" class="btn btn-secondary"
							onclick="limpiarFormulario()">
							<i class="fas fa-undo me-2"></i>Limpiar
						</button>
						<c:if test="${usuario.id ne null}">
							<button type="button" class="btn btn-danger"
								onclick="confirmarEliminacion(${usuario.id}, '${usuario.username}')">
								<i class="fas fa-trash me-2"></i>Eliminar Usuario
							</button>
						</c:if>
					</div>
				</form>
			</div>
			<!-- Lista de Usuarios -->
			<div class="content-card">
				<div class="d-flex justify-content-between align-items-center mb-3">
					<h3>
						<i class="fas fa-users me-2"></i>Lista de Usuarios del Sistema
					</h3>
					<div class="d-flex gap-2">
						<form action="${pageContext.request.contextPath}/usuarios"
							method="get" class="d-flex gap-2">
							<select name="rolFiltro" class="form-select form-select-sm"
								onchange="this.form.submit()">
								<option value="">Filtrar por rol</option>
								<option value="TODOS">Todos los roles</option>
								<option value="ADMIN">Administradores</option>
								<option value="OPERATOR">Operadores</option>
								<option value="USER">Usuarios</option>
								<option value="SUPERVISOR">Supervisores</option>
								<option value="VENDEDOR">Vendedores</option>
							</select> <select name="estadoFiltro" class="form-select form-select-sm"
								onchange="this.form.submit()">
								<option value="">Filtrar por estado</option>
								<option value="TODOS">Todos los estados</option>
								<option value="activos">Solo Activos</option>
								<option value="inactivos">Solo Inactivos</option>
								<option value="bloqueados">Bloqueados</option>
							</select> <input type="text" name="buscar"
								class="form-control form-control-sm"
								placeholder="Buscar usuario..." value="${param.buscar}"
								style="width: 200px;">
							<button type="submit" class="btn btn-outline-primary btn-sm">
								<i class="fas fa-search"></i>
							</button>
						</form>
						<button type="button" class="btn btn-success btn-sm"
							onclick="exportarExcel()">
							<i class="fas fa-file-excel me-1"></i>Excel
						</button>
					</div>
				</div>
				<div class="table-responsive">
					<table class="table table-hover">
						<thead>
							<tr>
								<th>ID</th>
								<th>Usuario</th>
								<th>Nombre Completo</th>
								<th>Email</th>
								<th>Teléfono</th>
								<th>Roles</th>
								<th>Estado</th>
								<th>Último Acceso</th>
								<th>Acciones</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty usuarios}">
									<c:forEach var="usr" items="${usuarios}">
										<tr>
											<td><strong>#${usr.id}</strong></td>
											<td>
												<div class="d-flex align-items-center">
													<div class="avatar-circle bg-primary text-white me-2"
														style="width: 35px; height: 35px; border-radius: 50%; display: flex; align-items: center; justify-content: center;">
														<strong><c:out
																value="${fn:toUpperCase(fn:substring(usr.username,0,1))}"
																default="?" /></strong>
													</div>
													<strong>${usr.username}</strong>
												</div>
											</td>
											<td>${usr.nombre}${usr.apellido}</td>
											<td><i class="fas fa-envelope text-muted me-1"></i>${usr.email}</td>
											<td><c:choose>
													<c:when test="${not empty usr.telefono}">
														<i class="fas fa-phone text-muted me-1"></i>${usr.telefono}
                                        </c:when>
													<c:otherwise>
														<span class="text-muted">-</span>
													</c:otherwise>
												</c:choose></td>
											<td><c:choose>
													<c:when test="${not empty usr.roles}">
														<c:forEach var="rol" items="${usr.roles}">
															<span class="rol-badge badge-${rol.nombre}">${rol.nombre}</span>
														</c:forEach>
													</c:when>
													<c:otherwise>
														<span class="badge bg-secondary">Sin Rol</span>
													</c:otherwise>
												</c:choose></td>
											<td><c:choose>
													<c:when test="${usr.bloqueado}">
														<span class="badge bg-danger"><i
															class="fas fa-lock me-1"></i>Bloqueado</span>
													</c:when>
													<c:when test="${usr.activo}">
														<span class="badge bg-success"><i
															class="fas fa-check-circle me-1"></i>Activo</span>
													</c:when>
													<c:otherwise>
														<span class="badge bg-secondary"><i
															class="fas fa-times-circle me-1"></i>Inactivo</span>
													</c:otherwise>
												</c:choose></td>
											<td><c:choose>
													<c:when test="${not empty usr.ultimoAcceso}">
														<small><fmt:formatDate value="${usr.ultimoAcceso}"
																pattern="dd/MM/yyyy HH:mm" /></small>
													</c:when>
													<c:otherwise>
														<span class="text-muted">Nunca</span>
													</c:otherwise>
												</c:choose></td>
											<td>
												<div class="btn-group btn-group-sm" role="group">
													<button type="button" class="btn btn-outline-info"
														onclick="verDetalle(${usr.id})" title="Ver detalles">
														<i class="fas fa-eye"></i>
													</button>
													<a
														href="${pageContext.request.contextPath}/usuarios/editar/${usr.id}"
														class="btn btn-outline-primary" title="Editar"><i
														class="fas fa-edit"></i></a>
													<button type="button" class="btn btn-outline-secondary"
														onclick="abrirAsignarRol(${usr.id}, '${usr.username}')"
														title="Asignar Rol">
														<i class="fas fa-user-shield"></i>
													</button>
													<c:if test="${usr.id ne 1}">
														<button type="button" class="btn btn-outline-danger"
															onclick="confirmarEliminacion(${usr.id}, '${usr.username}')"
															title="Eliminar">
															<i class="fas fa-trash"></i>
														</button>
													</c:if>
												</div>
											</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="9" class="text-center py-5"><i
											class="fas fa-users fa-3x text-muted mb-3"></i>
											<p class="text-muted">No se encontraron usuarios</p></td>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
				<!-- Paginación -->
				<c:if test="${totalPaginas > 1}">
					<nav aria-label="Navegación de páginas">
						<ul class="pagination justify-content-center">
							<c:if test="${paginaActual > 0}">
								<li class="page-item"><a class="page-link"
									href="?pagina=${paginaActual - 1}">Anterior</a></li>
							</c:if>
							<c:forEach begin="0" end="${totalPaginas - 1}" var="i">
								<li class="page-item ${i == paginaActual ? 'active' : ''}"><a
									class="page-link" href="?pagina=${i}">${i + 1}</a></li>
							</c:forEach>
							<c:if test="${paginaActual < totalPaginas - 1}">
								<li class="page-item"><a class="page-link"
									href="?pagina=${paginaActual + 1}">Siguiente</a></li>
							</c:if>
						</ul>
					</nav>
				</c:if>
			</div>
			<!-- Modal Asignar Rol -->
			<div class="modal fade" id="asignarRolModal" tabindex="-1">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title">
								<i class="fas fa-user-shield me-2"></i>Asignar Rol a Usuario
							</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
						</div>
						<form id="asignarRolForm"
							action="${pageContext.request.contextPath}/usuarios/asignarRol"
							method="post">
							<div class="modal-body">
								<input type="hidden" name="usuarioId" id="asignarRolUsuarioId" />
								<div class="mb-3">
									<label for="asignarRolUsuario" class="form-label">Usuario</label>
									<input type="text" class="form-control" id="asignarRolUsuario"
										readonly />
								</div>
								<div class="mb-3">
									<label for="asignarRolSelect" class="form-label">Rol</label> <select
										id="asignarRolSelect" name="rolId" class="form-select"
										required>
										<option value="">Seleccionar rol</option>
										<c:forEach var="rol" items="${roles}">
											<option value="${rol.id}">${rol.nombre}</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="modal-footer">
								<button type="submit" class="btn btn-primary">
									<i class="fas fa-user-shield"></i> Asignar Rol
								</button>
								<button type="button" class="btn btn-secondary"
									data-bs-dismiss="modal">
									<i class="fas fa-undo"></i> Cancelar
								</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</section>
		</main>
	</div>
	<!-- Modal de detalles -->
	<div class="modal fade" id="detalleModal" tabindex="-1">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">
						<i class="fas fa-user-circle me-2"></i>Detalles del Usuario
					</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<div class="modal-body" id="detalleContenido">
					<!-- Contenido cargado por AJAX -->
				</div>
			</div>
		</div>
	</div>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
	<script>
        function limpiarFormulario() {
            window.location.href = '${pageContext.request.contextPath}/usuarios/nuevo';
        }
        function togglePassword() {
            const passwordInput = document.querySelector('input[name="password"]');
            const toggleIcon = document.getElementById('toggleIcon');
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                toggleIcon.classList.remove('fa-eye');
                toggleIcon.classList.add('fa-eye-slash');
            } else {
                passwordInput.type = 'password';
                toggleIcon.classList.remove('fa-eye-slash');
                toggleIcon.classList.add('fa-eye');
            }
        }
        function confirmarEliminacion(id, username) {
            if (confirm('¿Está seguro que desea eliminar al usuario "' + username + '"?\n\nEsta acción no se puede deshacer.')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/usuarios/eliminar/' + id;
                document.body.appendChild(form);
                form.submit();
            }
        }
        function verDetalle(id) {
            fetch('${pageContext.request.contextPath}/usuarios/detalle/' + id)
                .then(response => response.text())
                .then(html => {
                    document.getElementById('detalleContenido').innerHTML = html;
                    new bootstrap.Modal(document.getElementById('detalleModal')).show();
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Error al cargar los detalles del usuario');
                });
        }
        function exportarExcel() {
            window.open('${pageContext.request.contextPath}/usuarios/exportar/excel', '_blank');
        }
        function abrirAsignarRol(id, username) {
    document.getElementById('asignarRolUsuarioId').value = id;
    document.getElementById('asignarRolUsuario').value = username;
    document.getElementById('asignarRolSelect').selectedIndex = 0;
    new bootstrap.Modal(document.getElementById('asignarRolModal')).show();
}
        // Validación de formulario
        document.querySelector('form').addEventListener('submit', function(e) {
            const rolesCheckboxes = document.querySelectorAll('input[name="roles"]:checked');
            if (rolesCheckboxes.length === 0) {
                e.preventDefault();
                alert('Debe seleccionar al menos un rol para el usuario');
                return false;
            }
            const password = document.querySelector('input[name="password"]').value;
            var esEdicion = ${usuario.id ne null ? 'true' : 'false'};
            if (!esEdicion && password.length < 6) {
                e.preventDefault();
                alert('La contraseña debe tener al menos 6 caracteres');
                return false;
            }
        });
        // Contador de caracteres para username
        document.querySelector('input[name="username"]').addEventListener('input', function(e) {
            const value = e.target.value;
            const contador = value.length;
            console.log('Username: ' + contador + ' caracteres');
        });
    </script>
</body>
</html>