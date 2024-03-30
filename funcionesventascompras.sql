SELECT * FROM Ventas;

-- Funcion somo la cantidad de ventas por gramos, recibe el parametro de id_producto_fk
DROP FUNCTION IF exists fn_TotalGramosDeProductoVendidos;

DELIMITER //
CREATE FUNCTION fn_TotalGramosDeProductoVendidos (p_producto_id INT, p_fecha_limite DATE) 
    RETURNS NUMERIC
    DETERMINISTIC
    BEGIN
        DECLARE v_total_gramos_vendidos NUMERIC;
        SELECT SUM(cantidad_venta_por_gramos) INTO v_total_gramos_vendidos
        FROM Ventas
        WHERE id_product_fk = p_producto_id
         AND fecha_de_venta <= p_fecha_limite;
        RETURN v_total_gramos_vendidos;
       
    END //
DELIMITER ;

SELECT fn_TotalGramosDeProductoVendidos(1, '2024-02-29') AS gramosVendidosHastaLaFecha;


-- Funcion sumo el monto de ventas por producto, recibe el parametro de id_producto_fk
DROP FUNCTION IF exists fn_MontoTotalVentas;

DELIMITER //
CREATE FUNCTION fn_MontoTotalVentas(p_producto_id INT,p_fecha_limite DATE) 
RETURNS NUMERIC
DETERMINISTIC
BEGIN
    DECLARE v_total_monto NUMERIC;
    SELECT SUM(monto_de_venta) INTO v_total_monto
    FROM Ventas
    WHERE id_product_fk = p_producto_id
     AND fecha_de_venta <= p_fecha_limite;
    RETURN v_total_monto;
END //
DELIMITER ;

SELECT fn_MontoTotalVentas(1,'2024-02-29') as montoTotalVendidosHastaLaFecha; 

-- Funcion por la cual ingreso un producto y fecha y devuelve la cantidad por kilos de compra hasta la fecha
DROP FUNCTION IF exists fn_TotalKilosDeProductoComprados;

DELIMITER //
CREATE FUNCTION fn_TotalKilosDeProductoCompradosHastaFecha(p_producto_id INT, p_fecha DATE)
RETURNS NUMERIC
DETERMINISTIC
BEGIN
    DECLARE v_total_kilos_comprados NUMERIC;
    SELECT SUM(cantidad_de_compra_por_kilo) INTO v_total_kilos_comprados
    FROM Compras
    WHERE id_product_fk = p_producto_id AND fecha_de_compra <= p_fecha;
    RETURN v_total_kilos_comprados;
END //

DELIMITER ;

SELECT fn_TotalKilosDeProductoCompradosHastaFecha(1,'2024-02-29') as kilosCompradosProductoHastaLaFecha; 

-- Funcion por la cual ingreso un producto y fecha y devuelve el monto de compra hasta la fecha
DROP FUNCTION IF exists fn_MontoTotalDeCompraHastaFecha;
DELIMITER //
CREATE FUNCTION fn_MontoTotalDeCompraHastaFecha(p_producto_id INT, p_fecha DATE)
RETURNS NUMERIC
DETERMINISTIC
BEGIN
    DECLARE v_monto_total NUMERIC;
    SELECT SUM(precio_por_kilo * cantidad_de_compra_por_kilo + precio_por_unidad * cantidad_de_compra_por_unidad) INTO v_monto_total
    FROM Compras
    WHERE id_product_fk = p_producto_id AND fecha_de_compra <= p_fecha;
    RETURN v_monto_total;
END //
DELIMITER ;

SELECT fn_MontoTotalDeCompraHastaFecha(1,'2024-02-29') as MontoTotalCompradosHastaLaFecha; 


-- Función para eliminar registros de id_product de tablas Ventas/Compras (para usar los triggers)
DROP FUNCTION IF EXISTS fn_eliminar_registro_por_id_product_tabla;

DELIMITER //
CREATE FUNCTION fn_eliminar_registro_por_id_product_tabla(p_id_product INT, p_tabla VARCHAR(255)) RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE success BOOLEAN DEFAULT TRUE;

    IF p_tabla = 'Compras' THEN
        DELETE FROM Compras WHERE id_product_fk = p_id_product;
    ELSEIF p_tabla = 'Ventas' THEN
        DELETE FROM Ventas WHERE id_product_fk = p_id_product;
    ELSE
        SET success = FALSE;
    END IF;
    IF ROW_COUNT() = 0 THEN
        SET success = FALSE;
    END IF;
    RETURN success;
END //
DELIMITER ;

SELECT fn_eliminar_registro_por_id_product_tabla(5, 'Compras');

SELECT fn_eliminar_registro_por_id_product_tabla(5, 'Ventas');


-- Funcion eliminar rregistro de tabla products x su pk_id_product
DROP FUNCTION IF EXISTS fn_eliminar_registro_por_pk_id_product;
DELIMITER //
CREATE FUNCTION fn_eliminar_registro_por_pk_id_product(p_pk_id_product INT) RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE success BOOLEAN DEFAULT TRUE;
    DELETE FROM Products WHERE pk_id_product = p_pk_id_product;
    IF ROW_COUNT() = 0 THEN
        SET success = FALSE;
    END IF;

    RETURN success;
END 
// DELIMITER ;

SELECT fn_eliminar_registro_por_pk_id_product(5);
