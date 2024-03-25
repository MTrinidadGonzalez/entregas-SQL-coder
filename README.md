La base de datos consiste en una herboristería llamada Maca, cuenta con las tablas de proveedores, productos, compras, ventas y clientes. 

El esquema lo compongo con las siguientes tablas: 

1)	Tabla Proveedores con las siguientes columnas: pk_id_proveedor (auto increentable obligatoria), proveedor_name (obligatoria, varchar), proveedor_last_name (obligatoria,varchar) , proveedor_alias (opcional,varchar), proveedor_numero_telefono (obligatorio, numerico) , proveedor_correo_electronico (opcional), proveedor_CBU_alias (opcional)

2)	Tabla Products con las siguientes columnas: pk_id_product (auto incrementable) , product_name (obligatorio, varchar) , product_alias (no obligatorio, varchar), product_description (no obligatorio), proveedor (esto se enlaza con el id_provedor la tabla Provedores), insumo_por_kilo (si /no), insumo_por_unidades (si/ no)

3)	 Tabla Compras con las siguientes columnas: pk_id_compra (autoincrementable), id_product (vinculado con pk_id_product de la tabla products), id_proveedor (vinculado con pk_id_proveedor de la tabla Proveedores),precio_por_kilo (opcional), pricio_por_unidad (opcional), cantidad_de_compra_por_kilo (opcional, varchar), cantidad_de_compra_por_unidad (opcional, numerico), fecha_de_compra (dato de fecha dia mes y año)

4)	Tabla Clientes: pk_id_client (autoincrementable), client_name (varchar, obligatorio), client_last_name (varchar,obligatorio), client_telefono (numerico, no obligatorio), client_correo_electronico (tipo correo electrónico, no obligatorio), cliente_CBU_alias (varchar, no obligatorio)

5)	Tabla Ventas con las siguientes columnas: pk_id_venta (autoincrementable), id_product (vinculado con pk_id_product de la tabla products), id_client (vinculado a pk_id_client de la tabla Clientes), cantidad_venta_por_kilo (varchar, no obligatorio), cantidad_venta_por_unidad (varchar, no obligatorio), precio_venta_por_kilo (opcional, numerico), precio_por_unidad (numerico, opcional), fecha_de_venta (dato de fecha dia mes y año).

Para crear la db:

DROP SCHEMA IF exists MACA_HERBORISTERIA; 
CREATE SCHEMA IF NOT exists MACA_HERBORISTERIA;
USE MACA_HERBORISTERIA;

