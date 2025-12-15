-- =============================
-- FUNCIONES
-- =============================
-- -----------------------------
-- FUNCION CALCULAR VENTAS
-- -----------------------------
DROP DATABASE IF EXISTS calcular_ventas;
CREATE DATABASE calcular_ventas;
USE calcular_ventas;
CREATE TABLE ventas (
    id_factura INT PRIMARY KEY AUTO_INCREMENT,  -- Clave primaria autoincremental
    fecha DATE NOT NULL,                        
    numero_boleta INT NOT NULL UNIQUE,          
    monto_total FLOAT NOT NULL                  
);
INSERT INTO ventas (fecha, numero_boleta, monto_total) VALUES
('2025-01-05', 1000, 1550.00),
('2025-01-12', 1001, 3200.00),
('2025-01-19', 1002, 4850.00),
('2025-01-26', 1003, 1100.00),
('2025-02-03', 1004, 2500.00),
('2025-02-10', 1005, 4125.00),
('2025-02-17', 1006, 1780.00),
('2025-02-24', 1007, 3999.00),
('2025-03-07', 1008, 1050.00),
('2025-03-14', 1009, 2950.00),
('2025-03-21', 1010, 4500.00),
('2025-03-28', 1011, 2100.00),
('2025-04-04', 1012, 1999.00),
('2025-04-11', 1013, 3700.00),
('2025-04-18', 1014, 1345.00),
('2025-04-25', 1015, 4999.00);
-- Verifico los registros insertados
select * from ventas;
-- Creo la función "calcular_total_ventas"
DELIMITER $$ 
CREATE FUNCTION calcular_total_ventas (p_mes INT, p_anio INT)
RETURNS FLOAT READS SQL DATA 
BEGIN
    DECLARE total_ventas FLOAT; -- Variable local 

    -- Calculo la suma de 'monto_total' de las ventas que coinciden con el mes y año proporcionados.
    SELECT SUM(monto_total)
    INTO total_ventas -- Almaceno el resultado de la suma en la variable local
    FROM ventas
    WHERE MONTH(fecha) = p_mes -- Filtra por el mes
      AND YEAR(fecha) = p_anio; -- Filtra por el año

    -- Si no hay ventas (SUM devuelve NULL), devuelve 0.0, sino devuelve el total calculado.
    RETURN IFNULL(total_ventas, 0.0);
END
$$ DELIMITER ; 
-- Consulta para verificar manualmente el total de ventas de Enero de 2025 (Mes 1)
SELECT SUM(monto_total) AS total_manual_enero FROM ventas WHERE MONTH(fecha) = 1 AND YEAR(fecha) = 2025;
-- Consulta usando la función
SELECT calcular_total_ventas(1, 2025) AS total_por_funcion_enero;

-- -----------------------------
-- FUNCION OBTENER EMPLEADO
-- -----------------------------
DROP DATABASE IF EXISTS obtener_empleado;
CREATE DATABASE obtener_empleado;
USE obtener_empleado;
CREATE TABLE empleado (
    id_empleado INT PRIMARY KEY AUTO_INCREMENT, -- Clave primaria autoincremental
    apellido VARCHAR(50) NOT NULL,              -- Apellido del empleado
    nombre VARCHAR(50) NOT NULL,                -- Nombre del empleado
    numero_cuil BIGINT UNIQUE NOT NULL,         -- Número de CUIL (BIGINT para 11 dígitos, debe ser UNIQUE)
    fecha_ingreso DATE NOT NULL                 -- Fecha de ingreso a la empresa
);
INSERT INTO empleado (apellido, nombre, numero_cuil, fecha_ingreso) VALUES
('Gómez', 'Juan Pablo', 20354123886, '2024-03-15'),
('Rodríguez', 'Martín', 20389654217, '2023-01-20'),
('Díaz', 'Alejandro', 20401587635, '2025-02-01'),
('Pérez', 'Sebastián', 20327498514, '2024-08-10'),
('López', 'Enzo', 20361234789, '2023-11-25'),
('Martínez', 'Facundo', 20395687120, '2025-01-05'),
('García', 'Nicolás', 20372345601, '2024-05-30'),
('Fernández', 'Lucas', 20348765932, '2023-07-12'),
('Sánchez', 'Lucía', 27339876543, '2024-02-01'),
('Romero', 'Sofía', 27301456789, '2023-04-18'),
('Torres', 'Valentina', 27415029387, '22025-03-22'),
('Álvarez', 'Camila', 27387654321, '2024-11-11'),
('Ruiz', 'Agustina', 27318765409, '2023-03-01'),
('Flores', 'Julieta', 27362109876, '2024-09-05'),
('Acosta', 'Milagros', 27345678901, '2025-01-15'),
('Benítez', 'Emilia', 27370011223, '2023-10-07');
-- Verifico los registros insertados
SELECT * FROM empleado;
-- Creo la función "obtener_nombre_empleado"
DELIMITER $$ 
CREATE FUNCTION obtener_nombre_empleado (p_id INT)
RETURNS VARCHAR(101) READS SQL DATA -- Variable local
BEGIN
    DECLARE nombre_completo VARCHAR(101); -- Variable local para almacenar el resultado
    SELECT CONCAT(apellido, ', ', nombre) -- Concateno nombre y apellido
    INTO nombre_completo -- Almacenar el resultado en la variable local
    FROM empleado
    WHERE id_empleado = p_id;
    RETURN IFNULL(nombre_completo, 'Empleado no encontrado'); -- En caso negativo devuelvo este mensaje 
