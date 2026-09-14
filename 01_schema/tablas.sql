-- =============================================
-- ESQUEMA DE BASE DE DATOS PARA NEGOCIO DE SNACKS
-- =============================================

-- 1. Categorías principales del menú
CREATE TABLE CATEGORIAS (
    id_categoria INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

-- 2. Control de inventario físico (sabritas, bebidas, jarabes, helados)
CREATE TABLE INSUMOS (
    id_insumo INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    stock_actual INT NOT NULL DEFAULT 0,
    stock_minimo INT DEFAULT 5
);

-- 3. Catálogo de productos con tamaño, precio e insumo directo (si aplica)
CREATE TABLE PRODUCTOS (
    id_producto INT IDENTITY(1,1) PRIMARY KEY,
    id_categoria INT NOT NULL,
    id_insumo INT NULL, -- Permite vincular si el producto es una sabrita/bebida individual
    nombre VARCHAR(100) NOT NULL,
    tamano VARCHAR(20) NULL, -- 'CH', 'M', 'G', '1/2 Ltr', '1 Ltr' o NULL
    precio DECIMAL(10,2) NOT NULL,
    disponible BIT DEFAULT 1,
    CONSTRAINT FK_Productos_Categorias FOREIGN KEY (id_categoria) 
        REFERENCES CATEGORIAS(id_categoria),
    CONSTRAINT FK_Productos_Insumos FOREIGN KEY (id_insumo) 
        REFERENCES INSUMOS(id_insumo)
);

-- 4. Opciones/sabores permitidos por cada producto preparado (ej. Tostilocos)
CREATE TABLE OPCIONES_PRODUCTO (
    id_opcion INT IDENTITY(1,1) PRIMARY KEY,
    id_producto INT NOT NULL,
    id_insumo INT NOT NULL,
    CONSTRAINT FK_OP_Productos FOREIGN KEY (id_producto) REFERENCES PRODUCTOS(id_producto),
    CONSTRAINT FK_OP_Insumos FOREIGN KEY (id_insumo) REFERENCES INSUMOS(id_insumo)
);

-- 5. Encabezado de ventas (Ticket)
CREATE TABLE ORDENES (
    id_orden INT IDENTITY(1,1) PRIMARY KEY,
    fecha_hora DATETIME DEFAULT GETDATE(),
    total DECIMAL(10,2) NOT NULL,
    metodo_pago VARCHAR(20) DEFAULT 'Efectivo' CHECK (metodo_pago IN ('Efectivo', 'Tarjeta', 'Transferencia'))
);

-- 6. Detalle de los ítems vendidos en la orden
CREATE TABLE DETALLE_ORDENES (
    id_detalle INT IDENTITY(1,1) PRIMARY KEY,
    id_orden INT NOT NULL,
    id_producto INT NOT NULL,
    id_insumo_elegido INT NULL, -- Registra la sabrita/sabor si el producto fue un preparado
    cantidad INT NOT NULL DEFAULT 1,
    precio_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    CONSTRAINT FK_Detalle_Ordenes FOREIGN KEY (id_orden) REFERENCES ORDENES(id_orden),
    CONSTRAINT FK_Detalle_Productos FOREIGN KEY (id_producto) REFERENCES PRODUCTOS(id_producto),
    CONSTRAINT FK_Detalle_Insumos FOREIGN KEY (id_insumo_elegido) REFERENCES INSUMOS(id_insumo)
);
