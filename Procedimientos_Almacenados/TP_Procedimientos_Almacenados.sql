-- -------------------------------------------------
-- *** Configuración Inicial de la Base de Datos ***
-- -------------------------------------------------
DROP DATABASE tp_procedimientos;
create database if not exists tp_procedimientos;
use tp_procedimientos;
CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL
);
CREATE TABLE productos (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(50) NOT NULL,
  descripcion VARCHAR(255) DEFAULT '',
  precio DECIMAL(10,2) NOT NULL,
  stock INT DEFAULT 0
);
CREATE TABLE ventas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL,
    fecha DATE NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id),
    FOREIGN KEY (producto_id) REFERENCES productos(id)
);
INSERT INTO clientes (nombre, direccion, telefono) VALUES
('Juan Pérez', 'Calle Falsa 123', '555-1234'),
('María García', 'Avenida Siempreviva 742', '555-5678'),
('Pedro González', 'Calle 13 No. 6-11', '555-9101'),
('Ana Hernández', 'Carrera 7 No. 32-60', '555-1212'),
('Luisa Rodríguez', 'Avenida Boyacá No. 64C-31', '555-1415'),
('Carlos Vargas', 'Carrera 23 No. 45-67', '555-1617');
INSERT INTO productos (nombre, descripcion, precio, stock) VALUES
('Laptop', 'Laptop Dell XPS 13', 1200.00, 15),
('Mouse', 'Mouse Logitech MX Master 3', 80.00, 30),
('Teclado', 'Teclado Mecánico Razer BlackWidow', 150.00, 20);
INSERT INTO ventas (cliente_id, producto_id, cantidad, fecha) VALUES
(1, 1, 5, '2022-01-01'),
(1, 2, 3, '2022-01-02'),
(2, 3, 2, '2022-01-03'),
(3, 2, 4, '2022-01-05'),
(3, 3, 1, '2022-01-06');

-- -------------------------------------------------
-- Ejercicio 1: Calcular Ventas Totales por Producto 
-- -------------------------------------------------
drop procedure if exists pa_ventas_total_producto;
-- Se cambia el delimitador a // para poder usar el punto y coma dentro del cuerpo del procedimiento.
delimiter //
-- Creo el procedimiento 'pa_ventas_total_producto'.
-- Recibo el ID del producto (IN), y retorno el monto total (OUT) y la cantidad total (OUT).
create procedure pa_ventas_total_producto
(
  in p_producto_id int,
  out p_nombre_producto varchar(50), -- Incluyo que muestre el nombre
  out p_monto_total decimal(10,2),
  out p_cantidad_unidades int
)
begin
  -- Voy a calcular la suma del monto total y la cantidad total, y obtengo el nombre.
  select 
    p.nombre,                          -- Selecciono el nombre del producto
    sum(v.cantidad * p.precio),        -- Calculo el Monto Total
    sum(v.cantidad)                    -- Calculo la Cantidad Total de unidades
  into p_nombre_producto, p_monto_total, p_cantidad_unidades -- Asigno los 3 resultados.
  from ventas as v 
  inner join productos as p on v.producto_id = p.id  
  where v.producto_id = p_producto_id
  -- Es crucial usar GROUP BY cuando se usa una función agregada (SUM) junto a una columna no agregada (p.nombre),
  -- aunque en este caso, al filtrar por un solo ID, el resultado es una única fila.
  group by p.nombre; 
end //

-- Restablezco el delimitador original a ;
delimiter ;
-- Prueba: Voy a probar con el producto con ID 1 ('Laptop').
-- Declaro las variables para recibir los valores de salida.
call pa_ventas_total_producto(1, @nombre_prod, @total_monto, @total_cant);
-- Muestro el resultado de las variables para verificar el cálculo y uso alias para los nombres de las columnas.
select 
    @nombre_prod as NombreProducto, 
    @total_monto as MontoTotal, 
    @total_cant as CantidadUnidades;

-- -------------------------------------------------
-- Ejercicio 2: Actualizar Stock y Retornar Nuevo Stock 
-- -------------------------------------------------
drop procedure if exists pa_actualizar_stock;
delimiter //
-- Creo el procedimiento 'pa_actualizar_stock'.
-- Recibo el ID del producto (IN) y la cantidad a vender (INOUT), la cual voy a usar también para 
-- retornar el nuevo stock, como en los ejemplos de INOUT.
create procedure pa_actualizar_stock
(
  in p_producto_id int,
  inout p_cantidad_vendida int
)
begin
  -- Declaro una variable local para almacenar el stock actual del producto.
  declare v_stock_actual int;

  -- Obtengo el stock actual del producto y lo guardo en mi variable local.
  select stock into v_stock_actual
  from productos
  where id = p_producto_id;

  -- Voy a usar una estructura condicional IF para verificar si hay suficiente stock, similar al ejemplo de IF ELSE.
  if v_stock_actual >= p_cantidad_vendida then
    -- Si el stock actual es suficiente:
    -- Primero, actualizo la tabla 'productos' disminuyendo el stock.
    update productos
    set stock = stock - p_cantidad_vendida
    where id = p_producto_id;
    
    -- Luego, actualizo el parámetro INOUT con el nuevo valor de stock, que será retornado al llamador.
    set p_cantidad_vendida = v_stock_actual - p_cantidad_vendida;
    
  else
    -- Si no hay stock suficiente, voy a establecer el parámetro INOUT a -1 (entendiendolo como False)
    -- como indicador de que la venta no se realizó.
    set p_cantidad_vendida = -1;
    
  end if;

