package com.logiflow.model;

import java.time.LocalDateTime;

public class Producto {
	private Long id;                     // Autogenerado
    private String codigo;               // Ingresado por usuario
    private String nombre;               // Ingresado por usuario
    private String descripcion;          // Ingresado por usuario
    private Categoria categoria;            // Selección de combo
    private Long proveedorId;            // Selección de combo
    private double precio;               // Ingresado por usuario
    private double precioCompra;         // Opcional, puede calcularse
    private double margenGanancia;       // Opcional, puede calcularse
    private String unidadMedida;         // Puede ser selección de combo
    private int stockInicial;            // Ingresado por usuario
    private int stockMinimo;             // Ingresado por usuario
    private int stockActual;            // Se asigna en backend
    private int stockMaximo;             // Opcional
    private boolean activo = true;       // Por defecto activo
    private boolean esPerecible = false;// Por defecto no perecible
    private int diasVencimiento;         // Solo si es perecible
    private double peso;                 // Opcional
    private String dimensiones;          // Opcional
    private String ubicacion;            // Opcional
    private String pasillo;              // Opcional
    private String estante;              // Opcional
    private String nivel;                // Opcional
    private String imagen;               // Opcional
    private String codigoBarras;         // Opcional
    private LocalDateTime fechaCreacion; // Se asigna en backend
    private LocalDateTime fechaModificacion; // Se asigna en backend
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getCodigo() {
		return codigo;
	}
	public void setCodigo(String codigo) {
		this.codigo = codigo;
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
	public Categoria getCategoria() {
		return categoria;
	}
	public void setCategoria(Categoria categoria) {
		this.categoria = categoria;
	}
	public Long getProveedorId() {
		return proveedorId;
	}
	public void setProveedorId(Long proveedorId) {
		this.proveedorId = proveedorId;
	}
	public double getPrecio() {
		return precio;
	}
	public void setPrecio(double precio) {
		this.precio = precio;
	}
	public double getPrecioCompra() {
		return precioCompra;
	}
	public void setPrecioCompra(double precioCompra) {
		this.precioCompra = precioCompra;
	}
	public double getMargenGanancia() {
		return margenGanancia;
	}
	public void setMargenGanancia(double margenGanancia) {
		this.margenGanancia = margenGanancia;
	}
	public String getUnidadMedida() {
		return unidadMedida;
	}
	public void setUnidadMedida(String unidadMedida) {
		this.unidadMedida = unidadMedida;
	}
	public int getStockInicial() {
		return stockInicial;
	}
	public void setStockInicial(int stockInicial) {
		this.stockInicial = stockInicial;
	}
	public int getStockMinimo() {
		return stockMinimo;
	}
	public void setStockMinimo(int stockMinimo) {
		this.stockMinimo = stockMinimo;
	}
	public int getStockMaximo() {
		return stockMaximo;
	}
	public void setStockMaximo(int stockMaximo) {
		this.stockMaximo = stockMaximo;
	}
	public boolean isActivo() {
		return activo;
	}
	public void setActivo(boolean activo) {
		this.activo = activo;
	}
	public boolean isEsPerecible() {
		return esPerecible;
	}
	public void setEsPerecible(boolean esPerecible) {
		this.esPerecible = esPerecible;
	}
	public int getDiasVencimiento() {
		return diasVencimiento;
	}
	public void setDiasVencimiento(int diasVencimiento) {
		this.diasVencimiento = diasVencimiento;
	}
	public double getPeso() {
		return peso;
	}
	public void setPeso(double peso) {
		this.peso = peso;
	}
	public String getDimensiones() {
		return dimensiones;
	}
	public void setDimensiones(String dimensiones) {
		this.dimensiones = dimensiones;
	}
	public String getUbicacion() {
		return ubicacion;
	}
	public void setUbicacion(String ubicacion) {
		this.ubicacion = ubicacion;
	}
	public String getPasillo() {
		return pasillo;
	}
	public void setPasillo(String pasillo) {
		this.pasillo = pasillo;
	}
	public String getEstante() {
		return estante;
	}
	public void setEstante(String estante) {
		this.estante = estante;
	}
	public String getNivel() {
		return nivel;
	}
	public void setNivel(String nivel) {
		this.nivel = nivel;
	}
	public String getImagen() {
		return imagen;
	}
	public void setImagen(String imagen) {
		this.imagen = imagen;
	}
	public String getCodigoBarras() {
		return codigoBarras;
	}
	public void setCodigoBarras(String codigoBarras) {
		this.codigoBarras = codigoBarras;
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
	public int getStockActual() {
		return stockActual;
	}
	public void setStockActual(int stockActual) {
		this.stockActual = stockActual;
	}


    // Getters y Setters
    
}