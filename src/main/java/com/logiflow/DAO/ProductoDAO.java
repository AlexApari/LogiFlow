package com.logiflow.DAO;

import java.sql.*;
import java.util.*;
import com.logiflow.model.Producto;
import com.logiflow.model.Categoria;
import com.logiflow.model.ConexionBD;

public class ProductoDAO {

    // CREATE
    public void agregarProducto(Producto p) {
    	System.out.println("[DAO] Agregando producto: " + p.getNombre());
        String sql = "INSERT INTO productos (codigo, nombre, descripcion, categoria_id, precio, stock_inicial, stock_minimo, stock_actual) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        System.out.println("[DAO] Ejecutando consulta: " + sql);

        try (Connection con = ConexionBD.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, p.getCodigo());
            ps.setString(2, p.getNombre());
            ps.setString(3, p.getDescripcion());
            long categoriaIdLong = p.getCategoria().getId();
            int categoriaId = (int) categoriaIdLong; // conversión segura
            ps.setInt(4, categoriaId); // según nombre
            ps.setDouble(5, p.getPrecio());
            ps.setInt(6, p.getStockInicial());
            ps.setInt(7, p.getStockMinimo());
            ps.setInt(8, p.getStockActual()); // stock_actual inicia igual que stock_inicial
            System.out.println("[DAO] Ejecutando consulta: " + p);
            int filas = ps.executeUpdate();
            System.out.println("[DAO] Filas afectadas: " + filas);
        } catch (Exception e) {
        	System.out.println("[DAO] Error al agregar productos: " + e.getMessage());
            e.printStackTrace();
        }
    }

    // READ
    public List<Producto> listarProductos() {
    	System.out.println("[DAO] Listando productos...");
        List<Producto> lista = new ArrayList<>();
        String sql = "SELECT p.id, p.codigo, p.nombre, p.descripcion, c.nombre AS categoria, p.precio, p.stock_actual, p.stock_minimo "
                   + "FROM productos p LEFT JOIN categorias c ON p.categoria_id = c.id";
        System.out.println("[DAO] Ejecutando consulta: " + sql);

        try (Connection con = ConexionBD.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Producto p = new Producto();
                p.setId(rs.getLong("id"));
                p.setCodigo(rs.getString("codigo"));
                p.setNombre(rs.getString("nombre"));
                p.setDescripcion(rs.getString("descripcion"));
                Categoria c = new Categoria();
                c.setNombre(rs.getString("nombre"));
                p.setCategoria(c);
                p.setPrecio(rs.getDouble("precio"));
                p.setStockActual(rs.getInt("stock_actual"));
                p.setStockMinimo(rs.getInt("stock_minimo"));
                lista.add(p);
                System.out.println("[DAO] Producto encontrado: " + p.getNombre());
            }
            System.out.println("[DAO] Total de productos encontrados: " + lista.size());
        } catch (Exception e) {
        	System.out.println("[DAO] Error al listar productos: " + e.getMessage());
            e.printStackTrace();
        }
        return lista;
    }

    // UPDATE
    public void actualizarProducto(Producto p) {
    	System.out.println("[DAO] Actualizando producto: " + p.getNombre());
        String sql = "UPDATE productos SET nombre=?, descripcion=?, categoria_id=?, precio=?, stock_actual=?, stock_minimo=? WHERE codigo=?";
        System.out.println("[DAO] Ejecutando consulta: " + sql);
        try (Connection con = ConexionBD.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, p.getNombre());
            ps.setString(2, p.getDescripcion());
            long categoriaIdLong = p.getCategoria().getId();
            int categoriaId = (int) categoriaIdLong; // conversión segura
            ps.setInt(3, categoriaId); // según nombre
            ps.setDouble(4, p.getPrecio());
            ps.setInt(5, p.getStockInicial());
            ps.setInt(6, p.getStockMinimo());
            ps.setString(7, p.getCodigo());
            ps.executeUpdate();
            System.out.println("[DAO] Producto actualizado: " + p.getNombre());
        } catch (Exception e) {
        	System.out.println("[DAO] Error al actualizar producto: " + e.getMessage());
            e.printStackTrace();
        }
    }

    // DELETE
    public void eliminarProducto(String codigo) {
    	System.out.println("[DAO] Eliminando producto con código: " + codigo);
        String sql = "DELETE FROM productos WHERE codigo=?";
        System.out.println("[DAO] Ejecutando consulta: " + sql);
        try (Connection con = ConexionBD.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, codigo);
            ps.executeUpdate();
            System.out.println("[DAO] Producto eliminado con código: " + codigo);
        } catch (Exception e) {
        	System.out.println("[DAO] Error al eliminar producto: " + e.getMessage());
            e.printStackTrace();
        }
    }


}