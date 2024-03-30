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


Funciones:
1-	fn_TotalGramosDeProductoVendidos:
Lo que realiza esta función es recibir como parámetros el id de un producto  referenciado de la tabla Products (de tipo INT) y una fecha límite (de tipo DATE). Luego busca en la tabla Ventas ese producto y hace la suma de los montos vendidos y lo almacena en la variable v_total_gramos_vendidos (de tipo número). 
2-	fn_MontoTotalVentas:
Recibe los mismos parámetros de entrada que la función anterior y busca en la tabla de ventas, solo que en este caso devuelve el monto total (o sea el dinero/costo) y lo almacena en la variable  v_total_monto.

3-	fn_eliminar_registro_por_id_product_tabla: Esta función es para eliminar una venta o compra en base a cualquiera de las tablas ingresadas (Ventas/Compras), y al id de producto ingresado (pk_id_product), ya que son tablas hijas que referencian a la tabla Products. Esta función y la siguiente son para luego poder utilizar los triggers. 
4-	fn_eliminar_registro_por_pk_id_product: Funciona para ingresar un id de un producto y que se elimine de la tabla Products. 
Procedimientos:
1-	ventas_x_fecha_con_montos:
Tiene como parámetro de salida p_fecha que es una fecha y como parámetro de salida total_ventas que es de tipo numérico. Realiza un conteo dentro de la tabla Ventas la cantidad de ventas ralizadas hasta la fecha indicada y la suma total (dinero ingresado) de la columna monto_de_venta. 
2-	El segundo procedimiento es similar al anterior, solo que en este caso, se ingresa un producto específico por su id (que está vinculado a la tabla Products) y buesca el monto total de las ventas hasta la fecha indicada. 


TRiggers:
1-	TRG_compras_elimindas: 
Este trigger registra en la tabla registro_compras_eliminadas antes (begin) de que una compra sea eliminada. 
2-	TRG_ventas_eliminadas:
También al igual que el anterior almacena la venta eliminada en la tabla registro_ventas_eliminadas.
3-	TRG_eliminar_producto:
Este trigger se realiza después de la acción (after) y los archiva en la tabla registro_productos_eliminados. En verdad los dos triggers anteriores son para que luego pueda realizarse la eliminación del producto ya que los id_product de los triggers anteriores están referenciados de esta tabla Products. 


