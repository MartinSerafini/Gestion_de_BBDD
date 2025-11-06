-- ---------------------------------------------------------
-- Creo la base de datos solicitada
-- ---------------------------------------------------------
CREATE DATABASE IF NOT EXISTS testDisparador;

USE testDisparador;

DROP TABLE IF EXISTS alumnos;

-- Tabla alumnos
CREATE TABLE alumnos (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,  -- identificador único de cada alumno
    nombre VARCHAR(50),                          -- nombre del alumno
    apellido VARCHAR(50),                        -- apellido del alumno
    nota DECIMAL(4,2)                            -- nota del alumno, con hasta 2 decimales (entre 0 y 10)
);

-- ---------------------------------------------------------
-- Trigger para controlar que las notas estén entre 0 y 10 al instertar
-- ---------------------------------------------------------
DROP TRIGGER IF EXISTS trigger_check_nota_before_insert;

DELIMITER //
CREATE TRIGGER trigger_check_nota_before_insert
BEFORE INSERT ON alumnos
FOR EACH ROW
BEGIN
    -- Si la nota que quiero insertar es menor a 0, la corrijo a 0
    IF NEW.nota < 0 THEN
        SET NEW.nota = 0;
    END IF;

    -- Si la nota que quiero insertar es mayor a 10, la corrijo a 10
    IF NEW.nota > 10 THEN
        SET NEW.nota = 10;
    END IF;
END;
//
DELIMITER ;

-- ---------------------------------------------------------
-- Trigger para controlar que las notas estén entre 0 y 10 al actualizar
-- ---------------------------------------------------------
DROP TRIGGER IF EXISTS trigger_check_nota_before_update;
DELIMITER //
CREATE TRIGGER trigger_check_nota_before_update
BEFORE UPDATE ON alumnos
FOR EACH ROW
BEGIN
    -- Si la nota nueva es menor a 0, la corrijo a 0
    IF NEW.nota < 0 THEN
        SET NEW.nota = 0;
    END IF;

    -- Si la nota nueva es mayor a 10, la corrijo a 10
    IF NEW.nota > 10 THEN
        SET NEW.nota = 10;
    END IF;
END;
//
DELIMITER ;

-- ---------------------------------------------------------
-- Prueba del trigger con el INSERT
-- ---------------------------------------------------------
INSERT INTO alumnos (nombre, apellido, nota) VALUES
('Lucía', 'Pérez', 8.50),
('Martín', 'Gómez', 9.75),
('Sofía', 'Fernández', 11),       -- nota inválida, el trigger la bajará a 10
('Juan', 'Rodríguez', -2),        -- nota inválida, el trigger la subirá a 0
('Valentina', 'López', 7.00),
('Tomás', 'Acuña', 10.00),
('Camila', 'Benítez', 5.50),
('Agustín', 'Morales', 3.25),
('Julieta', 'Ramírez', 12.00),    -- nota inválida, el trigger la bajará a 10
('Lucas', 'Sánchez', -5.00);      -- nota inválida, el trigger la subirá a 0

-- Verifico los resultados
SELECT * FROM alumnos;

-- ---------------------------------------------------------
-- Prueba del trigger con el UPDATE
-- ---------------------------------------------------------
-- Intento actualizar una nota con un valor negativo
UPDATE alumnos SET nota = -3 WHERE nombre = 'Camila';

-- Intento actualizar una nota con un valor mayor a 10
UPDATE alumnos SET nota = 15 WHERE nombre = 'Agustín';

-- Y una nota válida dentro del rango
UPDATE alumnos SET nota = 9 WHERE nombre = 'Lucas';

-- Verifico los resultados
SELECT * FROM alumnos;
