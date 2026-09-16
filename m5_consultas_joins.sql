-- =====================================================
-- RetailPro - Consultas con JOINs
-- Modulo 5: Cruzando tablas para enriquecer el analisis
-- Autora: Maria Delfina Estein
-- =====================================================

USE Ventas_Tech_DB;

-- CONSULTA 1 - VISTA BASE DEL PROYECTO (INNER JOIN)
-- Combina las ventas con las tablas descriptivas para obtener  una vista enriquecida que pueda utilizarse posteriormente en Power BI.

SELECT
    v.id_venta,
    v.fecha_venta,
    c.id_cliente,
    c.nombre AS nombre_cliente,
    c.ciudad,
    p.id_producto,
    p.nombre_producto,
    ca.nombre_categoria AS categoria,
    v.cantidad,
    v.precio_unitario,
    v.cantidad * v.precio_unitario AS total_venta
FROM ventas AS v
INNER JOIN clientes AS c
    ON v.id_cliente = c.id_cliente
INNER JOIN productos AS p
    ON v.id_producto = p.id_producto
INNER JOIN categorias AS ca
    ON p.id_categoria = ca.id_categoria
ORDER BY v.fecha_venta, v.id_venta;


-- CONSULTA 2 - CLIENTES SIN VENTAS (LEFT JOIN)
-- Conserva todos los clientes y utiliza WHERE IS NULL para aislar aquellos que no tienen ninguna venta registrada.

SELECT
    c.nombre AS nombre_cliente,
    c.email,
    c.fecha_registro
FROM clientes AS c
LEFT JOIN ventas AS v
    ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL
ORDER BY c.nombre;


-- CONSULTA 3 - PRODUCTOS SIN VENTAS (LEFT JOIN)
-- Conserva todos los productos y utiliza WHERE IS NULL para aislar aquellos que no tienen ninguna venta registrada.

SELECT
    p.nombre_producto,
    ca.nombre_categoria AS categoria,
    p.precio
FROM productos AS p
INNER JOIN categorias AS ca
    ON p.id_categoria = ca.id_categoria
LEFT JOIN ventas AS v
    ON p.id_producto = v.id_producto
WHERE v.id_venta IS NULL
ORDER BY p.nombre_producto;


-- CONSULTA 4 - CONSOLIDADO POR CANAL (UNION ALL)
-- La columna canal se crea como un texto fijo dentro de cada SELECT.
-- Como el esquema no posee canales de venta, se utilizan dos periodos de marzo como origen de los registros.

WITH ventas_por_canal AS (
    SELECT
        fecha_venta,
        cantidad * precio_unitario AS total,
        '05 al 10 de marzo' AS canal
    FROM ventas
    WHERE fecha_venta BETWEEN '2024-03-05' AND '2024-03-10'

    UNION ALL

    SELECT
        fecha_venta,
        cantidad * precio_unitario AS total,
        '11 al 15 de marzo' AS canal
    FROM ventas
    WHERE fecha_venta BETWEEN '2024-03-11' AND '2024-03-15'
)
SELECT
    canal,
    COUNT(*) AS cantidad_ventas,
    SUM(total) AS total_facturado
FROM ventas_por_canal
GROUP BY canal
ORDER BY canal;


