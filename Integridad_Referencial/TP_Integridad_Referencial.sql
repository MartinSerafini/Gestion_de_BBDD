-- ######################################################################
-- # TP INTEGRIDAD REFERENCIAL                                          #
-- ######################################################################

-- ######################################################################
-- # CREACIÓN DE BASE DE DATOS Y TABLAS CON RESTRICCIONES DE INTEGRIDAD #
-- ######################################################################

-- 1. CREA LA BASE DE DATOS
CREATE DATABASE editoriales_db;
-- Selecciona la base de datos recién creada para trabajar en ella.
USE editoriales_db;

-- 2. CREA TABLA editoriales
CREATE TABLE editoriales (
    id_editorial INT NOT NULL, -- Columna para el identificador único de la editorial.
    nombre_editorial VARCHAR(100) NOT NULL, -- Columna para el nombre de la editorial.
    -- Se Define la Clave Primaria (PK) directamente en la creación de la tabla.
    PRIMARY KEY (id_editorial)
);

-- 3. CREA TABLA empleados
CREATE TABLE empleados (
    id_empleado INT NOT NULL, -- Columna para el identificador único del empleado.
    nombre_empleado VARCHAR(100) NOT NULL, -- Columna para el nombre del empleado.
    id_editorial INT NOT NULL, -- Clave Foránea (FK) que apuntará a la tabla 'editoriales'.
    -- Se Define de la Clave Primaria.
    PRIMARY KEY (id_empleado),
    -- Se Define de la Clave Foránea (FK).
    CONSTRAINT fk_empleado_editorial -- Nombre de la restricción.
        FOREIGN KEY (id_editorial) -- Columna de esta tabla que es la FK.
        REFERENCES editoriales (id_editorial) -- Tabla y columna a la que hace referencia.
        ON DELETE CASCADE -- Si se elimina una editorial, elimina automáticamente los empleados relacionados.
        ON UPDATE CASCADE -- Si se actualiza el id_editorial, actualiza automáticamente el id_editorial de los empleados.
);

-- 4. CREA TABLA libros
CREATE TABLE libros (
    id_libro INT NOT NULL, -- Columna para el identificador único del libro.
    titulo_libro VARCHAR(255) NOT NULL, -- Columna para el título del libro.
    id_editorial INT NOT NULL, -- Clave Foránea (FK) que apuntará a la tabla 'editoriales'.
    -- Se Define de la Clave Primaria.
    PRIMARY KEY (id_libro),
    -- Se Define de la Clave Foránea (FK).
    CONSTRAINT fk_libro_editorial -- Nombre de la restricción.
        FOREIGN KEY (id_editorial) -- Columna de esta tabla que es la FK.
        REFERENCES editoriales (id_editorial) -- Tabla y columna a la que hace referencia.
        ON DELETE CASCADE -- Si se elimina una editorial, elimina automáticamente los libros relacionados.
        ON UPDATE CASCADE -- Si se actualiza el id_editorial, actualiza automáticamente el id_editorial de los libros.
);


-- ######################################################################
-- # INGRESO DE REGISTROS                                               #
-- ######################################################################

-- Ingreso en la tabla editoriales
INSERT INTO editoriales (id_editorial, nombre_editorial)
VALUES
    (1, 'Editorial Planeta'),
    (2, 'Editorial Santillana'),
    (3, 'Editorial Anaya'),
    (4, 'Editorial Alfaguara'),
    (5, 'Editorial SM'),
    (6, 'Editorial Fondo de Cultura Económica'),
    (7, 'Editorial Siglo XXI'),
    (8, 'Editorial Cátedra'),
    (9, 'Editorial Tecnos'),
    (10, 'Editorial Ariel');

-- Ingreso en la tabla empleados
INSERT INTO empleados (id_empleado, nombre_empleado, id_editorial)
VALUES
    (1, 'Juan Pérez', 1), -- Empleado de Editorial Planeta (ID 1)
    (2, 'María Rodríguez', 1), -- Empleado de Editorial Planeta (ID 1)
    (3, 'Pedro López', 2), -- Empleado de Editorial Santillana (ID 2)
    (4, 'Ana Martínez', 2), -- Empleado de Editorial Santillana (ID 2)
    (5, 'Carlos García', 3), -- Empleado de Editorial Anaya (ID 3)
    (6, 'Laura González', 3), -- Empleado de Editorial Anaya (ID 3)
    (7, 'Luis Fernández', 4), -- Empleado de Editorial Alfaguara (ID 4)
    (8, 'Elena Sánchez', 4), -- Empleado de Editorial Alfaguara (ID 4)
    (9, 'Javier Ruiz', 5), -- Empleado de Editorial SM (ID 5)
    (10, 'Sofía Torres', 5); -- Empleado de Editorial SM (ID 5)

-- Ingreso en la tabla libros
INSERT INTO libros (id_libro, titulo_libro, id_editorial)
VALUES
    (1, 'Cien años de soledad', 1), -- Libro de Editorial Planeta (ID 1)
    (2, 'Don Quijote de la Mancha', 1), -- Libro de Editorial Planeta (ID 1)
    (3, 'La sombra del viento', 2), -- Libro de Editorial Santillana (ID 2)
    (4, 'Rayuela', 2), -- Libro de Editorial Santillana (ID 2)
    (5, 'Crónica de una muerte anunciada', 3), -- Libro de Editorial Anaya (ID 3)
    (6, 'Los detectives salvajes', 3), -- Libro de Editorial Anaya (ID 3)
    (7, 'Ficciones', 4), -- Libro de Editorial Alfaguara (ID 4)
    (8, 'La casa de los espíritus', 4), -- Libro de Editorial Alfaguara (ID 4)
    (9, 'La ciudad y los perros', 5), -- Libro de Editorial SM (ID 5)
    (10, 'Cien años de soledad', 5); -- Libro de Editorial SM (ID 5)

-- ######################################################################
-- # NOTAS A LOS EJERCICIOS                                             #
-- ######################################################################

-- Nota Ejercicio 9 
-- Elimina la Editorial Santillana (ID 2).
-- ON DELETE CASCADE elimina automáticamente a los 2 empleados y 2 libros asociados.
DELETE FROM editoriales WHERE id_editorial = 2;


-- Nota Ejercicio 10
-- Reasigna los empleados de la Editorial Anaya (ID 3) a la Editorial Alfaguara (ID 4).
UPDATE empleados
SET id_editorial = 4 -- Nuevo ID de la editorial (Editorial Alfaguara)
WHERE id_editorial = 3; -- ID de la editorial a eliminar (Editorial Anaya)
-- Elimina la Editorial Anaya (ID 3).
-- La eliminación en cascada solo afecta a los libros restantes (si no se actualizaron antes) y no a los empleados, ya que estos ya fueron reasignados.
DELETE FROM editoriales
WHERE id_editorial = 3;