CREATE DATABASE transacciones
    DEFAULT CHARACTER SET = 'utf8mb4';

USE transacciones;

-- ------------------------------------------------------
-- EJERCICIO 1: Transferencia de fondos 
-- Realiza una transacción que transfiera $100 desde la cuenta de origen (cuenta A) 
-- a la cuenta de destino (cuenta B).
-- ------------------------------------------------------

CREATE TABLE cuentas (
    numero_cuenta VARCHAR(10) PRIMARY KEY, 
    saldo DECIMAL(10, 2)                   
);

INSERT INTO cuentas (numero_cuenta, saldo) VALUES
('A', 1000.00),
('B', 750.00),
('C', 1200.00),
('D', 500.00),
('E', 2000.00);

SELECT * FROM cuentas;

START TRANSACTION;

    -- Resto $100.00 de la cuenta de origen (cuenta A).
    UPDATE cuentas SET saldo = saldo - 100.00 WHERE numero_cuenta = 'A';

    -- Sumo $100.00 a la cuenta de destino (cuenta B).
    UPDATE cuentas SET saldo = saldo + 100.00 WHERE numero_cuenta = 'B';

-- Confirmo la transacción (COMMIT) para hacer los cambios permanentes.
COMMIT;

-- Confirmo los saldos de las cuentas para verificar la transferencia.
SELECT * FROM cuentas;

-- ------------------------------------------------------
-- Ejercicio 2 Crea un procedimiento almacenado llamado ActualizarInventario 
-- que tome dos parámetros de entrada:
-- producto_id (VARCHAR, 10): El identificador del producto a actualizar.
-- cantidad_a_restar (INT): La cantidad que se restará del inventario.
--      * Obtene la cantidad actual del producto especificado.
--      * Verifica si la cantidad restada sería válida (mayor o igual a cero).
--      * Si la cantidad es válida, realiza la actualización del inventario restando 
--          la cantidad especificada.
--      * Si la cantidad restada sería negativa, muestra un mensaje al usuario 
--          indicando que la operación se cancela y realiza un rollback
-- ------------------------------------------------------  
CREATE TABLE inventario (
    producto_id VARCHAR(10) PRIMARY KEY, 
    cantidad INT                         
);

INSERT INTO inventario (producto_id, cantidad) VALUES
('Producto1', 50),
('Producto2', 30),
('Producto3', 70),
('Producto4', 20),
('Producto5', 60);

SELECT * FROM inventario;

drop PROCEDURE IF EXISTS ActualizarInventario;
DELIMITER //
CREATE PROCEDURE ActualizarInventario (
    IN p_producto_id VARCHAR(10),
    IN p_cantidad_a_restar INT
)
BEGIN
    DECLARE v_cantidad_actual INT;
    START TRANSACTION;
    SELECT cantidad INTO v_cantidad_actual FROM inventario WHERE producto_id = p_producto_id;
    IF v_cantidad_actual - p_cantidad_a_restar >= 0 THEN
        UPDATE inventario 
        SET cantidad = v_cantidad_actual - p_cantidad_a_restar 
        WHERE producto_id = p_producto_id;
        COMMIT;
        SELECT CONCAT('Inventario actualizado para ', p_producto_id, '. Cantidad restante: ', v_cantidad_actual - p_cantidad_a_restar) AS Mensaje;
    ELSE
        SELECT 'Inventario negativo. Operación cancelada.' AS Mensaje;
        ROLLBACK;
    END IF;
END;
//
DELIMITER ;

-- Llamo al procedimiento para probar un caso exitoso.
-- 'Producto1' tiene 50. Resto 15. Resultado esperado: 35.
CALL ActualizarInventario('Producto1', 15);

-- Llamo al procedimiento para probar un caso de rollback (cantidad negativa).
-- 'Producto1' ahora tiene 35. Resto 1500. Resultado esperado: Mensaje de error y ROLLBACK.
CALL ActualizarInventario('Producto1', 1500);

SELECT * FROM inventario;

-- ------------------------------------------------------   
-- EJERCICIO 3: Registrar Compra
-- Crea un procedimiento almacenado llamado RegistrarCompra que tome dos parámetros de entrada:
--  * cuenta (VARCHAR, 10): El número de cuenta del cliente.
--  * monto (DECIMAL, 10, 2): El monto de la compra.
-- En el procedimiento, utiliza una transacción para realizar la actualización del saldo y el 
-- registro de la transacción:
--  * Obtene el saldo actual de la cuenta especificada.
--  * Verifica si el saldo es suficiente para la compra.
--  * Si el saldo es suficiente, resta el monto de la compra del saldo y registra la transacción 
--    en la tabla transacciones.
--  * Si el saldo no es suficiente, muestra un mensaje de error al cliente indicando que la compra 
--    se cancela y realiza un rollback.
-- ------------------------------------------------------

drop table if exists cuentas_clientes;
CREATE TABLE cuentas_clientes (
    numero_cuenta VARCHAR(10) PRIMARY KEY,
    saldo DECIMAL(10, 2)
);

INSERT INTO cuentas_clientes (numero_cuenta, saldo) VALUES
('Cuenta1', 1000.00),
('Cuenta2', 750.00),
('Cuenta3', 1200.00),
('Cuenta4', 500.00),
('Cuenta5', 2000.00);

drop table if exists transacciones;
CREATE TABLE transacciones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    numero_cuenta VARCHAR(10),
    monto DECIMAL(10, 2),
    fecha_transaccion TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Agrego la fecha de la transacción.
);

SELECT * FROM cuentas_clientes;
select * from transacciones

DELIMITER //

drop PROCEDURE IF EXISTS RegistrarCompra;
CREATE PROCEDURE RegistrarCompra (
    IN p_cuenta VARCHAR(10),
    IN p_monto DECIMAL(10, 2)
)
BEGIN   
    DECLARE v_saldo_actual DECIMAL(10, 2);
    START TRANSACTION;
    SELECT saldo INTO v_saldo_actual FROM cuentas_clientes WHERE numero_cuenta = p_cuenta;

-- Verifico si el saldo es suficiente para la compra
    IF v_saldo_actual >= p_monto THEN
        UPDATE cuentas_clientes SET saldo = v_saldo_actual - p_monto WHERE numero_cuenta = p_cuenta;        
        INSERT INTO transacciones (numero_cuenta, monto) VALUES (p_cuenta, p_monto);        
        COMMIT;

        SELECT CONCAT('Compra registrada para ', p_cuenta, '. Saldo actualizado: ', v_saldo_actual - p_monto) AS Mensaje;
    ELSE
 -- Caso contrario genero un rollback
        SELECT 'Saldo insuficiente. La compra ha sido cancelada.' AS Mensaje;
        ROLLBACK;
    END IF;
END;
//
DELIMITER ;

-- Llamo al procedimiento para probar un caso exitoso. 
-- 'Cuenta1' tiene 1000.00. Compra de 250.50. Resultado esperado: Saldo 749.50 y registro en transacciones. COMMIT.
CALL RegistrarCompra('Cuenta1', 250.00);

-- Llamo al procedimiento para probar un caso de rollback (saldo insuficiente). 
-- 'Cuenta1' ahora tiene 749.50. Compra de 800.00. Resultado esperado: Mensaje de error. ROLLBACK.
CALL RegistrarCompra('Cuenta1', 800.00);

-- Muestro el saldo final de las cuentas.
SELECT * FROM cuentas_clientes;

-- Muestro el registro de transacciones para verificar el COMMIT exitoso.
SELECT * FROM transacciones;