END
$$ DELIMITER ; 
-- Consulta para verificar el nombre completo del empleado con ID 1
SELECT obtener_nombre_empleado(1) AS Nombre_Empleado_ID_1;
-- Consulta para verificar un usuario inexistente
SELECT obtener_nombre_empleado(20) AS Nombre_Empleado_Inexistente;

-- =============================================================================================================
-- =============================
-- PROCEDIMIENTOS ALMACENADOS
-- =============================

-- -----------------------------
-- Procedimiento Obtiene Promedio
-- -----------------------------
DROP DATABASE IF EXISTS obtener_promedio;
CREATE DATABASE obtener_promedio;
USE obtener_promedio;
CREATE TABLE curso (
    id_curso INT PRIMARY KEY AUTO_INCREMENT,
    nombre_curso VARCHAR(30) NOT NULL UNIQUE
);
CREATE TABLE alumnos (
    id_alumno INT PRIMARY KEY AUTO_INCREMENT,
    apellido_alumno VARCHAR(50) NOT NULL,
    nombre_alumno VARCHAR(50) NOT NULL,
    dni_alumno BIGINT UNIQUE NOT NULL
);
CREATE TABLE notas (
    id_notas INT PRIMARY KEY AUTO_INCREMENT,
    id_alumno INT NOT NULL,
    id_curso INT NOT NULL,
    nota FLOAT CHECK (nota >= 0 AND nota <= 10), -- Restricción para asegurar nota entre 0 y 10
    -- Defino de las claves foráneas
    FOREIGN KEY (id_alumno) REFERENCES alumnos(id_alumno),
    FOREIGN KEY (id_curso) REFERENCES curso(id_curso),
    -- Me aseguro que un alumno solo tenga una nota por curso
    UNIQUE (id_alumno, id_curso)
);
INSERT INTO curso (nombre_curso) VALUES
('Matemática'),
('Informática'),
('Lengua'),
('Historia'),
('Geografía'),
('Lógica');
INSERT INTO alumnos (apellido_alumno, nombre_alumno, dni_alumno) VALUES
('Sánchez', 'Lautaro', 45123456),
('Gómez', 'Emilia', 46789012),
('Pérez', 'Valentín', 45567890),
('Díaz', 'Martina', 46345678),
('López', 'Facundo', 45901234),
('Martínez', 'Sofía', 46112233),
('Rodríguez', 'Juan Cruz', 45887766),
('Fernández', 'Lucía', 46554433),
('Álvarez', 'Nicolás', 45332211),
('Ruiz', 'Abril', 46998877);
INSERT INTO notas (id_alumno, id_curso, nota) VALUES
(1, 1, 8.5), (2, 1, 7.0), (3, 1, 9.2), (4, 1, 6.5), (5, 1, 8.8),
(1, 2, 9.0), (3, 2, 7.5), (6, 2, 6.0), (7, 2, 8.0), (9, 2, 7.7),
(2, 3, 5.0), (4, 3, 7.5), (6, 3, 8.2), (8, 3, 9.5),
(5, 4, 7.0), (7, 4, 6.0), (9, 4, 8.5), (10, 4, 9.0);

