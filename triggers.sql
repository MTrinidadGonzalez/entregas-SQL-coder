-- Triggers
-- Elimino para probar los triggers
SELECT fn_eliminar_registro_por_id_product(5);
-- Triger elimino un registro de compra

DROP TABLE IF EXISTS registro_compras_eliminadas;

CREATE TABLE IF NOT EXISTS registro_compras_eliminadas (
product_name VARCHAR (255),
 id_proveedor_fk INT,
    precio_por_kilo NUMERIC,
    precio_por_unidad NUMERIC,
    cantidad_de_compra_por_kilo VARCHAR(255),
    cantidad_de_compra_por_unidad INT,
    monto_de_compra NUMERIC,
    fecha_de_compra DATE,
    fecha_de_eliminacion_registro DATE
);

DROP TRIGGER IF EXISTS TRG_compras_elimindas;
 DELIMITER //
CREATE TRIGGER TRG_compras_elimindas AFTER DELETE ON Compras
FOR EACH ROW
BEGIN
    INSERT INTO registro_compras_eliminadas (
        product_name,
        id_proveedor_fk,
        precio_por_kilo,
        precio_por_unidad,
        cantidad_de_compra_por_kilo,
        cantidad_de_compra_por_unidad,
        monto_de_compra,
        fecha_de_compra,
        fecha_de_eliminacion_registro
    ) VALUES (
        (SELECT product_name FROM Products WHERE pk_id_product = OLD.id_product_fk),
        OLD.id_proveedor_fk,
        OLD.precio_por_kilo,
        OLD.precio_por_unidad,
        OLD.cantidad_de_compra_por_kilo,
        OLD.cantidad_de_compra_por_unidad,
        OLD.monto_de_compra,
        OLD.fecha_de_compra,
        CURRENT_DATE()
    );
END;//
DELIMITER ;

SELECT * FROM registro_compras_eliminadas;


-- Triguer para eliminar registro de venta: 

DROP TABLE IF EXISTS registro_ventas_eliminadas;

CREATE TABLE IF NOT EXISTS registro_ventas_eliminadas (
product_name VARCHAR (255),
 id_proveedor_fk INT,
    precio_por_kilo NUMERIC,
    precio_por_unidad NUMERIC,
    cantidad_de_compra_por_kilo VARCHAR(255),
    cantidad_de_compra_por_unidad INT,
     monto_de_venta NUMERIC,
    fecha_de_compra DATE,
    fecha_de_eliminacion_registro DATE
);
DROP TRIGGER IF EXISTS TRG_ventas_eliminadas;

DELIMITER //
CREATE TRIGGER TRG_ventas_eliminadas AFTER DELETE ON Ventas
FOR EACH ROW
BEGIN
    INSERT INTO registro_ventas_eliminadas (
        product_name,
        cantidad_venta_por_gramos,
        cantidad_venta_por_unidad,
        precio_venta_por_kilo,
        precio_por_unidad,
        monto_de_venta,
        fecha_de_venta,
        fecha_de_eliminacion_registro
    ) VALUES (
        (SELECT product_name FROM Products WHERE pk_id_product = OLD.id_product_fk),
        OLD.cantidad_venta_por_gramos,
        OLD.cantidad_venta_por_unidad,
        OLD.precio_venta_por_kilo,
        OLD.precio_por_unidad,
        OLD.monto_de_venta,
        OLD.fecha_de_venta,
        CURRENT_DATE()
    );
END;
// DELIMITER ;

SELECT * FROM registro_ventas_eliminadas;



-- Trigger para cuando se elimina un producto

DROP TABLE IF EXISTS registro_productos_eliminados;

CREATE TABLE IF NOT EXISTS registro_productos_eliminados (
id_dato_eliminacion_producto INT  PRIMARY KEY  AUTO_INCREMENT,
product_name VARCHAR(255),
fecha_eliminacion_producto DATE
);

DROP TRIGGER IF EXISTS TRG_eliminar_producto;
DELIMITER //
CREATE TRIGGER TRG_eliminar_producto
AFTER DELETE ON Products
FOR EACH ROW
BEGIN
    INSERT INTO registro_productos_eliminados (product_name, fecha_eliminacion_producto)
    VALUES (OLD.product_name, CURDATE());
END;
//
DELIMITER ;

SELECT * FROM registro_productos_eliminados;
