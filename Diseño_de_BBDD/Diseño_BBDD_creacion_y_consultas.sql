-------------------------------------------------
-- Creacion de la BBDD
-------------------------------------------------
CREATE DATABASE tp_clase2_diseño
    DEFAULT CHARACTER SET = 'utf8mb4';

use tp_clase2_diseño;
-------------------------------------------------
-- Diseño de la BBDD
-------------------------------------------------

-------------------------------------------------
-- Tabla Importador
-------------------------------------------------
CREATE TABLE IF NOT EXISTS Importador  (
    id_importador INT PRIMARY KEY AUTO_INCREMENT,
    CUIT BIGINT NOT NULL UNIQUE,
    razon_social VARCHAR(100) NOT NULL
);
-------------------------------------------------
-- Tabla Empleado
-------------------------------------------------
CREATE TABLE IF NOT EXISTS Empleado (
    legajo INT PRIMARY KEY AUTO_INCREMENT,
    CUIL BIGINT NOT NULL UNIQUE,
    apellido VARCHAR(50) NOT NULL,
    nombres VARCHAR(50) NOT NULL
);
-------------------------------------------------
-- Tabla Pieza
-------------------------------------------------
CREATE TABLE IF NOT EXISTS Pieza (
    id_pieza INT PRIMARY KEY AUTO_INCREMENT,
    nombre_pieza VARCHAR(100) NOT NULL,
    origen ENUM('Importado','Fabricado') NOT NULL
);
-------------------------------------------------
-- Tabla Factura
-------------------------------------------------
CREATE TABLE IF NOT EXISTS Factura (
    id_factura INT PRIMARY KEY AUTO_INCREMENT,
    fecha DATE NOT NULL,
    nro_factura INT(8) ZEROFILL NOT NULL,
    id_importador INT NOT NULL,
    FOREIGN KEY (id_importador) REFERENCES Importador(id_importador)
    ON DELETE CASCADE ON UPDATE CASCADE
);
-------------------------------------------------
-- Tabla Factura_Detalle
-------------------------------------------------
CREATE TABLE IF NOT EXISTS Factura_Detalle (
    id_factura INT,
    id_pieza INT,
    cantidad INT NOT NULL,
    PRIMARY KEY (id_factura, id_pieza),
    FOREIGN KEY (id_factura) REFERENCES Factura(id_factura),
    FOREIGN KEY (id_pieza) REFERENCES Pieza(id_pieza)
    ON DELETE CASCADE ON UPDATE CASCADE
);
-------------------------------------------------
-- Tabla Fabricacion
-------------------------------------------------
CREATE TABLE IF NOT EXISTS Fabricacion (
    id_fabricacion INT PRIMARY KEY AUTO_INCREMENT,
    id_pieza INT NOT NULL,
    legajo INT NOT NULL,
    fecha DATE NOT NULL,
    cantidad INT NOT NULL,
    FOREIGN KEY (id_pieza) REFERENCES Pieza(id_pieza),
    FOREIGN KEY (legajo) REFERENCES Empleado(legajo)
);
-------------------------------------------------
-- Tabla Modelo
-------------------------------------------------
CREATE TABLE IF NOT EXISTS Modelo (
    id_modelo INT PRIMARY KEY AUTO_INCREMENT,
    nombre_modelo VARCHAR(100) NOT NULL
);
-------------------------------------------------
-- Tabla Mapa de Armado
-------------------------------------------------
CREATE TABLE IF NOT EXISTS MapaArmado (
    id_modelo INT,
    id_pieza INT,
    orden INT,
    ubicacion VARCHAR(100),
    PRIMARY KEY (id_modelo, id_pieza),
    FOREIGN KEY (id_modelo) REFERENCES Modelo(id_modelo),
    FOREIGN KEY (id_pieza) REFERENCES Pieza(id_pieza)
);
-------------------------------------------------
-- Llenado de Tablas
-------------------------------------------------

