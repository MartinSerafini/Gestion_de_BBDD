# Gestión de Bases de Datos - MySQL / MongoDB

Este repositorio alberga ejemplos de implementacion de SQL asi como la exploración de tecnologías NoSQL.

## Estructura del Repositorio

| Archivo | Descripción | Tipo de Base de Datos / Contenido |
| :--- | :--- | :--- |
| `diseño.sql` | Script SQL completo para la creación e inicialización del esquema relacional. | SQL (DDL/DML) |
| `sql_integrador.sql` | Script de ejemplos avanzados de manejo de bases de datos. | SQL (Funciones, Usuarios, Vistas) |
| `mongodb_integrador.mongodb` | Comandos y estructuras de datos para entornos NoSQL. | MongoDB (NoSQL) |
| `diseño.pdf` | Documentación técnica del modelo de datos relacional. | Diccionario de Datos, DER, Consultas |

## Tecnologías y Conceptos Abordados

### 1. Modelado de Datos Relacional (SQL)

El diseño se centra en la gestión de inventario, procesos de fabricación y cadena de suministro de componentes electrónicos.

* **Diseño Conceptual:** Definición de entidades (`Importador`, `Empleado`, `Pieza`, `Modelo`) y determinación de atributos.
* **Modelo Lógico/Relacional:** Creación del Diagrama Entidad-Relación (DER) y Diccionario de Datos, incluyendo la normalización.
* **Implementación DDL:** Creación de tablas con definición de Claves Primarias (PK) y Foráneas (FK), asegurando la integridad referencial.
* **Restricciones:** Uso de `NOT NULL`, `UNIQUE` y tipos de datos especializados como `INT(8) ZEROFILL` y `ENUM`.
* **Manejo de Transacciones:** Inserción de datos (`INSERT`) para poblar el esquema y testear el modelo relacional.

### 2. Consultas y Manipulación de Datos (DML Avanzado)

Se han desarrollado consultas complejas y estructuras para la explotación de los datos.

* **Consultas Relacionadas (JOINs):** Uso de `JOIN` para obtener información consolidada de múltiples tablas (e.g., detalle de componentes por modelo, detalle de órdenes de compra).
* **Funciones de Agregación:** Utilización de `SUM()` y cláusulas `GROUP BY` para generar resúmenes de producción por operario.
* **Manipulación de Cadenas y Formato:** Aplicación de funciones como `CONCAT()`, `UPPER()`, `DATE_FORMAT()`, `LPAD()`, y `SUBSTRING()` para presentación de datos legibles (e.g., formato de CUIL/CUIT y fechas).
* **Vistas:** Implementación de vistas para simplificar consultas recurrentes y controlar el acceso a la información.

### 3. Administración y Seguridad de Bases de Datos

El repositorio incluye ejemplos para la gestión de acceso y roles de usuario.

* **Gestión de Usuarios:** Creación y eliminación de usuarios con distintos niveles de acceso (`usuario_lectura`, `usuario_escritura`, `usuario_admin`).
* **Manejo de Privilegios:** Uso de comandos `GRANT` y `REVOKE` para asignar permisos específicos de `SELECT`, `INSERT`, `UPDATE` y `DELETE`.
* **Funciones y Procedimientos Almacenados:** Implementación de funciones SQL para lógica de negocio reutilizable (e.g., cálculo de totales o ratios).

### 4. Bases de Datos NoSQL (MongoDB)

Se explora un entorno NoSQL para escenarios donde la flexibilidad del esquema es prioritaria.

* **Modelado de Documentos:** Uso de colecciones e inserción de documentos con estructura flexible.
* **Operaciones CRUD:** Demostración de comandos `insertMany`, `find` y `drop` para manipular datos en colecciones.
* **Indexación y Restricciones:** Manejo de la unicidad del campo `_id`.

---
