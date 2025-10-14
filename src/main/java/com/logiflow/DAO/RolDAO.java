package com.logiflow.DAO;

import java.sql.*;
import java.util.*;
import com.logiflow.model.ConexionBD;
import com.logiflow.model.Rol;

public class RolDAO {
    public static List<Rol> listarRoles() {
        List<Rol> roles = new ArrayList<>();
        String sql = "SELECT * FROM roles";
        try (Connection conn = ConexionBD.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Rol r = new Rol();
                r.setId(rs.getLong("id"));
                r.setNombre(rs.getString("nombre"));
                r.setDescripcion(rs.getString("descripcion"));
                r.setActivo(rs.getBoolean("activo"));
                r.setFechaCreacion(rs.getTimestamp("fecha_creacion"));
                roles.add(r);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return roles;
    }

    public static Set<Rol> obtenerRolesPorUsuario(Long usuarioId) {
        Set<Rol> roles = new HashSet<>();
        String sql = "SELECT r.* FROM roles r JOIN usuario_roles ur ON r.id = ur.rol_id WHERE ur.usuario_id = ?";
        try (Connection conn = ConexionBD.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, usuarioId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Rol r = new Rol();
                    r.setId(rs.getLong("id"));
                    r.setNombre(rs.getString("nombre"));
                    r.setDescripcion(rs.getString("descripcion"));
                    r.setActivo(rs.getBoolean("activo"));
                    r.setFechaCreacion(rs.getTimestamp("fecha_creacion"));
                    roles.add(r);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return roles;
    }

    public static void actualizarRolesUsuario(Long usuarioId, Set<Rol> roles) {
        if (usuarioId == null) return;
        String delete = "DELETE FROM usuario_roles WHERE usuario_id=?";
        String insert = "INSERT INTO usuario_roles (usuario_id, rol_id) VALUES (?,?)";
        try (Connection conn = ConexionBD.getConnection()) {
            try (PreparedStatement ps = conn.prepareStatement(delete)) {
                ps.setLong(1, usuarioId);
                ps.executeUpdate();
            }
            if (roles != null) {
                for (Rol rol : roles) {
                    try (PreparedStatement ps = conn.prepareStatement(insert)) {
                        ps.setLong(1, usuarioId);
                        ps.setLong(2, rol.getId());
                        ps.executeUpdate();
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
