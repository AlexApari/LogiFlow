package com.logiflow.DAO;
import java.sql.*;

import org.mindrot.jbcrypt.BCrypt;

import com.logiflow.model.ConexionBD;
import com.logiflow.model.Usuario;

public class loginDAO {
	
	public Usuario obtenerPorUsername(String username, String password) {
		// TODO Auto-generated method stub
		Usuario usuario = null;
		String sql = "SELECT * FROM usuarios WHERE username=?";
		
		try (Connection conn = ConexionBD.getConnection();
	
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, username);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					String hashedPassword = rs.getString("password");
					 if (BCrypt.checkpw(password, hashedPassword)) {
						    System.out.println("✅ Contraseña correcta");
						    usuario = new Usuario();
						    usuario.setId(rs.getLong("id"));
						    usuario.setUsername(rs.getString("username"));
						    usuario.setNombre(rs.getString("nombre"));
						    usuario.setRoles(RolDAO.obtenerRolesPorUsuario(usuario.getId()));
						    System.out.println("Usuario logueado: " + usuario.getUsername());
						    System.out.println("Roles: " + usuario.getRoles());
	
					 } else {
						    System.out.println("❌ Contraseña incorrecta");
						}
		            } else {
		                System.out.println("No existe el usuario en la BD ❌");
		            }
		        }
		} catch (Exception e) {
			System.out.println("Error al conectar o ejecutar SQL: " + e.getMessage());
			e.printStackTrace();
			}
		return usuario;
	}
}
