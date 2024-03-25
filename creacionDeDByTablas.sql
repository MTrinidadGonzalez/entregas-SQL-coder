DROP SCHEMA IF exists MACA_HERBORISTERIA; 
CREATE SCHEMA IF NOT exists MACA_HERBORISTERIA;
USE MACA_HERBORISTERIA;

CREATE TABLE Proveedores (
    pk_id_proveedor INT PRIMARY KEY AUTO_INCREMENT,
    proveedor_name VARCHAR(255) NOT NULL,
    proveedor_last_name VARCHAR(255) NOT NULL,
    proveedor_alias VARCHAR(255),
    proveedor_numero_telefono INT NOT NULL,
    proveedor_correo_electronico VARCHAR(255),
    proveedor_CBU_alias VARCHAR(255)
);
DROP TABLE IF EXISTS Products;
CREATE TABLE Products (
    pk_id_product INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(255) NOT NULL,
    product_alias VARCHAR(255),
    product_description TEXT,
    proveedor_fk INT,
    insumo_por_kilo BOOLEAN,
    insumo_por_unidades BOOLEAN,
    FOREIGN KEY (proveedor_fk) REFERENCES Proveedores(pk_id_proveedor)
);
CREATE TABLE Compras (
    pk_id_compra INT PRIMARY KEY AUTO_INCREMENT,
    id_product_fk INT,
    id_proveedor_fk INT,
    precio_por_kilo NUMERIC,
    precio_por_unidad NUMERIC,
    cantidad_de_compra_por_kilo VARCHAR(255),
    cantidad_de_compra_por_unidad INT,
    fecha_de_compra DATE,
    FOREIGN KEY (id_product_fk) REFERENCES Products(pk_id_product),
    FOREIGN KEY (id_proveedor_fk) REFERENCES Proveedores(pk_id_proveedor)
);
CREATE TABLE Clientes (
    pk_id_client INT PRIMARY KEY AUTO_INCREMENT,
    client_name VARCHAR(255) NOT NULL,
    client_last_name VARCHAR(255) NOT NULL,
    client_telefono INT,
    client_correo_electronico VARCHAR(255),
    cliente_CBU_alias VARCHAR(255)
);
CREATE TABLE Ventas (
    pk_id_venta INT PRIMARY KEY AUTO_INCREMENT,
    id_product_fk INT,
    id_client_fk INT,
    cantidad_venta_por_kilo VARCHAR(255),
    cantidad_venta_por_unidad VARCHAR(255),
    precio_venta_por_kilo NUMERIC,
    precio_por_unidad NUMERIC,
    fecha_de_venta DATE,
    FOREIGN KEY (id_product_fk) REFERENCES Products(pk_id_product),
    FOREIGN KEY (id_client_fk) REFERENCES Clientes(pk_id_client)
);

SELECT * FROM Ventas;