end //
delimiter ;

-- Prueba venta exitosa:
-- El producto 2 ('Mouse') tiene 30 unidades de stock.
-- Simulo un venta de 5 unidades.
set @stock_resultante = 5; 
call pa_actualizar_stock(2, @stock_resultante);
-- Muestro el resultado.
select @stock_resultante as NuevoStock_Exitoso;
-- Verifico el stock en la tabla para ver que coincida.
select stock from productos where id=2; 
-- Pruebav venta no exitosa:
-- El producto 2 ('Mouse') tiene ahora 25 unidades de stock.
-- Simulo un venta de 30 unidades.
set @stock_resultante = 30; 
call pa_actualizar_stock(2, @stock_resultante);
-- El resultado esperado es -1 (venta no exitosa).
select @stock_resultante as NuevoStock_Exitoso;
-- Verifico el stock en la sea el anterior 25 y no haya cambiado.
select stock from productos where id=2; 

-- -------------------------------------------------
-- Ejercicio 3: Listar Ventas por Cliente y Rango de Fechas
-- -------------------------------------------------
drop procedure if exists pa_ventas_cliente_rango;
delimiter //
-- Creo el procedimiento 'pa_ventas_cliente_rango'. Recibo los tres parámetros (IN) que necesito para filtrar.
create procedure pa_ventas_cliente_rango
(
  in p_cliente_id int,
  in p_fecha_inicio date,
  in p_fecha_fin date
)
begin
  -- Selecciono los detalles de las ventas. Necesito un JOIN para obtener los nombres y precios.
  select 
    c.nombre as Cliente,                  -- Selecciono el nombre del cliente.
    p.nombre as Producto,                 -- Selecciono el nombre del producto.
    v.cantidad as Cantidad_Vendida,       -- Selecciono la cantidad de unidades en la venta.
    v.fecha as Fecha_Venta,               -- Selecciono la fecha de la venta.
    (v.cantidad * p.precio) as Subtotal   -- Calculo el subtotal de la venta.
  from ventas as v                        -- Selecciono de la tabla 'ventas' (v).
  inner join clientes as c on v.cliente_id = c.id -- Uno con 'clientes' (c) para obtener el nombre.
  inner join productos as p on v.producto_id = p.id -- Uno con 'productos' (p) para obtener el nombre y precio.
  where 
    v.cliente_id = p_cliente_id           -- Filtro las ventas por el ID de cliente que me pasaron.
    and v.fecha between p_fecha_inicio and p_fecha_fin; -- Filtro para que la fecha de la venta esté dentro del rango.
end //
delimiter ;
-- Prueba: Voy a probar con el cliente con ID 1 ('Juan Pérez') entre '2022-01-01' y '2022-01-05'.
call pa_ventas_cliente_rango(1, '2022-01-01', '2022-01-05');

-- -------------------------------------------------
-- Ejercicio 4: Calcular Precio Promedio Ponderado Comprado por un Cliente 
-- -------------------------------------------------
drop procedure if exists pa_promedio_precio_cliente;
delimiter //
-- Creo el procedimiento 'pa_promedio_precio_cliente'. Recibo el ID del cliente 
-- y retorno el promedio ponderado.
create procedure pa_promedio_precio_cliente
(
  in p_cliente_id int,
  out p_precio_promedio decimal(10,2)
)
begin
  -- Declaro variables locales para el numerador y el denominador de la fórmula del promedio ponderado.
  declare v_monto_total_compras decimal(10,2);
  declare v_cantidad_total_unidades int;
  
  -- Calculo el numerador (Monto Total de Compras): Suma de (Cantidad Vendida * Precio del Producto).
  select 
    sum(v.cantidad * p.precio) into v_monto_total_compras -- Calculo el total gastado y lo guardo en mi variable local.
  from ventas as v 
  inner join productos as p on v.producto_id = p.id
  where v.cliente_id = p_cliente_id;
  
  -- Calculo el denominador (Cantidad Total de Unidades): Suma de Cantidad Vendida.
  select 
    sum(v.cantidad) into v_cantidad_total_unidades -- Calculo el total de unidades compradas y lo guardo.
  from ventas as v 
  where v.cliente_id = p_cliente_id;
  
  -- Calculo el promedio ponderado: Monto Total / Cantidad Total de Unidades. 
  -- Uso una verificación IF para evitar división por cero.
  if v_cantidad_total_unidades > 0 then
    -- Si el cliente tiene compras, realizo la división y guardo el resultado en el parámetro de salida.
    set p_precio_promedio = v_monto_total_compras / v_cantidad_total_unidades;
  else
    -- Si el cliente no ha comprado nada, retorno 0.
    set p_precio_promedio = 0;
  end if;

end //
delimiter ;
-- Prueba: Voy a probar con el cliente con ID 1 ('Juan Pérez').
-- El resultado esperado es 780.00: (5*1200 + 3*80) / (5 + 3) = 6240 / 8
set @precio_promedio = 0; -- Inicializo la variable para recibir la salida.
call pa_promedio_precio_cliente(1, @precio_promedio);

-- Muestro el resultado.
select @precio_promedio as PrecioPromedioPonderado;