-- Procedimiento almacenado "obtener_promedio"
DELIMITER $$ 
CREATE PROCEDURE obtener_promedio (IN p_nombre_curso VARCHAR(100))
BEGIN
    -- Declaro variables para almacenar el ID del curso y el promedio
    DECLARE v_id_curso INT;
    DECLARE v_promedio FLOAT;

    SELECT id_curso INTO v_id_curso
    FROM curso
    WHERE nombre_curso = p_nombre_curso;
    -- Verifico si el cursoexiste
    IF v_id_curso IS NULL THEN
        -- Si el curso no existe muestro un mensaje de error
        SELECT CONCAT('Error: El curso "', p_nombre_curso, '" no existe.') AS Mensaje;
    ELSE
        -- Si existe calcula el promedio de las notas
        SELECT AVG(n.nota) INTO v_promedio
        FROM notas n
        WHERE n.id_curso = v_id_curso;
        -- Muestro el resultado
        IF v_promedio IS NULL THEN
            -- Si existe pero no tiene notas almacenadas muestro este mensaje
            SELECT CONCAT('El curso "', p_nombre_curso, '" no tiene notas registradas.') AS Resultado;
        ELSE
            -- Caso contrario muestro el curso y el promedio
            SELECT
                p_nombre_curso AS Curso,
                ROUND(v_promedio, 2) AS Promedio_General
            FROM DUAL; 
        END IF;
    END IF;
END
$$ DELIMITER ; 

-- Ejecuto el procedimiento para el curso 'Matemática'
CALL obtener_promedio('Matemática');
-- Ejecuto el procedimiento para el curso 'Física' (inexistente)
CALL obtener_promedio('Física');
-- Ejecuto el procedimiento para el curso 'Logica' (existe sin notas)
CALL obtener_promedio('Lógica');

-- -----------------------------
-- GESTION DE STOCK
-- -----------------------------
drop DATABASE IF EXISTS gestion_stock;
CREATE DATABASE gestion_stock;
USE gestion_stock;

