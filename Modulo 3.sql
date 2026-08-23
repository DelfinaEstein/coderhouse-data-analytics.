-- Tabla de clientes
CREATE TABLE clientes (
    id_cliente INT,
    nombre VARCHAR(100),
    perfil_bio VARCHAR(MAX),
    fecha_registro DATE 
    );

-- Tabla de productos
CREATE TABLE productos (
    id_producto INT,
    descripcion VARCHAR(255),
    precio DECIMAL(10,2),
    esta_activo BIT,
);