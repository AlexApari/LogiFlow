package com.logiflow.DAO;

import java.sql.*;
import java.util.*;

import com.logiflow.model.ConexionBD;
import com.logiflow.model.Usuario;

public class UsuarioDAO {
	public static List<Usuario> listarUsuarios(String rolFiltro, String estadoFiltro, String buscar) {
		List<Usuario> usuarios = new ArrayList<>();
		System.out.println("=== [DAO] Iniciando listarUsuarios ===");
		System.out.println(
				"[DAO] Parámetros recibidos → Rol: " + rolFiltro + ", Estado: " + estadoFiltro + ", Buscar: " + buscar);
		StringBuilder sql = new StringBuilder("SELECT u.*, r.nombre AS rol_nombre " + "FROM usuarios u "
				+ "JOIN usuario_roles ur ON u.id = ur.usuario_id " + "JOIN roles r ON ur.rol_id = r.id "
				+ "WHERE 1=1 ");

		if (rolFiltro != null && !rolFiltro.isEmpty()) {
		    if (!"TODOS".equalsIgnoreCase(rolFiltro)) {
		        sql.append("AND r.nombre = ? ");
		        System.out.println("[DAO] → Se agregará filtro por rol: " + rolFiltro);
		    } else {
		        System.out.println("[DAO] → RolFiltro = TODOS → No se aplicará restricción de rol.");
		    }
		} else {
		    System.out.println("[DAO] → Sin filtro de rol (null o vacío).");
		}

		if (estadoFiltro != null && !estadoFiltro.isEmpty()) {
			switch (estadoFiltro) {
			case "activos":
				sql.append("AND u.activo = 1 ");
				System.out.println("[DAO] → Filtro por estado: activos");
				break;
			case "inactivos":
				sql.append("AND u.activo = 0 ");
				System.out.println("[DAO] → Filtro por estado: inactivos");
				break;
			case "bloqueados":
				sql.append("AND u.bloqueado = 1 ");
				System.out.println("[DAO] → Filtro por estado: bloqueados");
				break;
			default:
				System.out.println("[DAO] → Sin filtro por estado aplicado");
				break;
			}
		}

		if (buscar != null && !buscar.isEmpty()) {
			sql.append("AND (u.username LIKE ? OR u.nombre LIKE ? OR u.apellido LIKE ?) ");
			System.out.println("[DAO] → Se agregará filtro de búsqueda: " + buscar);
		}
		sql.append("ORDER BY u.id DESC");
		System.out.println("[DAO] Consulta SQL generada: " + sql.toString());

		try (Connection con = ConexionBD.getConnection(); PreparedStatement ps = con.prepareStatement(sql.toString())) {

			int paramIndex = 1;

			// Asignar parámetros dinámicamente
			if (rolFiltro != null && !rolFiltro.isEmpty() && !rolFiltro.equals("TODOS")) {
				ps.setString(paramIndex++, rolFiltro);
				System.out.println("[DAO] Parámetro de rol asignado: " + rolFiltro);
			}

			if (buscar != null && !buscar.trim().isEmpty()) {
				String like = "%" + buscar.trim() + "%";
				ps.setString(paramIndex++, like);
				ps.setString(paramIndex++, like);
				ps.setString(paramIndex++, like);
				System.out.println("[DAO] Parámetros de búsqueda asignados: " + like);
			}
			System.out.println("[DAO] Ejecutando consulta SQL...");

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Usuario u = new Usuario();
				u.setId(rs.getLong("id"));
				u.setUsername(rs.getString("username"));
				u.setNombre(rs.getString("nombre"));
				u.setApellido(rs.getString("apellido"));
				u.setEmail(rs.getString("email"));
				u.setTelefono(rs.getString("telefono"));
				u.setDireccion(rs.getString("direccion"));
				u.setActivo(rs.getBoolean("activo"));
				u.setBloqueado(rs.getBoolean("bloqueado"));
				// Cargar roles del usuario
				u.setRoles(RolDAO.obtenerRolesPorUsuario(u.getId()));
				usuarios.add(u);
				System.out.println("[DAO] Usuario encontrado: " + u.getUsername() + " con roles: " + u.getRoles());
			}
		} catch (Exception e) {
			System.out.println("[DAO] Error al listar usuarios: " + e.getMessage());
			e.printStackTrace();
		}
		System.out.println("[DAO] Total de usuarios encontrados: " + usuarios.size());
		return usuarios;
	}

	public static Usuario obtenerPorId(long id) {
		String sql = "SELECT * FROM usuarios WHERE id=?";
		try (Connection conn = ConexionBD.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setLong(1, id);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					Usuario u = new Usuario();
					u.setId(rs.getLong("id"));
					u.setUsername(rs.getString("username"));
					u.setNombre(rs.getString("nombre"));
					u.setApellido(rs.getString("apellido"));
					u.setEmail(rs.getString("email"));
					u.setTelefono(rs.getString("telefono"));
					u.setDireccion(rs.getString("direccion"));
					u.setActivo(rs.getBoolean("activo"));
					u.setBloqueado(rs.getBoolean("bloqueado"));
					u.setRoles(RolDAO.obtenerRolesPorUsuario(u.getId()));
					return u;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public static void guardarOActualizar(Usuario usuario) {
		boolean existe = usuario.getId() != null && obtenerPorId(usuario.getId()) != null;
		String sql;
		if (existe) {
			sql = "UPDATE usuarios SET username=?, nombre=?, apellido=?, email=?, telefono=?, direccion=?, activo=?, bloqueado=?, password=? WHERE id=?";
		} else {
			sql = "INSERT INTO usuarios (username, nombre, apellido, email, telefono, direccion, activo, bloqueado, password) VALUES (?,?,?,?,?,?,?,?,?)";
		}
		try (Connection conn = ConexionBD.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
			ps.setString(1, usuario.getUsername());
			ps.setString(2, usuario.getNombre());
			ps.setString(3, usuario.getApellido());
			ps.setString(4, usuario.getEmail());
			ps.setString(5, usuario.getTelefono());
			ps.setString(6, usuario.getDireccion());
			ps.setBoolean(7, usuario.getActivo() != null && usuario.getActivo());
			ps.setBoolean(8, usuario.getBloqueado() != null && usuario.getBloqueado());
			ps.setString(9, usuario.getPassword()); // En producción, hashear la contraseña
			if (existe) {
				ps.setLong(10, usuario.getId());
				ps.executeUpdate();
			} else {
				ps.executeUpdate();
				try (ResultSet rs = ps.getGeneratedKeys()) {
					if (rs.next())
						usuario.setId(rs.getLong(1));
				}
			}
			// Guardar roles
			RolDAO.actualizarRolesUsuario(usuario.getId(), usuario.getRoles());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static void eliminar(long id) {
		try (Connection conn = ConexionBD.getConnection()) {
			RolDAO.actualizarRolesUsuario(id, new HashSet<>()); // Elimina roles
			try (PreparedStatement ps = conn.prepareStatement("DELETE FROM usuarios WHERE id=?")) {
				ps.setLong(1, id);
				ps.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
