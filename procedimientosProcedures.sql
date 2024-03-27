-- Procedure en la cual ingreso una fecha y me devuelve todas las ventas hasta esa fecha y total de monto
DROP PROCEDURE IF EXISTS  ventas_x_fecha_con_montos;

DELIMITER //
CREATE PROCEDURE ventas_x_fecha_con_montos(IN p_fecha DATE, OUT total_ventas INT, OUT suma_montos DECIMAL(10,2))
BEGIN
    SELECT COUNT(*), SUM(monto_de_venta) INTO total_ventas, suma_montos
    FROM Ventas
    WHERE fecha_de_venta <= p_fecha;
END //
DELIMITER ;

CALL ventas_x_fecha_con_montos('2024-02-29', @total_ventas_fecha_29_02, @suma_montos_fecha_29_02);
CALL ventas_x_fecha_con_montos('2024-03-29', @total_ventas_fecha_29_03, @suma_montos_fecha_29_03);

SELECT @total_ventas_fecha_29_02 AS ventas_hasta_febrero, @suma_montos_fecha_29_02 AS suma_montos_febrero,
       @total_ventas_fecha_29_03 AS ventas_hasta_marzo, @suma_montos_fecha_29_03 AS suma_montos_marzo;




-- Procedimiento por el cual ingreso el id de producto y hace un conteo de el en la tabla de ventas
DROP PROCEDURE IF EXISTS ventas_producto_x_con_fecha;
DELIMITER //
CREATE PROCEDURE ventas_producto_x_con_fecha (IN p_id_producto INT, IN p_fecha DATE, OUT total_ventas INT)
BEGIN
    SELECT COUNT(*) INTO total_ventas
    FROM Ventas
    WHERE id_product_fk = p_id_producto AND fecha_de_venta <= p_fecha;
END //
DELIMITER ;

CALL ventas_producto_x_con_fecha(1, '2024-02-29', @total_ventas_cacao_amargo_febrero);
CALL ventas_producto_x_con_fecha(3, '2024-03-29', @total_ventas_te_verde_marzo);

SELECT @total_ventas_cacao_amargo_febrero AS ventas_cacao_amargo_febrero,
       @total_ventas_te_verde_marzo AS ventas_te_verde_marzo;








