-- =============================================
-- ESQUEMA DE BASE DE DATOS PARA NEGOCIO DE SNACKS
-- =============================================

-- 1. TABLA DE CATEGORÍAS (Menú)
CREATE TABLE CATEGORIAS (
    id_categoria INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

-- 2. TABLA DE INSUMOS (Bodega, Toppings, Desechables e Ingredientes)
CREATE TABLE INSUMOS (
    id_insumo INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    tipo_insumo VARCHAR(30) NOT NULL, -- 'Sabrita', 'Topping/Pastelito', 'Ingrediente', 'Desechable', 'Bebida'
    unidad_medida VARCHAR(20) NOT NULL, -- 'Pieza', 'Paquete', 'Porcion', 'Litro', 'Gramo'
    stock_actual DECIMAL(10,2) NOT NULL DEFAULT 0,
    stock_minimo DECIMAL(10,2) DEFAULT 5
);

-- 3. TABLA DE PRODUCTOS (Botones de cobro en el POS)
CREATE TABLE PRODUCTOS (
    id_producto INT IDENTITY(1,1) PRIMARY KEY,
    id_categoria INT NOT NULL,
    id_insumo_directo INT NULL, -- Solo se usa si el producto es una Sabrita o Bebida sola
    nombre VARCHAR(100) NOT NULL,
    tamano VARCHAR(20) NULL, -- 'CH', 'M', 'G', '1/2 Ltr', '1 Ltr', 'Completa'
    precio DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES CATEGORIAS(id_categoria),
    FOREIGN KEY (id_insumo_directo) REFERENCES INSUMOS(id_insumo)
);

-- 4. TABLA DE RECETAS (Relación entre productos preparados e insumos a descontar)
CREATE TABLE RECETAS_PRODUCTO (
    id_receta INT IDENTITY(1,1) PRIMARY KEY,
    id_producto INT NOT NULL,
    id_insumo INT NOT NULL,
    cantidad_requerida DECIMAL(10,2) NOT NULL DEFAULT 1, -- Cuánto descuenta de la bodega por venta
    FOREIGN KEY (id_producto) REFERENCES PRODUCTOS(id_producto),
    FOREIGN KEY (id_insumo) REFERENCES INSUMOS(id_insumo)
);

-- 5. TABLA DE ÓRDENES (Registro de ventas diarias)
CREATE TABLE ORDENES (
    id_orden INT IDENTITY(1,1) PRIMARY KEY,
    fecha_hora DATETIME DEFAULT GETDATE(),
    total DECIMAL(10,2) NOT NULL,
    metodo_pago VARCHAR(20) DEFAULT 'Efectivo', -- 'Efectivo', 'Tarjeta', 'Transferencia'
    estado VARCHAR(20) DEFAULT 'Completada' -- 'Completada', 'Cancelada'
);

-- 6. TABLA DETALLE DE ÓRDENES (Desglose del ticket)
CREATE TABLE DETALLE_ORDENES (
    id_detalle INT IDENTITY(1,1) PRIMARY KEY,
    id_orden INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL DEFAULT 1,
    precio_unitario DECIMAL(10,2) NOT NULL,
    subtotal AS (cantidad * precio_unitario),
    FOREIGN KEY (id_orden) REFERENCES ORDENES(id_orden),
    FOREIGN KEY (id_producto) REFERENCES PRODUCTOS(id_producto)
);
