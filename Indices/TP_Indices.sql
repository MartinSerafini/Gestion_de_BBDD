-- ======================================
-- CREACIÓN DE LA BASE DE DATOS Y TABLAS
-- ======================================
DROP DATABASE IF EXISTS editoriales;
CREATE DATABASE editoriales;
USE editoriales;

-- Tabla de editoriales
CREATE TABLE editoriales (
    id_editorial INT PRIMARY KEY,
    nombre_editorial VARCHAR(255) NOT NULL
);

-- Insertar registros en editoriales
INSERT INTO editoriales (id_editorial, nombre_editorial)
VALUES
    (1, 'Editorial Santillana'),
    (2, 'Editorial Anagrama'),
    (3, 'Editorial Planeta'),
    (4, 'Editorial Alfaguara'),
    (5, 'Editorial SM'),
    (6, 'Editorial Penguin Random House'),
    (7, 'Editorial Norma'),
    (8, 'Editorial Ediciones B'),
    (9, 'Editorial Aguilar'),
    (10, 'Editorial Fondo de Cultura Económica');

-- Tabla de libros
CREATE TABLE libros (
    id_libro INT PRIMARY KEY,
    id_editorial INT,
    titulo VARCHAR(255) NOT NULL,
    fecha_publicacion DATE,
    FOREIGN KEY (id_editorial) REFERENCES editoriales(id_editorial)
);

-- Insertar registros en libros
INSERT INTO libros (id_libro, id_editorial, titulo, fecha_publicacion)
VALUES
    (1, 1, 'Cien años de soledad', '1967-05-30'),
    (2, 2, 'Rayuela', '1963-07-23'),
    (3, 3, 'La sombra del viento', '2001-04-27'),
    (4, 4, 'Pedro Páramo', '1955-11-30'),
    (5, 5, 'Don Quijote de la Mancha', '1605-01-16'),
    (6, 6, 'Harry Potter y la piedra filosofal', '1997-06-26'),
    (7, 7, 'Crimen y castigo', '1866-01-29'),
    (8, 8, 'Los detectives salvajes', '1998-09-01'),
    (9, 9, 'La casa de los espíritus', '1982-01-01'),
    (10, 10, 'Ficciones', '1944-05-01');

-- Mostrar contenido inicial
SELECT * FROM editoriales;
SELECT * FROM libros;

-- Mostrar índices existentes
SHOW INDEX FROM editoriales;
SHOW INDEX FROM libros;


-- ======================================
-- EJERCICIO 1
-- Crear un índice compuesto (id_editorial, titulo)
-- ======================================
CREATE INDEX idx_libros_id_editorial_titulo
ON libros (id_editorial, titulo);


-- ======================================
-- EJERCICIO 2
-- Crear un índice sobre la columna fecha_publicacion
-- ======================================
CREATE INDEX idx_libros_fecha_publicacion
ON libros (fecha_publicacion);


-- ======================================
-- EJERCICIO 3
-- Eliminar el índice compuesto creado en el ejercicio 1
-- ======================================
-- SQL me da error si intento eliminar el índice directamente
-- porque la columna id_editorial es clave foránea.
-- Para solucionarlo primero desactivo las comprobaciones de FK,
-- elimino el índice y luego las reactivo.

-- Desactivo temporalmente las comprobaciones de FK
SET FOREIGN_KEY_CHECKS = 0;
-- Elimino el índice de forma segura
ALTER TABLE libros DROP INDEX idx_libros_id_editorial_titulo;
-- Reactivo las comprobaciones de FK
SET FOREIGN_KEY_CHECKS = 1;


-- ======================================
-- EJERCICIO 4
-- Crear un índice ÚNICO sobre la columna id_editorial en libros
-- ======================================
CREATE UNIQUE INDEX idx_libros_id_editorial
ON libros (id_editorial);


-- ======================================
-- EJERCICIO 5 
-- ¿Se puede usar ALTER TABLE para modificar un índice?
-- ======================================
-- No de manera directa. Se puede realizar el proceso de dos pasos:
--      * Elimino el índice antiguo (DROP INDEX).
--      * Creo un nuevo índice (CREATE UNIQUE INDEX) con las propiedades requeridas.

-- ======================================
-- EJERCICIO 6
-- Crear un índice único sobre id_editorial en la tabla editoriales
-- ======================================
-- La columna id_editorial ya es la PRIMARY KEY de la tabla editoriales. 
-- Esto automáticamente crea un índice único sobre la columna. Por lo tanto, el índice ya existe. 
-- La sentencia CREATE UNIQUE INDEX es redundante y existe la posibilidad de generar algun error en SQL.
CREATE UNIQUE INDEX idx_editoriales_id_editorial
ON editoriales (id_editorial);


-- ======================================
-- EJERCICIO 7
-- Crear un índice PRIMARY sobre id_libro
-- ======================================
-- Esta columna ya es clave primaria, por lo tanto el índice ya existe.
-- Si no lo fuera, podríamos hacerlo de esta forma
-- ALTER TABLE libros ADD PRIMARY KEY (id_libro);
