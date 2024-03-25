-- Procedure en la cual ingreso una fecha y me devuelve todas las ventas hasta esa fecha cuyo monto sea mayos a 2000
DROP PROCEDURE IF EXISTS  ventas_monto_mayor_a_1500;

DELIMITER //
CREATE PROCEDURE ventas_monto_mayor_a_1500 (IN p_fecha DATE, OUT id_producto_fk INT, OUT montos_mayores_a_1500 DECIMAL(10,2))
BEGIN
    SELECT id_product_fk, SUM(monto_de_venta) INTO id_producto_fk, montos_mayores_a_1500
    FROM Ventas
    WHERE fecha_de_venta <= p_fecha AND monto_de_venta > 1500
    GROUP BY id_product_fk
    ORDER BY SUM(monto_de_venta) DESC
    LIMIT 1;
END //
DELIMITER ;

CALL ventas_monto_mayor_a_1500('2024-02-29', @id_producto, @montos_mayores);
SELECT @id_producto AS id_producto_fk, @montos_mayores AS montos_mayores_a_1500;