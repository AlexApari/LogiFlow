package com.logiflow.model;

import java.util.Date;
import java.util.Set;

public class Usuario {
    private Long id;
    private String username;
    private String password;
    private String email;
    private String nombre;
    private String apellido;
    private String telefono;
    private String direccion;
    private Boolean activo;
    private Date fechaCreacion;
    private Date ultimoAcceso;
    private Usuario creadoPor;
    private Usuario modificadoPor;
    private Date fechaModificacion;
    private Integer intentosFallidos;
    private Boolean bloqueado;
    private Date fechaBloqueo;
    private Set<Rol> roles;

    // Getters y setters
    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }
    public String getUsername() {
        return username;
    }
    public void setUsername(String username) {
        this.username = username;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public String getNombre() {
        return nombre;
    }
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    public String getApellido() {
        return apellido;
    }
    public void setApellido(String apellido) {
        this.apellido = apellido;
    }
    public String getTelefono() {
        return telefono;
    }
    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }
    public String getDireccion() {
        return direccion;
    }
    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }
    public Boolean getActivo() {
        return activo;
    }
    public void setActivo(Boolean activo) {
        this.activo = activo;
    }
    public Date getFechaCreacion() {
        return fechaCreacion;
    }
    public void setFechaCreacion(Date fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }
    public Date getUltimoAcceso() {
        return ultimoAcceso;
    }
    public void setUltimoAcceso(Date ultimoAcceso) {
        this.ultimoAcceso = ultimoAcceso;
    }
    public Usuario getCreadoPor() {
        return creadoPor;
    }
    public void setCreadoPor(Usuario creadoPor) {
        this.creadoPor = creadoPor;
    }
    public Usuario getModificadoPor() {
        return modificadoPor;
    }
    public void setModificadoPor(Usuario modificadoPor) {
        this.modificadoPor = modificadoPor;
    }
    public Date getFechaModificacion() {
        return fechaModificacion;
    }
    public void setFechaModificacion(Date fechaModificacion) {
        this.fechaModificacion = fechaModificacion;
    }
    public Integer getIntentosFallidos() {
        return intentosFallidos;
    }
    public void setIntentosFallidos(Integer intentosFallidos) {
        this.intentosFallidos = intentosFallidos;
    }
    public Boolean getBloqueado() {
        return bloqueado;
    }
    public void setBloqueado(Boolean bloqueado) {
        this.bloqueado = bloqueado;
    }
    public Date getFechaBloqueo() {
        return fechaBloqueo;
    }
    public void setFechaBloqueo(Date fechaBloqueo) {
        this.fechaBloqueo = fechaBloqueo;
    }
    public Set<Rol> getRoles() {
        return roles;
    }
    public void setRoles(Set<Rol> roles) {
        this.roles = roles;
    }
}