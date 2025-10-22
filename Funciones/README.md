# Implementación de Funciones Definidas por el Usuario (UDFs) en SQL

Este repositorio contiene la resolución del trabajo práctico enfocado en la **creación y manipulación de Funciones Definidas por el Usuario (UDFs) escalares** dentro del esquema de la base de datos de ejemplo **`pubs`**.

El objetivo de los ejercicios es encapsular la lógica de negocio y cálculos financieros/de reportes complejos en funciones reusables, demostrando el manejo de cláusulas SQL avanzadas, variables y lógica condicional.

---

## Conceptos Centrales Abordados

El ejercicio se centra en las sentencias **Data Control Language (DCL)** y **Programación Almacenada**, específicamente en la creación de funciones `CREATE FUNCTION` para optimizar consultas de reporte.

### 1. Cálculos Financieros (Regalías e Ingresos) 💰

**Foco:** Demostrar el uso de `JOIN` y funciones de agregación (`SUM`) dentro de una función para obtener un único valor escalar.

* **Regalía Total por Autor (`fn_regalia_total_autor`):** Requiere combinar datos de **3 tablas** (`titles`, `titleauthor`, `authors`) y aplicar una fórmula de reparto de regalías
* **Ingreso Total por Título (`fn_ingreso_total_titulo`):** Requiere `JOIN` entre `titles` y `sales` para sumar las cantidades vendidas y multiplicarlas por el precio unitario.

### 2. Manejo de Valores Nulos (`COALESCE`)

**Foco:** Garantizar que las funciones siempre devuelvan un valor numérico válido, evitando que los cálculos de reportes posteriores fallen por la propagación de `NULL`.

* Se utilizó `RETURN COALESCE(variable, 0.00)` para asegurar que si un autor no tiene regalías o un libro no tiene ventas (lo que resulta en un cálculo `NULL`), la función devuelva un **cero** en su lugar.

### 3. Lógica Condicional y Formato de Cadenas ✍️

**Foco:** Usar lógica `IF` o `CASE` para formatear datos basados en su existencia.

* **Nombre Completo Formateado (`fn_nombre_completo_empleado`):** Utiliza la función `IF` anidada en `CONCAT` para añadir la inicial del segundo nombre (`minit`) con un punto y espacio **solamente si** el campo `minit` tiene un valor definido y no está vacío.

### 4. Agregación Simple y Consultas de Resumen

**Foco:** Uso directo de funciones de agregación estándar.

* **Precio Máximo por Tipo (`fn_precio_max_por_tipo`):** Usa `MAX(price)` filtrado por el tipo de libro.
* **Precio Promedio por Editorial (`fn_precio_promedio_editorial`):** Usa `AVG(price)`, lo que automáticamente gestiona la exclusión de los precios nulos (`NULL`) para un cálculo preciso.

---

## Estructura y Archivos

| Archivo | Contenido Principal |
| :--- | :--- |
| `pubs.sql` | Script SQL con la creación de la base de datos `pubs`, las tablas y la inserción de **todos los datos iniciales**. |
| `TP_Funciones.sql` | Contiene el código DDL para **crear las 5 UDFs** y los **ejemplos de llamadas** para verificar cada función. |

## Instrucciones de Uso

Para replicar y ejecutar estos ejercicios, siga los siguientes pasos en su entorno SQL (MySQL o MariaDB):

1.  **Configuración de la Base de Datos:**
    Copie y ejecute el bloque de código del archivo **`pubs.sql`** primero. Esto creará el esquema y poblará las tablas:

2.  **Creación de las Funciones:**
    Ejecute el script **`TP_Funciones.sql`**. Este script utiliza `DELIMITER //` para permitir la correcta definición de las funciones multi-línea.

