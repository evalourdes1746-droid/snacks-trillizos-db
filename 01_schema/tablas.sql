-- 1. Categorías
CREATE TABLE CATEGORIAS (
    id_categoria INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

-- 2. Productos principales del menú
CREATE TABLE PRODUCTOS (
    id_producto INT IDENTITY(1,1) PRIMARY KEY,
    id_categoria INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    tamano VARCHAR(20) NULL,
    precio DECIMAL(10,2) NOT NULL,
    disponible BIT DEFAULT 1,
    CONSTRAINT FK_Productos_Categorias FOREIGN KEY (id_categoria) 
        REFERENCES CATEGORIAS(id_categoria)
);

-- 3. INVENTARIO / INSUMOS (Aquí se descuenta el stock real)
CREATE TABLE INSUMOS (
    id_insumo INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL, -- Ej: 'Tostitos Verdes', 'Doritos Nacho', 'Arizona Sandía'
    stock_actual INT NOT NULL DEFAULT 0,
    stock_minimo INT DEFAULT 5 -- Alerta si quedan pocos
);

-- 4. Opciones disponibles por Producto (Sabores o Sabritas permitidas)
CREATE TABLE OPCIONES_PRODUCTO (
    id_opcion INT IDENTITY(1,1) PRIMARY KEY,
    id_producto INT NOT NULL,
    id_insumo INT NOT NULL,
    CONSTRAINT FK_OP_Productos FOREIGN KEY (id_producto) REFERENCES PRODUCTOS(id_producto),
    CONSTRAINT FK_OP_Insumos FOREIGN KEY (id_insumo) REFERENCES INSUMOS(id_insumo)
);

-- 5. Encabezado de la Orden
CREATE TABLE ORDENES (
    id_orden INT IDENTITY(1,1) PRIMARY KEY,
    fecha_hora DATETIME DEFAULT GETDATE(),
    total DECIMAL(10,2) NOT NULL,
    metodo_pago VARCHAR(20) DEFAULT 'Efectivo' CHECK (metodo_pago IN ('Efectivo', 'Tarjeta', 'Transferencia'))
);

-- 6. Detalle de la Orden (incluye el sabor/sabrita elegida para descontar inventario)
CREATE TABLE DETALLE_ORDENES (
    id_detalle INT IDENTITY(1,1) PRIMARY KEY,
    id_orden INT NOT NULL,
    id_producto INT NOT NULL,
    id_insumo_elegido INT NULL, -- Registra la sabrita o sabor específico que pidió el cliente
    cantidad INT NOT NULL DEFAULT 1,
    precio_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    CONSTRAINT FK_Detalle_Ordenes FOREIGN KEY (id_orden) REFERENCES ORDENES(id_orden),
    CONSTRAINT FK_Detalle_Productos FOREIGN KEY (id_producto) REFERENCES PRODUCTOS(id_producto),
    CONSTRAINT FK_Detalle_Insumos FOREIGN KEY (id_insumo_elegido) REFERENCES INSUMOS(id_insumo)
);