-------------------------------------------------
-- IMPORTADORES
-------------------------------------------------
INSERT INTO Importador (CUIT, razon_social) VALUES
(30711222334, 'Importadora Fueguina SA'),
(30722333445, 'Componentes del Sur SRL');
-------------------------------------------------
-- EMPLEADOS (operarios)
-------------------------------------------------
INSERT INTO Empleado (CUIL, apellido, nombres) VALUES
(20333444556, 'González', 'Martín'),
(27322555447, 'Pérez', 'Lucía'),
(23311444559, 'Rodríguez', 'Javier');
-------------------------------------------------
-- PIEZAS
-------------------------------------------------
INSERT INTO Pieza (nombre_pieza, origen) VALUES
('Placa Madre', 'Importado'),
('Pantalla LED 43"', 'Importado'),
('Carcasa Plástica', 'Fabricado'),
('Placa de Sonido', 'Fabricado'),
('Fuente de Alimentacion', 'Importado'),
('Tornillo M3', 'Fabricado');
-------------------------------------------------
-- MODELOS
-------------------------------------------------
INSERT INTO Modelo (nombre_modelo) VALUES
('TV Smart 43"'),
('TV Smart 55"');
-------------------------------------------------
-- MAPAARMADO (componentes para TV Smart 43")
-------------------------------------------------
INSERT INTO MapaArmado (id_modelo, id_pieza, orden, ubicacion) VALUES
(1, 2, 1, 'Frente - Pantalla'),
(1, 1, 2, 'Base - Placa Madre'),
(1, 4, 3, 'Interior - Módulo Sonido'),
(1, 3, 4, 'Exterior - Carcasa'),
(1, 6, 5, 'Interior - Tornillería');
-------------------------------------------------
-- FACTURAS (compras a importadores)
-------------------------------------------------
INSERT INTO Factura (fecha, nro_factura, id_importador) VALUES
('2025-08-20', 00001234, 1),
('2025-08-21', 00001235, 2);
-------------------------------------------------
-- FACTURA_DETALLE
-------------------------------------------------
INSERT INTO Factura_Detalle (id_factura, id_pieza, cantidad) VALUES
(1, 1, 50), -- Placa Madre
(1, 2, 30), -- Pantalla
(1, 5, 20), -- Fuente
(2, 1, 40),
(2, 5, 10);
-------------------------------------------------
-- FABRICACION (piezas hechas en la planta)
-------------------------------------------------
INSERT INTO Fabricacion (id_pieza, legajo, fecha, cantidad) VALUES
(3, 1, '2025-08-22', 100), -- Carcasa plástica por legajo 1
(4, 2, '2025-08-22', 80), -- Placa de sonido por legajo 2
(6, 3, '2025-08-23', 500); -- Tornillos por legajo 3

-------------------------------------------------
-- Consultas
-------------------------------------------------

-------------------------------------------------
-- Consulta 1: Listar piezas que componen un modelo con orden y ubicación
-------------------------------------------------
SELECT m.id_modelo, m.nombre_modelo, ma.orden, p.id_pieza, p.nombre_pieza, ma.ubicacion
FROM MapaArmado ma
JOIN Modelo m ON ma.id_modelo = m.id_modelo
JOIN Pieza p ON ma.id_pieza = p.id_pieza
WHERE m.nombre_modelo = 'TV Smart 43"'
ORDER BY ma.orden;

--------------------------------------------------
-- Consulta 2: Total fabricado por operario (resumen)
--------------------------------------------------
SELECT e.legajo, CONCAT(UPPER(e.apellido), ', ', e.nombres) AS operario, SUM(f.cantidad) AS total_fabricado
FROM Fabricacion f
JOIN Empleado e ON f.legajo = e.legajo
GROUP BY e.legajo, e.apellido, e.nombres
ORDER BY total_fabricado DESC;

--------------------------------------------------
-- Consulta 3: Detalle de factura (nro) con piezas y cantidades
--------------------------------------------------
SELECT f.nro_factura, DATE_FORMAT(f.fecha, '%d/%m/%Y'), CONCAT(
        SUBSTRING(LPAD(i.CUIT, 11, '0'), 1, 2), '-',   -- primeros 2 dígitos
        SUBSTRING(LPAD(i.CUIT, 11, '0'), 3, 8), '-',   -- siguientes 8 dígitos
        SUBSTRING(LPAD(i.CUIT, 11, '0'), 11, 1)        -- último dígito
    ),i.razon_social, p.nombre_pieza, fd.cantidad
FROM Factura f
JOIN Importador i ON f.id_importador = i.id_importador
JOIN Factura_Detalle fd ON f.id_factura = fd.id_factura
JOIN Pieza p ON fd.id_pieza = p.id_pieza
WHERE f.nro_factura = 00001234;