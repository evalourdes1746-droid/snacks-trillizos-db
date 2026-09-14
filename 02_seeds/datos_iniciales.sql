-- =============================================
-- CARGA INICIAL DE DATOS (SEEDS)
-- =============================================

-- 1. Insertar Categorías
INSERT INTO CATEGORIAS (nombre) VALUES 
('Fresas'),               -- id_categoria = 1
('Esquites y Antojitos'), -- id_categoria = 2
('Postres y Frios'),      -- id_categoria = 3
('Bebidas'),              -- id_categoria = 4
('Sabritas y Botanas');   -- id_categoria = 5

-- 2. Cargar Insumos Físicos (Almacén Central)
INSERT INTO INSUMOS (nombre, stock_actual, stock_minimo) VALUES 
-- Sabritas (id_insumo: 1 al 4)
('Tostitos Verdes', 12, 3),
('Tostitos Morados', 12, 3),
('Doritos Nacho', 12, 3),
('Chetos Flaming', 5, 1),
('Ruffles Queso', 5, 1),
('Chips verdes', 12, 3),
('Chips Moradas', 12, 3),
-- Bebidas (id_insumo: 5 al 8)
('Arizona Sandía', 6, 1),
('Arizona Mucho Mango', 6, 1),
('Arizona Kiwi con Fresa', 6, 1),
('Pepsi Regular', 8, 1),
('Pepsi 7up', 4, 1),
('Pepsi Mirinda', 4, 1),
('Pepsi Manzana', 4, 1),
('Pepsi Squirt', 4, 1),
-- Jarabes de Raspados (id_insumo: 9 al 12)
('Jarabe Ciruela', 10, 2),
('Jarabe Tamarindo', 10, 2),
('Jarabe Mango', 10, 2),
('Jarabe Fresa', 10, 2),
-- Helados (id_insumo: 13 al 15)
('Helado Chocolate', 12, 3),
('Helado Vainilla', 12, 3),
('Helado Galleta/Oreo', 15, 3);

-- 3. Insertar Productos del Menú

-- Categoría 1: Fresas
INSERT INTO PRODUCTOS (id_categoria, id_insumo, nombre, tamano, precio) VALUES
(1, NULL, 'Fresas con Crema', 'CH', 45.00),
(1, NULL, 'Fresas con Crema', 'G', 75.00),
(1, NULL, 'Fresas Especiales', 'CH', 55.00),
(1, NULL, 'Fresas Especiales', 'G', 85.00);

-- Categoría 2: Esquites y Antojitos
INSERT INTO PRODUCTOS (id_categoria, id_insumo, nombre, tamano, precio) VALUES
(2, NULL, 'Esquite', 'CH', 35.00),
(2, NULL, 'Esquite', 'M', 45.00),
(2, NULL, 'Esquite', 'G', 55.00),
(2, NULL, 'Esquite', '1/2 Ltr', 65.00),
(2, NULL, 'Esquite', '1 Ltr', 110.00),
(2, NULL, 'Tostiesquite', NULL, 60.00),
(2, NULL, 'Tostilocos', NULL, 55.00),
(2, NULL, 'Cevichurros', 'M', 50.00),
(2, NULL, 'Cevichurros', 'G', 70.00),
(2, NULL, 'Cacahuatadas', NULL, 45.00),
(2, NULL, 'Cacahuatadas Mango', NULL, 50.00),
(2, NULL, 'Papas Locas', NULL, 60.00),
(2, NULL, 'Papas Salseadas', NULL, 40.00),
(2, NULL, 'Chimichanga', 'Completa', 65.00),
(2, NULL, 'Chimichanga', '1/2', 40.00),
(2, NULL, 'Cevimix', NULL, 75.00);

-- Categoría 3: Postres y Fríos
INSERT INTO PRODUCTOS (id_categoria, id_insumo, nombre, tamano, precio) VALUES
(3, NULL, 'Mangoneada', NULL, 40.00),
(3, NULL, 'Choco Fresa', NULL, 30.00),
(3, NULL, 'Choco Banana', NULL, 25.00),
(3, NULL, 'Heladote', NULL, 50.00),
(3, NULL, 'Raspado', 'CH', 30.00),
(3, NULL, 'Raspado', 'M', 40.00),
(3, NULL, 'Raspado', 'G', 50.00);

-- Categoría 4: Bebidas
INSERT INTO PRODUCTOS (id_categoria, id_insumo, nombre, tamano, precio) VALUES
(4, NULL, 'Jaztea', NULL, 25.00),
(4, NULL, 'Arizona', NULL, 30.00),
(4, NULL, 'Pepsi', NULL, 25.00);

-- Categoría 5: Sabritas y Botanas (Venta Directa de Bolsas)
-- Se vincula id_insumo con el almacén para que al venderse sola descuente del mismo inventario
INSERT INTO PRODUCTOS (id_categoria, id_insumo, nombre, tamano, precio) VALUES
(5, 1, 'Tostitos Verdes Sola', NULL, 22.00),
(5, 2, 'Doritos Nacho Sola', NULL, 22.00),
(5, 3, 'Ruffles Queso Sola', NULL, 22.00),
(5, 4, 'Churrumais Sola', NULL, 18.00);
