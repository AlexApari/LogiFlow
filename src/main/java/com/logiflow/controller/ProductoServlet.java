package com.logiflow.controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.logiflow.DAO.CategoriaDAO;
import com.logiflow.DAO.ProductoDAO;
import com.logiflow.model.Categoria;
import com.logiflow.model.Producto;

@WebServlet("/ProductoServlet")
public class ProductoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ProductoDAO dao = new ProductoDAO();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String accion = request.getParameter("accion");
		System.out.println("[SERVLET] Acción detectada: " + accion);
		if (accion == null)
			accion = "listar";

		switch (accion) {
		case "listar":
			try {
				List<Producto> lista = dao.listarProductos();
				System.out.println("[SERVLET] Productos listados: " + lista.size());
				request.setAttribute("productos", lista);

				// Cargar categorías y enviarlas al JSP
				CategoriaDAO categoriaDAO = new CategoriaDAO();
				List<Categoria> categorias = categoriaDAO.listarCategorias();
				request.setAttribute("categorias", categorias);

				request.getRequestDispatcher("Productos.jsp").forward(request, response);
			} catch (Exception e) {
				System.out.println("[SERVLET] Error al listar productos: " + e.getMessage());
				e.printStackTrace();
			}
			break;
		case "nuevo": // acción para mostrar el formulario de agregar producto
			CategoriaDAO categoriaDAO2 = new CategoriaDAO();
			List<Categoria> categorias2 = categoriaDAO2.listarCategorias();
			System.out.println("[SERVLET] Categorías cargadas: " + categorias2.size());
			request.setAttribute("categorias", categorias2);
			request.getRequestDispatcher("ProductoForm.jsp").forward(request, response);
			break;

		case "eliminar":
			String codigo = request.getParameter("codigo");
			System.out.println("[SERVLET] Eliminando producto con código: " + codigo);
			try {
				dao.eliminarProducto(codigo);
				System.out.println("[SERVLET] Producto eliminado: " + codigo);
			} catch (Exception e) {
				System.out.println("[SERVLET] Error al eliminar producto: " + e.getMessage());
				e.printStackTrace();
			}
			response.sendRedirect("ProductoServlet?accion=listar");
			break;

		default:
			response.sendRedirect("ProductoServlet?accion=listar");
			break;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String accion = request.getParameter("accion");
		System.out.println("[SERVLET] Entró a doPost() con acción: " + accion);
		if ("agregar".equals(accion)) {
			Producto p = new Producto();
			p.setCodigo(request.getParameter("codProducto"));
			p.setNombre(request.getParameter("nombreProducto"));
			p.setDescripcion(request.getParameter("descripcion"));
			String categoriaIdStr = request.getParameter("categoriaId");
			Categoria c = null;
			if (categoriaIdStr != null && !categoriaIdStr.isEmpty()) {
				try {
					long categoriaId = Long.parseLong(categoriaIdStr);
					c = CategoriaDAO.obtenerCategoriaPorId(categoriaId);
				} catch (NumberFormatException e) {
					System.out.println("[SERVLET] ID de categoría inválido: " + categoriaIdStr);
				}
			}
			p.setCategoria(c);
			p.setPrecio(Double.parseDouble(request.getParameter("precio")));
			p.setStockInicial(Integer.parseInt(request.getParameter("stock")));
			p.setStockMinimo(Integer.parseInt(request.getParameter("stockMinimo")));
			System.out.println("[SERVLET] Producto a agregar: " + p);
			try {
				dao.agregarProducto(p);
				System.out.println("[SERVLET] Producto agregado exitosamente: " + p.getNombre());
			} catch (Exception e) {
				System.out.println("[SERVLET] Error al agregar producto: " + e.getMessage());
				e.printStackTrace();
			}
		} else if ("actualizar".equals(accion)) {
			Producto p = new Producto();
			p.setCodigo(request.getParameter("codProducto"));
			p.setNombre(request.getParameter("nombreProducto"));
			p.setDescripcion(request.getParameter("descripcion"));
			String nombreCat = request.getParameter("categoria");
			Categoria c = CategoriaDAO.obtenerCategoriaPorNombre(nombreCat);
			p.setCategoria(c);
			p.setPrecio(Double.parseDouble(request.getParameter("precio")));
			p.setStockInicial(Integer.parseInt(request.getParameter("stock")));
			p.setStockMinimo(Integer.parseInt(request.getParameter("stockMinimo")));
			dao.actualizarProducto(p);
		}
		response.sendRedirect("ProductoServlet?accion=listar");
	}
}