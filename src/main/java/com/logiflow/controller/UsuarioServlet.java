package com.logiflow.controller;

import com.logiflow.model.Usuario;
import com.logiflow.model.Rol;
import com.logiflow.DAO.UsuarioDAO;
import com.logiflow.DAO.RolDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.mindrot.jbcrypt.BCrypt;
import java.util.*;


@WebServlet("/usuarios/*")
public class UsuarioServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("=== [SERVLET] Entró al método doGet ===");
		String action = req.getPathInfo() != null ? req.getPathInfo() : "";
		System.out.println("[SERVLET] Acción detectada en pathInfo: " + action);

		try {
			if (action.equals("/exportar/excel")) {
	            System.out.println("[SERVLET] Exportando usuarios a Excel...");
	            exportarExcel(resp);
	            return;
	        }

			if (action.startsWith("/editar/")) {
				long id = Long.parseLong(action.substring("/editar/".length()));
				System.out.println("[SERVLET] Editando usuario con ID: " + id);
				Usuario usuario = UsuarioDAO.obtenerPorId(id);
				req.setAttribute("usuario", usuario);
				req.getSession().setAttribute("usuario", usuario);
			} else {
				System.out.println("[SERVLET] Preparando para crear un nuevo usuario");
				Usuario nuevoUsuario = new Usuario();
				req.setAttribute("usuario", nuevoUsuario);
				req.getSession().setAttribute("usuario", nuevoUsuario);
			}
			String rolFiltro = req.getParameter("rolFiltro");
			String estadoFiltro = req.getParameter("estadoFiltro");
			String buscar = req.getParameter("buscar");

			System.out.println(
					"[SERVLET] Filtros recibidos → Rol: " + rolFiltro + ", Estado: " + estadoFiltro + ", Buscar: " + buscar);
			List<Usuario> usuarios = UsuarioDAO.listarUsuarios(rolFiltro, estadoFiltro, buscar);
			req.setAttribute("usuarios", usuarios);
			req.setAttribute("roles", RolDAO.listarRoles());
			String mensaje = req.getParameter("mensaje");
			String error = req.getParameter("error");
			System.out.println("[SERVLET] Mensaje: " + mensaje);
			System.out.println("[SERVLET] Error: " + error);
			req.setAttribute("mensaje", req.getParameter("mensaje"));
			req.setAttribute("error", req.getParameter("error"));

			req.setAttribute("totalPaginas", 1);
			req.setAttribute("paginaActual", 0);
			System.out.println("[SERVLET] Enviando forward a rol.jsp con usuario: " + req.getAttribute("usuario"));
			req.getRequestDispatcher("/rol.jsp").forward(req, resp);
		} catch (NumberFormatException e) {
			System.out.println("[SERVLET] Error al parsear ID: " + e.getMessage());
			resp.sendRedirect(req.getContextPath() + "/usuarios?error=ID de usuario inválido");
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("=== [SERVLET] Entró al método doPost ===");
		String action = req.getPathInfo() != null ? req.getPathInfo() : "";
		System.out.println("[SERVLET] Acción recibida: " + action);
		if (action.startsWith("/eliminar/")) {
			long id = Long.parseLong(action.substring("/eliminar/".length()));
			System.out.println("[SERVLET] Eliminando usuario con ID: " + id);
			UsuarioDAO.eliminar(id);
			resp.sendRedirect(req.getContextPath() + "/usuarios?mensaje=Usuario eliminado");
			return;
		} else if (action.equals("/guardar")) {

			// Guardar o actualizar usuario
			String idStr = req.getParameter("id");
			System.out.println("[SERVLET] id recibido: " + idStr);
			Usuario usuario = null;
			if (idStr != null && !idStr.isEmpty()) {
				long id = Long.parseLong(idStr);
				usuario = UsuarioDAO.obtenerPorId(id);
				System.out.println("[SERVLET] Usuario existente encontrado: " + (usuario != null));
			}
			if (usuario == null) {
				usuario = new Usuario();
				System.out.println("[SERVLET] Creando nuevo usuario");
			}
			usuario.setUsername(req.getParameter("username"));
			usuario.setNombre(req.getParameter("nombre"));
			usuario.setApellido(req.getParameter("apellido"));
			usuario.setEmail(req.getParameter("email"));
			usuario.setPassword(req.getParameter("password")); // En producción, hashear la contraseña
			usuario.setTelefono(req.getParameter("telefono"));
			usuario.setDireccion(req.getParameter("direccion"));
			usuario.setActivo(req.getParameter("activo") != null);
			usuario.setBloqueado(req.getParameter("bloqueado") != null);
			System.out.println("[SERVLET] Datos del usuario:");
			System.out.println("   Username: " + usuario.getUsername());
			System.out.println("   Nombre: " + usuario.getNombre());
			System.out.println("   Apellido: " + usuario.getApellido());
			System.out.println("   Email: " + usuario.getEmail());
			System.out.println("   Activo: " + usuario.getActivo());
			System.out.println("   Bloqueado: " + usuario.getBloqueado());

			// Roles
			String[] rolesIds = req.getParameterValues("roles");
			System.out.println(
					"[SERVLET] Roles recibidos: " + (rolesIds != null ? String.join(", ", rolesIds) : "Ninguno"));
			Set<Rol> userRoles = new HashSet<>();
			if (rolesIds != null) {
				List<Rol> allRoles = RolDAO.listarRoles();
				for (String rid : rolesIds) {
					long ridLong = Long.parseLong(rid);
					allRoles.stream().filter(r -> r.getId() == ridLong).findFirst().ifPresent(userRoles::add);
				}
			}
			usuario.setRoles(userRoles);
			System.out.println("[SERVLET] Cantidad de roles asignados: " + userRoles.size());

			System.out.println("[SERVLET] Llamando a UsuarioDAO.guardarOActualizar...");
			String passwordPlano = req.getParameter("password");
			if (passwordPlano != null && !passwordPlano.isEmpty()) {
				String hash = BCrypt.hashpw(passwordPlano, BCrypt.gensalt());
				System.out.println("[SERVLET] Hash de la contraseña generado");
				usuario.setPassword(hash);
			}
			UsuarioDAO.guardarOActualizar(usuario);
			resp.sendRedirect(req.getContextPath() + "/usuarios?mensaje=Usuario guardado");
		} else {
			resp.sendRedirect(req.getContextPath() + "/usuarios?error=Accion no reconocida");
			return;
		}
	}
	private void exportarExcel(HttpServletResponse resp) {
	    try {
	    	System.out.println("[SERVLET] Exportando usuarios a Excel...");
	        // Llamamos al DAO para obtener la lista completa
	        List<Usuario> usuarios = UsuarioDAO.listarUsuarios(null, null, null);
	        System.out.println("[SERVLET] Total de usuarios a exportar: " + usuarios.size());
	        // Configurar la respuesta para descargar un archivo Excel
	        resp.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
	        resp.setHeader("Content-Disposition", "attachment; filename=usuarios.xlsx");
	        System.out.println("[DEBUG] commons-io path: " + 
	        	    org.apache.commons.io.IOUtils.class.getProtectionDomain().getCodeSource().getLocation());

	        // Crear el archivo Excel
	        org.apache.poi.ss.usermodel.Workbook workbook = new org.apache.poi.xssf.usermodel.XSSFWorkbook();
	        org.apache.poi.ss.usermodel.Sheet sheet = workbook.createSheet("Usuarios");

	        // Cabeceras
	        org.apache.poi.ss.usermodel.Row header = sheet.createRow(0);
	        header.createCell(0).setCellValue("ID");
	        header.createCell(1).setCellValue("Usuario");
	        header.createCell(2).setCellValue("Nombre");
	        header.createCell(3).setCellValue("Correo");
	        header.createCell(4).setCellValue("Roles");
	        header.createCell(5).setCellValue("Estado");

	        // Llenar datos
	        int rowNum = 1;
	        for (Usuario u : usuarios) {
	            org.apache.poi.ss.usermodel.Row row = sheet.createRow(rowNum++);
	            row.createCell(0).setCellValue(u.getId());
	            row.createCell(1).setCellValue(u.getUsername());
	            row.createCell(2).setCellValue(u.getNombre());
	            row.createCell(3).setCellValue(u.getEmail());
	            String rolesConcatenados = "Sin rol";
	            if (u.getRoles() != null && !u.getRoles().isEmpty()) {
	                rolesConcatenados = String.join(", ",
	                    u.getRoles().stream().map(r -> r.getNombre()).toList());
	            }
	            row.createCell(4).setCellValue(rolesConcatenados);
	            row.createCell(5).setCellValue(u.getActivo() ? "Activo" : "Inactivo");
	        }

	        // Escribir el archivo en la respuesta HTTP
	        workbook.write(resp.getOutputStream());
	        workbook.close();

	        System.out.println("[SERVLET] Exportación a Excel completada correctamente.");

	    } catch (Exception e) {
	        e.printStackTrace();
	        System.out.println("[ERROR] No se pudo exportar a Excel: " + e.getMessage());
	    }
	}

}