-- ══════════════════════════════════════════
-- BodegaTech — Script de Inventario
-- Autora: Maria Delfina Estein
-- Fecha: 23/08/2026
-- ══════════════════════════════════════════


-- ── SECCIÓN DDL ──────────────────────────

-- Primero elimino la tabla si ya existe para poder ejecutar nuevamente el script sin generar errores--
DROP TABLE IF EXISTS inventario;


-- CREATE TABLE--
CREATE TABLE inventario (

id_producto INT PRIMARY KEY,            -- INT porque el identificador del producto es un número entero--
nombre_producto VARCHAR(100),           -- VARCHAR(100) porque almacena texto de longitud variable hasta 100 caracteres--
categoria VARCHAR(50),
precio_unitario DECIMAL(10,2),          -- DECIMAL(10,2) porque es un valor monetario y necesitamos dos decimales--
stock_actual INT,
stock_minimo INT,
fecha_ingreso DATE,                     -- DATE porque solamente necesitamos almacenar la fecha de ingreso--
activo BIT                               -- BIT porque hay que representar dos estados 1 = activo y 0 = inactivo.
);


-- ── SECCIÓN DML 

-- INSERT INTO Carga inicial de los 10 productos del inventario

INSERT INTO inventario
(
    id_producto,
    nombre_producto,
    categoria,
    precio_unitario,
    stock_actual,
    stock_minimo,
    fecha_ingreso,
    activo
)
VALUES
(1, 'Laptop Pro 15', 'Computación', 1200.00, 15, 3, '2024-01-10', 1),
(2, 'Mouse Inalámbrico', 'Accesorios', 28.00, 80, 10, '2024-01-10', 1),
(3, 'Monitor 4K 27"', 'Computación', 450.00, 12, 2, '2024-01-15', 1),
(4, 'Teclado Mecánico', 'Accesorios', 95.00, 40, 5, '2024-01-15', 1),
(5, 'Laptop Basic 14', 'Computación', 650.00, 20, 3, '2024-02-01', 1),
(6, 'Auriculares BT Pro', 'Audio', 120.00, 35, 5, '2024-02-01', 1),
(7, 'Hub USB-C 7 puertos', 'Accesorios', 45.00, 60, 10, '2024-02-10', 1),
(8, 'Webcam HD 1080p', 'Accesorios', 85.00, 25, 5, '2024-02-10', 1),
(9, 'SSD Externo 1TB', 'Almacenamiento', 130.00, 18, 3, '2024-03-01', 1),
(10, 'Parlante Bluetooth', 'Audio', 60.00, 45, 8, '2024-03-01', 1);


-- UPDATE: ventas del día

-- Se vendieron 3 unidades de Laptop Pro 15.
UPDATE inventario
SET stock_actual = stock_actual - 3
WHERE id_producto = 1;


-- Se vendieron 12 unidades de Mouse Inalámbrico.
UPDATE inventario
SET stock_actual = stock_actual - 12
WHERE id_producto = 2;


-- Se vendieron 5 unidades de Auriculares BT Pro.
UPDATE inventario
SET stock_actual = stock_actual - 5
WHERE id_producto = 6;


-- UPDATE: producto descontinuado

-- La Webcam HD 1080p fue descontinuada.
UPDATE inventario
SET activo = 0
WHERE id_producto = 8;


-- ── VALIDACIÓN 

-- Veo la tabla y confirmo que los datos están bien.
SELECT * FROM inventario;