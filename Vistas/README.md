# Vistas SQL 

Este repositorio contiene las soluciones a una serie de ejercicios de SQL basados en el esquema de la base de datos `pubs`. La base de datos `PUBS` es un esquema de ejemplo clásico utilizado para practicar consultas sobre publicaciones, autores, editoriales y ventas.

## Objetivo

El propósito principal es:

1.  **Dominar las sentencias SQL fundamentales** (`SELECT`, `FROM`, `WHERE`, `ORDER BY`).
2.  **Aprender el uso de funciones de agregación** (`COUNT`, `SUM`, `AVG`, `MAX`, `MIN`) y la cláusula `GROUP BY`.
3.  **Aplicar filtros avanzados** mediante la cláusula `HAVING`.
4.  **Comprender y aplicar diferentes tipos de JOINS** (`INNER`, `LEFT`, `UNION`) para relacionar información entre múltiples tablas.

---

## Archivos del Repositorio

| Archivo | Descripción |
| :--- | :--- |
| `Pubs_Vistas.sql` | Archivo que contiene todas las **consultas SQL resueltas y comentadas** de la ejercitacion propuesta. |
| `README.md` | Este archivo, que explica el contexto y la estructura de las soluciones. |

---

## Estructura del Archivo de Soluciones (`Pubs_Vistas.sql`)

El archivo de soluciones está estructurado de forma clara, con **comentarios detallados** que indican a qué ejercicio corresponde cada bloque de código y la finalidad de cada línea.

Se le aplico formatos especificos a algunas consultas a manera de practica (por ejemplo al consultar ciertas fechas, el formato sql devuelve los valores en el formato AAAA/MM/DD y se lo modifico para quer se muestre en formato DD/MM/AAAA)

Los ejemplos están agrupados en tres grandes categorías, siguiendo la lógica de complejidad creciente de las consultas SQL:

### 1. Consultas Simples (Ejercicios 1 - 10)

Se enfocan en la selección básica de datos, el uso de alias (`AS`), funciones de concatenación (`CONCAT`), cálculos sencillos y la eliminación de valores repetidos (`DISTINCT`).

### 2. Consultas Condicionadas (Ejercicios 11 - 20)
Implican el uso de cláusulas WHERE con operadores lógicos (`AND`, `OR`, `NOT`), operadores de comparación (`BETWEEN`, `IN`), patrones de búsqueda (`LIKE`, `REGEXP`), y ordenamiento de resultados (ORDER BY).

### 3. Consultas Agrupadas y Relacionadas (Ejercicios 21 - 40)
Esta sección cubre las consultas más avanzadas:

Agrupadas (`GROUP BY`, `HAVING`): Cálculo de promedios, máximos, mínimos y conteos por categoría.

Relacionadas (`JOIN`, `UNION`): Combinación de información de dos o más tablas, incluyendo INNER JOIN, LEFT JOIN y Producto Cartesiano.
