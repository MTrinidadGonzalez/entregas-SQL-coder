-- Vistas:
-- Vista tabla Proveedores
CREATE VIEW VW_Proveedores AS
(SELECT * FROM Proveedores);

SELECT * FROM VW_Proveedores;

-- Vista  tabla Products
CREATE VIEW VW_Products AS
(SELECT * FROM Products);

SELECT * FROM VW_Products;

-- Vista para la tabla Compras
CREATE VIEW VW_Compras AS
(SELECT * FROM Compras);

SELECT * FROM VW_Compras; 

-- Vista para la tabla Clientes
CREATE VIEW VW_Clientes AS
(SELECT * FROM Clientes);

-- Vista para la tabla Ventas
CREATE VIEW VW_Ventas AS
(SELECT * FROM Ventas);

SELECT * FROM VW_Ventas;