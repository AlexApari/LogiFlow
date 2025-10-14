package com.logiflow.model;

import java.time.LocalDateTime;
import java.util.List;

public class Categoria {
    private Long id;
    private String nombre;
    private String descripcion;
    private String imagen;
    private Boolean activa = true;
    private int orden;
    private LocalDateTime fechaCreacion;
    private LocalDateTime fechaModificacion;
    private List<Producto> productos; // Lista de productos en esta categoría
	public List<Producto> getProductos() {
		return productos;
	}
	public void setProductos(List<Producto> productos) {
		this.productos = productos;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public String getImagen() {
		return imagen;
	}
	public void setImagen(String imagen) {
		this.imagen = imagen;
	}
	public Boolean getActiva() {
		return activa;
	}
	public void setActiva(Boolean activa) {
		this.activa = activa;
	}
	public int getOrden() {
		return orden;
	}
	public void setOrden(int orden) {
		this.orden = orden;
	}
	public LocalDateTime getFechaCreacion() {
		return fechaCreacion;
	}
	public void setFechaCreacion(LocalDateTime fechaCreacion) {
		this.fechaCreacion = fechaCreacion;
	}
	public LocalDateTime getFechaModificacion() {
		return fechaModificacion;
	}
	public void setFechaModificacion(LocalDateTime fechaModificacion) {
		this.fechaModificacion = fechaModificacion;
	}

    // Getters y setters
    // ...
    
}
