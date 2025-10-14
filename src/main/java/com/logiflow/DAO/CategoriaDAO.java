package com.logiflow.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;
import com.logiflow.model.Categoria;
import com.logiflow.model.ConexionBD;

public class CategoriaDAO {

	public static Categoria obtenerCategoriaPorNombre(String nombre) {
		String sql="SELECT * FROM categorias WHERE nombre = ?";
		Categoria categoria = null;
		try (Connection conn = ConexionBD.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, nombre);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					categoria = new Categoria();
					categoria.setId(rs.getLong("id"));
					categoria.setNombre(rs.getString("nombre"));
					categoria.setDescripcion(rs.getString("descripcion"));
					categoria.setImagen(rs.getString("imagen"));
					categoria.setActiva(rs.getBoolean("activa"));
					categoria.setOrden(rs.getInt("orden"));
					categoria.setFechaCreacion(rs.getTimestamp("fecha_creacion").toLocalDateTime());
					categoria.setFechaModificacion(rs.getTimestamp("fecha_modificacion").toLocalDateTime());
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return categoria;
	}
	public static List<Categoria> listarCategorias() {
		List<Categoria> categorias = new ArrayList<>();
		String sql = "SELECT * FROM categorias ORDER BY orden ASC";
		try (Connection conn = ConexionBD.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql);
			 ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				Categoria c = new Categoria();
				c.setId(rs.getLong("id"));
				c.setNombre(rs.getString("nombre"));
				c.setDescripcion(rs.getString("descripcion"));
				c.setImagen(rs.getString("imagen"));
				c.setActiva(rs.getBoolean("activa"));
				c.setOrden(rs.getInt("orden"));
				c.setFechaCreacion(rs.getTimestamp("fecha_creacion").toLocalDateTime());
				c.setFechaModificacion(rs.getTimestamp("fecha_modificacion").toLocalDateTime());
				categorias.add(c);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return categorias;
	}
	public static Categoria obtenerCategoriaPorId(long id) {
		String sql = "SELECT * FROM categorias WHERE id = ?";
		Categoria categoria = null;
		try (Connection conn = ConexionBD.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setLong(1, id);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					categoria = new Categoria();
					categoria.setId(rs.getLong("id"));
					categoria.setNombre(rs.getString("nombre"));
					categoria.setDescripcion(rs.getString("descripcion"));
					categoria.setImagen(rs.getString("imagen"));
					categoria.setActiva(rs.getBoolean("activa"));
					categoria.setOrden(rs.getInt("orden"));
					categoria.setFechaCreacion(rs.getTimestamp("fecha_creacion").toLocalDateTime());
					categoria.setFechaModificacion(rs.getTimestamp("fecha_modificacion").toLocalDateTime());
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return categoria;
	}
}