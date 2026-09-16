-- ============================================================
-- RetailPro - Pre-entrega M4: Consultas SQL de negocio
-- Título: Extrayendo métricas clave con SQL
-- Autora: Maria Delfina Estein
-- ============================================================

USE Ventas_Tech_DB;


-- CONSULTA 1 - RESUMEN EJECUTIVO MENSUAL
-- Agrupa las ventas según el mes en que fueron realizadas.
-- SUM calcula la facturación total de cada mes.
-- COUNT(*) cuenta la cantidad de pedidos realizados.
-- AVG calcula el importe promedio por pedido.

SELECT
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(*) AS cantidad_pedidos,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;


-- CONSULTA 2 - RANKING DE PRODUCTOS---
-- Se limita el resultado a 5 a traves de select top 5-


SELECT TOP 5
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_generado
FROM ventas
GROUP BY id_producto
ORDER BY total_generado DESC;


-- CONSULTA 3 - CLIENTES RECURRENTES
-- HAVING filtra los resultados después de agruparlos por cliente.

SELECT
    id_cliente,
    COUNT(*) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY total_gastado DESC;


-- CONSULTA 4 - MESES POR ENCIMA/POR DEBAJO DEL PROMEDIO
-- Agrupa las ventas por mes y calcula la facturación mensual.
-- Luego compara cada total mensual con el promedio general de los meses.
-- CASE WHEN clasifica cada mes según su relación con ese promedio.

WITH facturacion_mensual AS (
    SELECT
        MONTH(fecha_venta) AS mes,
        SUM(cantidad * precio_unitario) AS total_facturado
    FROM ventas
    GROUP BY MONTH(fecha_venta)
),
promedio_general AS (
    SELECT
        AVG(total_facturado) AS promedio_mensual
    FROM facturacion_mensual
)
SELECT
    fm.mes,
    fm.total_facturado,
    pg.promedio_mensual,
    CASE
        WHEN fm.total_facturado > pg.promedio_mensual THEN 'Por encima'
        WHEN fm.total_facturado < pg.promedio_mensual THEN 'Por debajo'
        ELSE 'Igual al promedio'
    END AS comparacion_promedio
FROM facturacion_mensual AS fm
CROSS JOIN promedio_general AS pg
ORDER BY fm.mes;

-- HALLAZGOS
-- 1. Marzo de 2024 facturó 6444.00 en 10 pedidos, con un ticket promedio de 644.40.
-- 2. El producto 1 lideró el ranking: generó 3600.00, equivalente al 55.87% de la facturación total.
-- 3. Los cinco clientes son recurrentes porque realizaron 2 pedidos cada uno; el cliente 1 fue quien más gastó, con 2640.00.
