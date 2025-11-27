-- ------------------------------------------------------------------------------------------
-- SISTEMA DE USUARIOS Y PERMISOS EN MYSQL
-- ------------------------------------------------------------------------------------------
USE pubs;
-- Para evitar errores si se ejecuta más de una vez, elimino todos los usuarios
-- previamente creados (si existen). Esto no afecta si es la primera ejecución.
DROP USER IF EXISTS usuario_sin_privilegios@'localhost';
DROP USER IF EXISTS usuario_lectura_pubs@'localhost';
DROP USER IF EXISTS usuario_escritura_pubs@'localhost';
DROP USER IF EXISTS usuario_full_pubs@'localhost';
DROP USER IF EXISTS usuario_lectura_titles@'localhost';
DROP USER IF EXISTS usuario1@'localhost';
DROP USER IF EXISTS usuario2@'localhost';
DROP USER IF EXISTS usuario_eliminar@'localhost';

-- ------------------------------------------------------------------------------------------
-- CREAR UN USUARIO SIN PRIVILEGIOS ESPECÍFICOS
-- ------------------------------------------------------------------------------------------
CREATE USER 'usuario_sin_privilegios'@'localhost' IDENTIFIED BY '123';

-- Verifico que el usuario exista consultando la tabla mysql.user
SHOW GRANTS FOR 'usuario_sin_privilegios'@'localhost';

-- ------------------------------------------------------------------------------------------
-- CREAR UN USUARIO CON PRIVILEGIOS DE LECTURA SOBRE LA BASE pubs
-- ------------------------------------------------------------------------------------------
CREATE USER 'usuario_lectura_pubs'@'localhost' IDENTIFIED BY '1234';

-- Le otorgo solo privilegios de lectura en todas las tablas de la base pubs.
GRANT SELECT ON pubs.* TO 'usuario_lectura_pubs'@'localhost';
SHOW GRANTS FOR 'usuario_lectura_pubs'@'localhost';

-- ------------------------------------------------------------------------------------------
-- CREAR UN USUARIO CON PRIVILEGIOS DE ESCRITURA SOBRE LA BASE pubs
-- ------------------------------------------------------------------------------------------

CREATE USER 'usuario_escritura_pubs'@'localhost' IDENTIFIED BY '1234';

-- Le doy permisos de escritura: INSERT, UPDATE y DELETE.
GRANT INSERT, UPDATE, DELETE ON pubs.* TO 'usuario_escritura_pubs'@'localhost';

SHOW GRANTS FOR 'usuario_escritura_pubs'@'localhost';

-- ------------------------------------------------------------------------------------------
-- CREAR UN USUARIO CON TODOS LOS PRIVILEGIOS SOBRE LA BASE pubs
-- ------------------------------------------------------------------------------------------
CREATE USER 'usuario_full_pubs'@'localhost' IDENTIFIED BY '1234';

-- Le otorgo todos los privilegios dentro de esa base.
GRANT ALL PRIVILEGES ON pubs.* TO 'usuario_full_pubs'@'localhost';

SHOW GRANTS FOR 'usuario_full_pubs'@'localhost';

-- ------------------------------------------------------------------------------------------
-- CREAR UN USUARIO CON PRIVILEGIOS DE LECTURA SOLO SOBRE LA TABLA titles
-- ------------------------------------------------------------------------------------------
CREATE USER 'usuario_lectura_titles'@'localhost' IDENTIFIED BY '1234';

-- Le doy acceso únicamente a SELECT sobre la tabla pubs.titles.
GRANT SELECT ON pubs.titles TO 'usuario_lectura_titles'@'localhost';

SHOW GRANTS FOR 'usuario_lectura_titles'@'localhost';

-- ------------------------------------------------------------------------------------------
-- ELIMINAR AL USUARIO QUE TIENE TODOS LOS PRIVILEGIOS SOBRE LA BASE pubs
-- ------------------------------------------------------------------------------------------
-- Verifico el usuario antes de eliminarlo.
SELECT * FROM mysql.user;
-- Lo elimino.
DROP USER 'usuario_full_pubs'@'localhost';
-- Verifico que ya no exista.
SELECT * FROM mysql.user;

-- ------------------------------------------------------------------------------------------
-- ELIMINAR A DOS USUARIOS A LA VEZ
-- ------------------------------------------------------------------------------------------

-- Creo dos usuarios.
CREATE USER 'usuario1'@'localhost' IDENTIFIED BY '1234';
CREATE USER 'usuario2'@'localhost' IDENTIFIED BY '1234';

SELECT * FROM mysql.user;
-- Los elimino al mismo tiempo.
DROP USER 'usuario1'@'localhost', 'usuario2'@'localhost';

-- Vista de verificación.
SELECT * FROM mysql.user;

-- ------------------------------------------------------------------------------------------
-- ELIMINAR UN USUARIO Y SUS PRIVILEGIOS ASOCIADOS
-- ------------------------------------------------------------------------------------------
CREATE USER 'usuario_eliminar'@'localhost' IDENTIFIED BY '1234';

-- Le otorgo permisos.
GRANT SELECT, INSERT ON pubs.* TO 'usuario_eliminar'@'localhost';
SHOW GRANTS FOR 'usuario_eliminar'@'localhost';
SELECT * FROM mysql.user;

-- Elimino el usuario, sus permisos quedan automáticamente borrados.
DROP USER 'usuario_eliminar'@'localhost';

-- Verifico que ya no exista.
SELECT * FROM mysql.user;

-- ------------------------------------------------------------------------------------------
-- REVISAR LOS PRIVILEGIOS DE UN USUARIO
-- ------------------------------------------------------------------------------------------

SHOW GRANTS FOR 'usuario_escritura_pubs'@'localhost';