CREATE TABLE producto (
    id_producto INT PRIMARY KEY AUTO_INCREMENT,
    nombre_producto VARCHAR(30) NOT NULL,
    stock_actual INT DEFAULT 0 -- Campo crucial para el stock
);
CREATE TABLE compras (
    id_compras INT PRIMARY KEY AUTO_INCREMENT,
    fecha_compra DATE NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

INSERT INTO producto (nombre_producto, stock_actual) VALUES
('Tornillos M8', 100), -- ID 1
('Arandelas 1/4', 50), -- ID 2
('Tuercas 3/8', 200);  -- ID 3

-- Procedimiento almacenado "actualizar_stock"
DELIMITER $$ 
CREATE PROCEDURE actualizar_stock (
    IN p_id_producto INT,
    IN p_cantidad_a_sumar INT
)
BEGIN
    -- Verificar si la cantidad a sumar es negativa para evitar restas accidentales
    IF p_cantidad_a_sumar < 0 THEN
        -- SQLSTATE '45000' es un estado genérico para errores definidos por el usuario
        -- Me permite generar un error personalizado
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La cantidad a sumar debe ser positiva.';
    ELSE
        -- Realizar la actualización del stock
        UPDATE producto
        SET stock_actual = stock_actual + p_cantidad_a_sumar -- Suma la cantidad proporcionada al stock actual
        WHERE id_producto = p_id_producto;

        -- Verifico si se actualizó algún registro
        IF ROW_COUNT() = 0 THEN
            -- Comprobacion para caso no viable:
            -- Si no se afectó ninguna fila, el ID del producto es inválido
            SELECT CONCAT('Error: Producto con ID ', p_id_producto, ' es inexistente.') AS Resultado;
        ELSE
            -- Si la actualización fue exitosa, mostrar el nuevo stock
            SELECT
                p_id_producto AS ID_Producto,
                p.nombre_producto AS Producto,
                p.stock_actual AS Nuevo_Stock
            FROM producto p
            WHERE p.id_producto = p_id_producto;
        END IF;
    END IF;
END
$$ DELIMITER ; 

-- Caso positivo: Sumo 75 unidades al producto ID 1
CALL actualizar_stock(1, 75);
-- Caso negativo: Ejecuto el procedimiento con un ID inexistente
CALL actualizar_stock(99, 10);

-- =============================================================================================================
-- =============================
-- VISTAS
-- =============================

USE pubs;
-- Creo una vista que combina el título, el autor, el precio y la editorial solo de libros de cocina.
CREATE VIEW vista_libros_cocina AS
SELECT
    t.title AS Titulo,                      -- Título del libro
    CONCAT(a.au_lname, ', ', a.au_fname) AS Autor_Completo, -- Nombre y apellido del autor
    t.price AS Precio,                      -- Precio del libro
    p.pub_name AS Editorial                 -- Nombre de la editorial
FROM
    titles t
-- Uso un INNER JOIN para asegurar que solo se incluyan títulos con autores relacionados y que existan
JOIN
    titleauthor ta ON t.title_id = ta.title_id -- Relaciona títulos con autores
JOIN
    authors a ON ta.au_id = a.au_id           -- Obtiene los nombres de los autores
-- Uso un LEFT JOIN para incluir todos los títulos, incluso si no tienen una editorial asociada 
LEFT JOIN
    publishers p ON t.pub_id = p.pub_id       -- Obtiene el nombre de la editorial
WHERE
    t.type IN ('mod_cook', 'trad_cook');      -- Filtra solo por libros de cocina (moderna y tradicional)

-- Verifico el contenido de la vista
SELECT * FROM vista_libros_cocina;

-- =============================================================================================================
-- =============================
-- INDICES
-- =============================
drop DATABASE IF EXISTS indices;
create DATABASE indices;
use indices;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS fabricantes;

CREATE TABLE fabricantes (
    id_fabricante INT PRIMARY KEY,
    nombre_fabricante VARCHAR(255) NOT NULL
);

INSERT INTO fabricantes (id_fabricante, nombre_fabricante)
VALUES (1, 'Fabricante A'),
       (2, 'Fabricante B'),
       (3, 'Fabricante C');

CREATE TABLE productos (
    id_producto INT PRIMARY KEY,
    id_fabricante INT,
    nombre_producto VARCHAR(255) NOT NULL,
    fecha_lanzamiento DATE,
    FOREIGN KEY (id_fabricante) REFERENCES fabricantes(id_fabricante)
);

INSERT INTO productos (id_producto, id_fabricante, nombre_producto, fecha_lanzamiento)
VALUES (1, 1, 'Producto X', '2020-01-01'),
       (2, 2, 'Producto Y', '2019-12-01'),
       (3, 3, 'Producto Z', '2021-05-15');
-- -----------------------------
-- Caso 1 - Crear un índice compuesto en las columnas id_fabricante y nombre_producto
CREATE INDEX idx_productos_id_fabricante_nombre
ON productos (id_fabricante, nombre_producto);
SHOW INDEX FROM productos;
-- -----------------------------
-- Caso 2 - Crear un índice único en la columna id_producto
-- La PRIMARY KEY ya crea este índice. Se omite para evitar redundancia.
-- -----------------------------
-- Caso 4 - Creo un nuevo índice único en la columna id_fabricante
DROP INDEX IF EXISTS idx_unique_id_fabricante ON productos;
CREATE UNIQUE INDEX idx_unique_id_fabricante
ON productos (id_fabricante);
SHOW INDEX FROM productos;
-- -----------------------------
-- Caso 3 - Modificar el índice del Caso 1 para que sea único en la columna id_fabricante.
DROP INDEX if EXISTS idx_productos_id_fabricante_nombre ON productos;
CREATE UNIQUE INDEX idx_productos_id_fabricante_nombre
ON productos (id_fabricante);
SHOW INDEX FROM productos;
-- -----------------------------
-- Caso 5 - Elimino el índice idx_productos_id_fabricante de la tabla productos
DROP INDEX IF EXISTS idx_productos_id_fabricante ON productos;
SHOW INDEX FROM productos;

-- =============================================================================================================
-- =============================
-- TRIGGERS
-- =============================
DROP DATABASE IF EXISTS empleados;
CREATE DATABASE empleados;
USE empleados;

CREATE TABLE empleados (
  nombre VARCHAR(50) NOT NULL,
  edad INT NOT NULL,
  antiguedad INT NOT NULL
);

CREATE TABLE jubilados (
  nombre VARCHAR(50) NOT NULL,
  edad INT NOT NULL,
  antiguedad INT NOT NULL
);

-- Trigger para mover empleados a jubilados
-- Hay 2 instancias posibles, que se de al alta del registro (AFTER INSERT) o que se modifique un registro existente (AFTER UPDATE).
DROP TRIGGER IF EXISTS trg_insert_jubilado;
DELIMITER $$
CREATE TRIGGER trg_insert_jubilado
AFTER INSERT ON empleados
FOR EACH ROW
BEGIN
    IF NEW.edad >= 65 AND NEW.antiguedad >= 30 THEN
        -- Evitar duplicado comparando por nombre    
        IF NOT EXISTS (
            SELECT 1 FROM jubilados
            WHERE nombre = NEW.nombre
        ) THEN
            INSERT INTO jubilados (nombre, edad, antiguedad)
            VALUES (NEW.nombre, NEW.edad, NEW.antiguedad);
        END IF;

    END IF;
END$$
DELIMITER ;

-- En el update me aseguro de no duplicar registros en jubilados
-- Tambien tomo en cuenta el casod e que se actualicen datos de alguien ya jubilado para que el UPDATE impacte en ambas tablas
DROP TRIGGER IF EXISTS trg_update_jubilado;
DELIMITER $$
CREATE TRIGGER trg_update_jubilado
AFTER UPDATE ON empleados
FOR EACH ROW
BEGIN
    IF NEW.edad >= 65 AND NEW.antiguedad >= 30 THEN
        -- Si ya existe en jubilados
        IF EXISTS (SELECT 1 FROM jubilados WHERE nombre = NEW.nombre) THEN
            -- Si existe → actualizar su registro
            UPDATE jubilados
            SET edad = NEW.edad,
                antiguedad = NEW.antiguedad
            WHERE nombre = NEW.nombre;

        ELSE
            -- Si NO existe → insertarlo
            INSERT INTO jubilados (nombre, edad, antiguedad)
            VALUES (NEW.nombre, NEW.edad, NEW.antiguedad);
        END IF;
    END IF;
END$$
DELIMITER ;

-- Pruebas de los triggers
-- NO debe insertarse en jubilados
INSERT INTO empleados (nombre, edad, antiguedad)
VALUES ('Juan Pérez', 40, 10);
-- SÍ debe insertarse en jubilados
INSERT INTO empleados (nombre, edad, antiguedad)
VALUES ('Carlos Gómez', 67, 32);
-- SÍ (caso límite exacto)
INSERT INTO empleados (nombre, edad, antiguedad)
VALUES ('Eduardo Medina', 65, 30);

SELECT * FROM empleados;
SELECT * FROM jubilados;

-- Ingreso de datos para verificar los TRIGGERS
-- Caso: Pasa de no cumplir a cumplir ambas condiciones → debe insertarse
INSERT INTO empleados (nombre, edad, antiguedad)
VALUES ('Miguel Torres', 60, 25);
SELECT * FROM empleados where nombre = 'Miguel Torres';
SELECT * FROM jubilados where nombre = 'Miguel Torres';

UPDATE empleados
SET edad = 66, antiguedad = 30
WHERE nombre = 'Miguel Torres';
SELECT * FROM empleados where nombre = 'Miguel Torres';
SELECT * FROM jubilados where nombre = 'Miguel Torres';
-- Despues del update paso a la tabla jubilados

-- Caso: Cumple solo una condición → NO debe insertarse
INSERT INTO empleados (nombre, edad, antiguedad)
VALUES ('Bruno Castillo', 70, 10);
SELECT * FROM empleados where nombre = 'Bruno Castillo';
SELECT * FROM jubilados where nombre = 'Bruno Castillo';

UPDATE empleados
SET antiguedad = 20
WHERE nombre = 'Bruno Castillo';
SELECT * FROM empleados where nombre = 'Bruno Castillo';
SELECT * FROM jubilados where nombre = 'Bruno Castillo';
-- Como sigue cumpliendo una sola condicion despues del update no se incluye en la tabla jubilados

UPDATE empleados
SET edad = 70
WHERE nombre = 'Carlos Gómez';

select * from jubilados;
select * from empleados;

-- =============================================================================================================
-- =============================
-- PROCEDIMIENTOS ALMACENADOS
-- =============================
DROP DATABASE IF EXISTS proc_alm;
CREATE DATABASE proc_alm;
USE proc_alm;

CREATE TABLE empleados (
    codigo VARCHAR(10) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    salario DECIMAL(12,2) NOT NULL
);

INSERT INTO empleados (codigo, nombre, salario) VALUES
('E001', 'Juan Pérez', 500000),
('E002', 'María González', 620000),
('E003', 'Carlos Gómez', 450000),
('E004', 'Lucía Fernández', 710000),
('E005', 'Santiago Romero', 390000),
('E006', 'Ana Torres', 560000),
('E007', 'Jorge Medina', 470000),
('E008', 'Martina Suárez', 630000),
('E009', 'Ricardo Álvarez', 520000),
('E010', 'Florencia Herrera', 580000);

-- PROCEDIMIENTO ActualizarEmpleados
DROP PROCEDURE IF EXISTS ActualizarEmpleados;
DELIMITER $$
CREATE PROCEDURE ActualizarEmpleados(
    IN p_codigo_empleado VARCHAR(10),
    IN p_salario_actualizado DECIMAL(10,2)
)
BEGIN
    DECLARE v_salario_actual DECIMAL(10,2); -- Declaro variable para almacenar salario actual
    -- Iniciar transacción
    START TRANSACTION;
    -- Obtener salario actual con bloqueo
    SELECT salario INTO v_salario_actual
    FROM empleados
    WHERE codigo = p_codigo_empleado
    FOR UPDATE;
    -- Validar existencia del empleado
    IF v_salario_actual IS NULL THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'ERROR: El empleado no existe.';
    END IF;
    -- Validar salario actualizado
    IF p_salario_actualizado < v_salario_actual THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'ERROR: El salario actualizado no puede ser menor que el salario actual.';
    END IF;
    -- Actualizar salario
    UPDATE empleados
    SET salario = p_salario_actualizado
    WHERE codigo = p_codigo_empleado;
    COMMIT;
END$$
DELIMITER ;

-- Verificaciones
-- Caso correcto: aumento válido
CALL ActualizarEmpleados('E001', 520000);
SELECT * FROM empleados WHERE codigo = 'E001';

-- Caso incorrecto: salario menor — debe hacer rollback
-- Debe mostrar error y NO actualizar
CALL ActualizarEmpleados('E002', 300000);
SELECT * FROM empleados WHERE codigo = 'E002';

-- Caso incorrecto: empleado inexistente
CALL ActualizarEmpleados('E999', 900000);

-- =============================================================================================================
-- =============================
-- GESTION DE USUARIOS
-- =============================
USE mysql;

-- Crear un usuario sin privilegios específicos
CREATE USER 'usuario_sin_priv'@'localhost' IDENTIFIED BY '1234';

-- Crear un usuario con privilegios de lectura sobre la base pubs
CREATE USER 'usuario_lectura'@'localhost' IDENTIFIED BY '1234';
GRANT SELECT ON pubs.* TO 'usuario_lectura'@'localhost';

-- Crear un usuario con privilegios de escritura sobre la base pubs (INSERT, UPDATE, DELETE)
CREATE USER 'usuario_escritura'@'localhost' IDENTIFIED BY '1234';
GRANT INSERT, UPDATE, DELETE ON pubs.* TO 'usuario_escritura'@'localhost';

-- Crear un usuario con todos los privilegios sobre la base pubs
CREATE USER 'usuario_admin_pubs'@'localhost' IDENTIFIED BY '1234';
GRANT ALL PRIVILEGES ON pubs.* TO 'usuario_admin_pubs'@'localhost';

-- Crear un usuario con privilegios de lectura sobre la tabla titles
DROP USER IF EXISTS 'usuario_lectura_titles'@'localhost';
CREATE USER 'usuario_lectura_titles'@'localhost' IDENTIFIED BY '1234';
GRANT SELECT ON pubs.titles TO 'usuario_lectura_titles'@'localhost';

-- Eliminar al usuario que tiene todos los privilegios sobre pubs
DROP USER IF EXISTS 'usuario_admin_pubs'@'localhost';

-- Eliminar a dos usuarios a la vez
DROP USER IF EXISTS
    'usuario_lectura_titles'@'localhost',
    'usuario_escritura'@'localhost';

-- Eliminar un usuario y sus privilegios asociados
DROP USER IF EXISTS 'usuario_lectura'@'localhost';

-- Revisar los privilegios de un usuario
SHOW GRANTS FOR 'usuario_sin_priv'@'localhost';
