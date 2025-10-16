# Gestión de Índices en SQL

Este repositorio contiene la resolución de practicas enfocadas en la **gestión, creación y manipulación de índices** dentro de un esquema de base de datos simple (`editoriales` y `libros`).

El objetivo de los ejercicios es comprender el impacto y las implicaciones de los diferentes tipos de índices (simples, compuestos y únicos) en el rendimiento y la integridad de los datos.

---

## 🎯 Conceptos Centrales Abordados

El ejercicio se centra en las sentencias **Data Definition Language (DDL)**, específicamente aquellas que controlan la optimización del acceso a datos.

### 1. Índices Simples y Compuestos

**Foco:** Creación de estructuras para acelerar la recuperación de datos.

* **Índice Simple:** Se crea un índice sobre una única columna (`fecha_publicacion`) para optimizar la velocidad de búsqueda, filtrado y ordenamiento por ese campo.
* **Índice Compuesto:** Se crea un índice que combina dos columnas (`id_editorial` y `titulo`). Esto es crucial para optimizar consultas que filtran simultáneamente por ambas columnas, aprovechando la estructura de índice para acceder a los datos de forma más eficiente.

### 2. Índices Únicos y Eliminación

**Foco:** Garantizar la integridad de los datos y la gestión del ciclo de vida de los índices.

* **Restricción de Unicidad:** Se intenta aplicar un índice **`UNIQUE`** a una columna (`id_editorial` en la tabla `libros`). Esta acción no solo optimiza la búsqueda, sino que también **impide la inserción de valores duplicados**, reforzando una regla de negocio (en este caso, que cada editorial solo pueda tener una entrada en la tabla de libros).
* **Eliminación de Índices:** Se utiliza la sentencia **`DROP INDEX`** para remover una estructura de índice existente, liberando espacio y permitiendo la redefinición de la estrategia de indexación.

### 3. Preguntas de Reflexión y Sintaxis

**Foco:** Profundizar en las implicaciones de las restricciones **`PRIMARY KEY`** y las limitaciones de sintaxis.

* **Integridad Implícita (PRIMARY KEY):** Se demuestra que una columna definida como **`PRIMARY KEY`** (`id_editorial` en `editoriales` y `id_libro` en `libros`) automáticamente posee un **índice único**, haciendo redundante cualquier intento de crear un índice único adicional sobre la misma columna.
* **Modificación de Índices:** Se concluye que no se puede usar una única sentencia `ALTER` para cambiar propiedades fundamentales de un índice (como su unicidad), siendo necesario el proceso de **eliminar** (`DROP`) y **crear** (`CREATE`) nuevamente.

---

## 🛠️ Instrucciones de Uso

Para replicar y ejecutar estos ejercicios, siga los siguientes pasos:

1.  Asegúrese de tener un entorno SQL (MySQL, PostgreSQL, etc.) disponible.
2.  Copie y ejecute el bloque de código SQL en orden, incluyendo la creación de la base de datos, las tablas y la inserción de datos.
3.  Observe los mensajes del sistema para confirmar la correcta creación de los índices y las restricciones de unicidad.
