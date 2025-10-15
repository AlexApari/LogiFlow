create database logiflow_db
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;
USE logiflow_db;

-- =====================================================
-- 1. TABLA USUARIOS (Gestión completa para ADMIN)
-- =====================================================
CREATE TABLE usuarios (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    direccion TEXT,
    activo BOOLEAN DEFAULT TRUE,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    ultimo_acceso DATETIME NULL,
    creado_por BIGINT NULL,
    modificado_por BIGINT NULL,
    fecha_modificacion DATETIME NULL,
    intentos_fallidos INT DEFAULT 0,
    bloqueado BOOLEAN DEFAULT FALSE,
    fecha_bloqueo DATETIME NULL,
    INDEX idx_username (username),
    INDEX idx_email (email),
    INDEX idx_activo (activo),
    INDEX idx_bloqueado (bloqueado),
    CONSTRAINT fk_usuario_creador FOREIGN KEY (creado_por) REFERENCES usuarios(id) ON DELETE SET NULL,
    CONSTRAINT fk_usuario_modificador FOREIGN KEY (modificado_por) REFERENCES usuarios(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 2. TABLA ROLES (Sistema de roles)
-- =====================================================
CREATE TABLE roles (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    descripcion TEXT,
    activo BOOLEAN DEFAULT TRUE,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_nombre (nombre)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 3. TABLA USUARIO_ROLES (Relación muchos a muchos)
-- =====================================================
CREATE TABLE usuario_roles (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    usuario_id BIGINT NOT NULL,
    rol_id BIGINT NOT NULL,
    asignado_por BIGINT NULL,
    fecha_asignacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uk_usuario_rol (usuario_id, rol_id),
    CONSTRAINT fk_ur_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    CONSTRAINT fk_ur_rol FOREIGN KEY (rol_id) REFERENCES roles(id) ON DELETE CASCADE,
    CONSTRAINT fk_ur_asignador FOREIGN KEY (asignado_por) REFERENCES usuarios(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 4. TABLA AUDITORIA_USUARIOS (Historial de cambios)
-- =====================================================
CREATE TABLE auditoria_usuarios (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    usuario_id BIGINT NOT NULL,
    accion ENUM('CREAR', 'MODIFICAR', 'ELIMINAR', 'LOGIN', 'LOGOUT', 'CAMBIO_PASSWORD', 'BLOQUEO', 'DESBLOQUEO') NOT NULL,
    descripcion TEXT,
    realizado_por BIGINT NULL,
    fecha_accion DATETIME DEFAULT CURRENT_TIMESTAMP,
    ip_address VARCHAR(45),
    detalles_json TEXT,
    INDEX idx_usuario (usuario_id),
    INDEX idx_fecha (fecha_accion),
    INDEX idx_accion (accion),
    CONSTRAINT fk_audit_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    CONSTRAINT fk_audit_realizador FOREIGN KEY (realizado_por) REFERENCES usuarios(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 5. TABLA CATEGORIAS
-- =====================================================
CREATE TABLE categorias (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    descripcion TEXT,
    imagen VARCHAR(255),
    activa BOOLEAN DEFAULT TRUE,
    orden INT DEFAULT 0,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_nombre (nombre),
    INDEX idx_activa (activa),
    INDEX idx_orden (orden)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 6. TABLA PROVEEDORES
-- =====================================================
CREATE TABLE proveedores (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    ruc VARCHAR(11) NOT NULL UNIQUE,
    razon_social VARCHAR(200) NOT NULL,
    nombre_comercial VARCHAR(200),
    direccion TEXT NOT NULL,
    ciudad VARCHAR(100),
    pais VARCHAR(100) DEFAULT 'Perú',
    telefono VARCHAR(20),
    telefono_alternativo VARCHAR(20),
    email VARCHAR(100),
    email_alternativo VARCHAR(100),
    persona_contacto VARCHAR(100),
    cargo_contacto VARCHAR(100),
    condicion_pago ENUM('CONTADO', 'CREDITO_15', 'CREDITO_30', 'CREDITO_45', 'CREDITO_60', 'CREDITO_90') DEFAULT 'CONTADO',
    limite_credito DECIMAL(12,2) DEFAULT 0,
    calificacion ENUM('EXCELENTE', 'BUENO', 'REGULAR', 'MALO') DEFAULT 'BUENO',
    activo BOOLEAN DEFAULT TRUE,
    notas TEXT,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_ruc (ruc),
    INDEX idx_razon_social (razon_social),
    INDEX idx_activo (activo),
    INDEX idx_calificacion (calificacion)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 7. TABLA PRODUCTOS
-- =====================================================
CREATE TABLE productos (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    categoria_id BIGINT,
    precio DECIMAL(10,2) NOT NULL,
    precio_compra DECIMAL(10,2),
    margen_ganancia DECIMAL(5,2),
    unidad_medida VARCHAR(10) NOT NULL default 'UNIDAD',
    stock_inicial INT DEFAULT 0,
    stock_actual INT DEFAULT 0,
    stock_minimo INT DEFAULT 0,
    stock_maximo INT DEFAULT 1000,
    ubicacion VARCHAR(50),
    pasillo VARCHAR(10),
    estante VARCHAR(10),
    nivel VARCHAR(10),
    proveedor_id BIGINT,
    imagen VARCHAR(255),
    codigo_barras VARCHAR(50),
    activo BOOLEAN DEFAULT TRUE,
    es_perecible BOOLEAN DEFAULT FALSE,
    dias_vencimiento INT NULL,
    peso DECIMAL(8,2),
    dimensiones VARCHAR(50),
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_producto_categoria FOREIGN KEY (categoria_id) REFERENCES categorias(id) ON DELETE SET NULL,
    CONSTRAINT fk_producto_proveedor FOREIGN KEY (proveedor_id) REFERENCES proveedores(id) ON DELETE SET NULL,
    INDEX idx_codigo (codigo),
    INDEX idx_nombre (nombre),
    INDEX idx_categoria (categoria_id),
    INDEX idx_proveedor (proveedor_id),
    INDEX idx_activo (activo),
    INDEX idx_stock_bajo (stock_actual, stock_minimo),
    INDEX idx_codigo_barras (codigo_barras),
    FULLTEXT idx_busqueda (nombre, descripcion)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 8. TABLA CLIENTES
-- =====================================================
CREATE TABLE clientes (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    tipo_documento ENUM('DNI', 'RUC', 'PASAPORTE', 'CARNET_EXTRANJERIA') NOT NULL,
    numero_documento VARCHAR(15) NOT NULL UNIQUE,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100),
    razon_social VARCHAR(200),
    nombre_comercial VARCHAR(200),
    direccion TEXT NOT NULL,
    direccion_alternativa TEXT,
    ciudad VARCHAR(100) NOT NULL,
    departamento VARCHAR(100),
    codigo_postal VARCHAR(10),
    telefono VARCHAR(20),
    telefono_alternativo VARCHAR(20),
    email VARCHAR(100),
    email_alternativo VARCHAR(100),
    fecha_nacimiento DATE,
    genero ENUM('M', 'F', 'OTRO'),
    tipo_cliente ENUM('NATURAL', 'JURIDICO') DEFAULT 'NATURAL',
    categoria_cliente ENUM('VIP', 'REGULAR', 'OCASIONAL') DEFAULT 'REGULAR',
    limite_credito DECIMAL(12,2) DEFAULT 0,
    descuento_porcentaje DECIMAL(5,2) DEFAULT 0,
    activo BOOLEAN DEFAULT TRUE,
    notas TEXT,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_cliente_usuario FOREIGN KEY (id) REFERENCES usuarios(id) ON DELETE CASCADE,
    INDEX idx_documento (numero_documento),
    INDEX idx_nombres (nombres),
    INDEX idx_apellidos (apellidos),
    INDEX idx_email (email),
    INDEX idx_activo (activo),
    INDEX idx_categoria (categoria_cliente),
    FULLTEXT idx_busqueda_cliente (nombres, apellidos, razon_social)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 9. TABLA ALMACENES
-- =====================================================
CREATE TABLE almacenes (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    descripcion TEXT,
    direccion TEXT NOT NULL,
    ciudad VARCHAR(100),
    telefono VARCHAR(20),
    responsable VARCHAR(100),
    capacidad_maxima DECIMAL(12,2),
    capacidad_utilizada DECIMAL(12,2) DEFAULT 0,
    unidad_capacidad VARCHAR(10) DEFAULT 'M3',
    tipo_almacen ENUM('PRINCIPAL', 'SECUNDARIO', 'DEPOSITO', 'TEMPORAL') DEFAULT 'SECUNDARIO',
    activo BOOLEAN DEFAULT TRUE,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_codigo (codigo),
    INDEX idx_nombre (nombre),
    INDEX idx_activo (activo),
    INDEX idx_tipo (tipo_almacen)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 10. TABLA PEDIDOS
-- =====================================================
CREATE TABLE pedidos (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    numero_pedido VARCHAR(20) NOT NULL UNIQUE,
    cliente_id BIGINT NOT NULL,
    fecha_pedido DATE NOT NULL,
    fecha_entrega_estimada DATE,
    fecha_entrega_real DATE NULL,
    direccion_entrega TEXT NOT NULL,
    referencia_direccion VARCHAR(200),
    ciudad_entrega VARCHAR(100),
    estado ENUM('PENDIENTE', 'PROCESANDO', 'EMPAQUETADO', 'ENVIADO', 'ENTREGADO', 'CANCELADO', 'DEVUELTO') DEFAULT 'PENDIENTE',
    prioridad ENUM('NORMAL', 'ALTA', 'URGENTE') DEFAULT 'NORMAL',
    subtotal DECIMAL(12,2) NOT NULL DEFAULT 0,
    descuento DECIMAL(12,2) DEFAULT 0,
    impuestos DECIMAL(12,2) NOT NULL DEFAULT 0,
    costo_envio DECIMAL(12,2) DEFAULT 0,
    total DECIMAL(12,2) NOT NULL DEFAULT 0,
    metodo_pago ENUM('EFECTIVO', 'TARJETA', 'TRANSFERENCIA', 'CREDITO') DEFAULT 'EFECTIVO',
    observaciones TEXT,
    notas_internas TEXT,
    usuario_creacion BIGINT,
    usuario_modificacion BIGINT,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,
    fecha_cancelacion DATETIME NULL,
    motivo_cancelacion TEXT,
    CONSTRAINT fk_pedido_cliente FOREIGN KEY (cliente_id) REFERENCES clientes(id) ON DELETE RESTRICT,
    CONSTRAINT fk_pedido_usuario_creacion FOREIGN KEY (usuario_creacion) REFERENCES usuarios(id) ON DELETE SET NULL,
    CONSTRAINT fk_pedido_usuario_modificacion FOREIGN KEY (usuario_modificacion) REFERENCES usuarios(id) ON DELETE SET NULL,
    INDEX idx_numero_pedido (numero_pedido),
    INDEX idx_cliente (cliente_id),
    INDEX idx_fecha_pedido (fecha_pedido),
    INDEX idx_estado (estado),
    INDEX idx_prioridad (prioridad),
    INDEX idx_fecha_entrega (fecha_entrega_estimada)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 11. TABLA DETALLE_PEDIDOS
-- =====================================================
CREATE TABLE detalle_pedidos (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    pedido_id BIGINT NOT NULL,
    producto_id BIGINT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    descuento_porcentaje DECIMAL(5,2) DEFAULT 0,
    descuento_monto DECIMAL(10,2) DEFAULT 0,
    subtotal DECIMAL(12,2) NOT NULL,
    notas VARCHAR(500),
    CONSTRAINT fk_detalle_pedido FOREIGN KEY (pedido_id) REFERENCES pedidos(id) ON DELETE CASCADE,
    CONSTRAINT fk_detalle_producto FOREIGN KEY (producto_id) REFERENCES productos(id) ON DELETE RESTRICT,
    INDEX idx_pedido (pedido_id),
    INDEX idx_producto (producto_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 12. TABLA MOVIMIENTOS_INVENTARIO
-- =====================================================
CREATE TABLE movimientos_inventario (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    producto_id BIGINT NOT NULL,
    almacen_id BIGINT NOT NULL,
    tipo_movimiento ENUM('ENTRADA', 'SALIDA', 'AJUSTE', 'TRANSFERENCIA', 'DEVOLUCION') NOT NULL,
    cantidad INT NOT NULL,
    cantidad_anterior INT NOT NULL,
    cantidad_nueva INT NOT NULL,
    fecha_movimiento DATETIME DEFAULT CURRENT_TIMESTAMP,
    motivo TEXT,
    usuario_responsable BIGINT,
    numero_documento VARCHAR(50),
    referencia_pedido_id BIGINT NULL,
    costo_unitario DECIMAL(10,2),
    costo_total DECIMAL(12,2),
    observaciones TEXT,
    CONSTRAINT fk_movimiento_producto FOREIGN KEY (producto_id) REFERENCES productos(id) ON DELETE RESTRICT,
    CONSTRAINT fk_movimiento_almacen FOREIGN KEY (almacen_id) REFERENCES almacenes(id) ON DELETE RESTRICT,
    CONSTRAINT fk_movimiento_usuario FOREIGN KEY (usuario_responsable) REFERENCES usuarios(id) ON DELETE SET NULL,
    CONSTRAINT fk_movimiento_pedido FOREIGN KEY (referencia_pedido_id) REFERENCES pedidos(id) ON DELETE SET NULL,
    INDEX idx_producto (producto_id),
    INDEX idx_almacen (almacen_id),
    INDEX idx_fecha (fecha_movimiento),
    INDEX idx_tipo (tipo_movimiento),
    INDEX idx_documento (numero_documento)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 13. TABLA TRANSPORTES
-- =====================================================
CREATE TABLE transportes (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    placa_vehiculo VARCHAR(10) NOT NULL UNIQUE,
    tipo_vehiculo ENUM('CAMION', 'VAN', 'MOTOCICLETA', 'AUTO', 'CAMIONETA') NOT NULL,
    marca VARCHAR(50),
    modelo VARCHAR(50),
    año_fabricacion INT,
    color VARCHAR(30),
    conductor VARCHAR(100) NOT NULL,
    dni_conductor VARCHAR(8),
    licencia_conductor VARCHAR(20) NOT NULL,
    categoria_licencia VARCHAR(10),
    telefono_conductor VARCHAR(20),
    email_conductor VARCHAR(100),
    capacidad_carga DECIMAL(8,2) NOT NULL,
    unidad_capacidad VARCHAR(10) DEFAULT 'KG',
    estado ENUM('DISPONIBLE', 'EN_RUTA', 'MANTENIMIENTO', 'FUERA_SERVICIO', 'TALLER') DEFAULT 'DISPONIBLE',
    fecha_ultimo_mantenimiento DATE,
    fecha_proximo_mantenimiento DATE,
    kilometraje INT DEFAULT 0,
    soat_vencimiento DATE,
    revision_tecnica_vencimiento DATE,
    seguro_vencimiento DATE,
    activo BOOLEAN DEFAULT TRUE,
    notas TEXT,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_placa (placa_vehiculo),
    INDEX idx_conductor (conductor),
    INDEX idx_estado (estado),
    INDEX idx_activo (activo),
    INDEX idx_tipo (tipo_vehiculo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 14. TABLA ENVIOS
-- =====================================================
CREATE TABLE envios (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    numero_envio VARCHAR(20) NOT NULL UNIQUE,
    numero_guia VARCHAR(50) UNIQUE,
    pedido_id BIGINT NOT NULL,
    transporte_id BIGINT,
    fecha_envio DATETIME,
    fecha_entrega_estimada DATETIME,
    fecha_entrega_real DATETIME NULL,
    direccion_origen TEXT NOT NULL,
    direccion_destino TEXT NOT NULL,
    distancia_km DECIMAL(8,2),
    estado ENUM('PREPARANDO', 'EN_TRANSITO', 'EN_DESTINO', 'ENTREGADO', 'DEVUELTO', 'INCIDENCIA') DEFAULT 'PREPARANDO',
    firma_recepcion VARCHAR(100),
    dni_receptor VARCHAR(8),
    observaciones TEXT,
    costo_envio DECIMAL(10,2) DEFAULT 0,
    peso_total DECIMAL(8,2),
    volumen_total DECIMAL(8,2),
    usuario_despachador BIGINT,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_envio_pedido FOREIGN KEY (pedido_id) REFERENCES pedidos(id) ON DELETE RESTRICT,
    CONSTRAINT fk_envio_transporte FOREIGN KEY (transporte_id) REFERENCES transportes(id) ON DELETE SET NULL,
    CONSTRAINT fk_envio_usuario FOREIGN KEY (usuario_despachador) REFERENCES usuarios(id) ON DELETE SET NULL,
    INDEX idx_numero_envio (numero_envio),
    INDEX idx_numero_guia (numero_guia),
    INDEX idx_pedido (pedido_id),
    INDEX idx_transporte (transporte_id),
    INDEX idx_estado (estado),
    INDEX idx_fecha_envio (fecha_envio)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 1. Insertar el rol ADMIN si no existe
INSERT INTO Roles (nombre, descripcion, activo, fecha_creacion)
SELECT 'ADMIN', 'Administrador del sistema', 1, NOW()
WHERE NOT EXISTS (SELECT 1 FROM roles WHERE nombre = 'ADMIN');

-- 2. Insertar el usuario administrador
INSERT INTO usuarios (username, password, email, nombre, apellido, telefono, direccion, activo, bloqueado, fecha_creacion)
VALUES (
  'admin',
  -- Cambia 'admin123' por una contraseña segura y hasheada si usas hash
  '$2a$10$fWfXJUNQtCFl3eJAptTkUOl0g.j17CryeOVHVI1lGpXDV4WMyFIzW',
  'admin@logiflow.com',
  'Administrador',
  'Principal',
  '999999999',
  'Oficina Central',
  1,
  0,
  NOW()
);

-- 3. Relacionar el usuario con el rol ADMIN
INSERT INTO usuario_roles (usuario_id, rol_id)
SELECT u.id, r.id
FROM usuarios u, roles r
WHERE u.username = 'admin' AND r.nombre = 'ADMIN'
  AND NOT EXISTS (
    SELECT 1 FROM usuario_roles ur
    WHERE ur.usuario_id = u.id AND ur.rol_id = r.id
  );

-- 4. Agregar otros roles
INSERT INTO roles (nombre, descripcion, activo, fecha_creacion) VALUES
('OPERATOR', 'Operador con permisos de gestión operativa', TRUE, NOW()),
('USER', 'Usuario cliente con permisos básicos', TRUE, NOW()),
('SUPERVISOR', 'Supervisor con permisos de supervisión', TRUE, NOW()),
('VENDEDOR', 'Vendedor con permisos de ventas', TRUE, NOW());

-- =====================================================
-- INSERTAR USUARIOS CON CONTRASEÑAS BCRYPT
-- =====================================================

-- USUARIO: operador | CONTRASEÑA: operador123
INSERT INTO usuarios (username, password, email, nombre, apellido, telefono, activo, fecha_creacion) VALUES
('operador', '$2a$10$3yg4SHbym4ikvSkbUei3X.AnWQFD9E31CrBjVJxoIiLvWiVyByWbK', 'operador@logiflow.com', 'María Elena', 'García López', '987654321', TRUE, NOW());

-- USUARIO: usuario | CONTRASEÑA: usuario123
INSERT INTO usuarios (username, password, email, nombre, apellido, telefono, activo, fecha_creacion) VALUES
('usuario', '$2a$10$b3VQfCNwfxJUr9lZ3iDImOdAkVeeWkprQ73SXAikSPB/5s60c7R0i', 'usuario@logiflow.com', 'Juan Carlos', 'Pérez Rodríguez', '965432100', TRUE, NOW());

-- USUARIO: supervisor | CONTRASEÑA: supervisor123
INSERT INTO usuarios (username, password, email, nombre, apellido, telefono, activo, fecha_creacion) VALUES
('supervisor', '$2a$10$mN2LvwXRwm6VuETk4AuPH.qYekkg3Smbp3rWhjJ5vXbvKaMqLKVoW', 'supervisor@logiflow.com', 'Roberto', 'Martínez Silva', '954321098', TRUE, NOW());

-- USUARIO: vendedor1 | CONTRASEÑA: vendedor123
INSERT INTO usuarios (username, password, email, nombre, apellido, telefono, activo, fecha_creacion) VALUES
('vendedor1', '$2a$10$10BJq8nDmcNuHm/aN.r.weo0np2MDN/4io7PgTPHl/H7NE1IHFeCK', 'vendedor1@logiflow.com', 'Ana María', 'Fernández Torres', '943210987', TRUE, NOW());

-- =====================================================
-- ASIGNAR ROLES A USUARIOS
-- =====================================================
INSERT INTO usuario_roles (usuario_id, rol_id, asignado_por, fecha_asignacion) VALUES
(2, 2, 1, NOW()), -- operador tiene rol OPERATOR
(3, 3, 1, NOW()), -- usuario tiene rol USER
(4, 4, 1, NOW()), -- supervisor tiene rol SUPERVISOR
(5, 5, 1, NOW()); -- vendedor1 tiene rol VENDEDOR

-- Insertar categorías iniciales
INSERT INTO categorias (nombre, descripcion, activa, orden, fecha_creacion, fecha_modificacion)
VALUES 
('Electrónica', 'Productos electrónicos como celulares, computadoras, televisores.', 1, 1, NOW(), NOW()),
('Ropa', 'Ropa para hombres, mujeres y niños.', 1, 2, NOW(), NOW()),
('Hogar', 'Artículos para el hogar, muebles y decoración.', 1, 3, NOW(), NOW()),
('Deportes', 'Equipamiento y ropa deportiva.', 1, 4, NOW(), NOW()),
('Alimentos', 'Productos alimenticios no perecibles.', 1, 5, NOW(), NOW());

