package com.logiflow.model;

import java.util.Date;

public class UsuarioRol {
    private Long id;
    private Usuario usuario;
    private Rol rol;
    private Usuario asignadoPor;
    private Date fechaAsignacion;

    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }
    public Usuario getUsuario() {
        return usuario;
    }
    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }
    public Rol getRol() {
        return rol;
    }
    public void setRol(Rol rol) {
        this.rol = rol;
    }
    public Usuario getAsignadoPor() {
        return asignadoPor;
    }
    public void setAsignadoPor(Usuario asignadoPor) {
        this.asignadoPor = asignadoPor;
    }
    public Date getFechaAsignacion() {
        return fechaAsignacion;
    }
    public void setFechaAsignacion(Date fechaAsignacion) {
        this.fechaAsignacion = fechaAsignacion;
    }
}