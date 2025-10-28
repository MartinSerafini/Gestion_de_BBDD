# Procedimientos Almacenados en MySQL/MariaDB (Práctica Técnica)

Este repositorio documenta una colección de procedimientos almacenados desarrollados en un entorno MySQL/MariaDB. El proyecto tiene como objetivo ilustrar el manejo avanzado de la lógica de programación dentro del motor de base de datos, incluyendo la gestión de diferentes tipos de parámetros (`IN`, `OUT`, `INOUT`), estructuras de control condicionales (`IF`, `CASE`) y bucles iterativos (`WHILE`, `REPEAT`, `LOOP`).

## Estructura de la Base de Datos

Los ejemplos se dividen en dos esquemas de datos principales:

### 1. Sistema de Ventas (Ejercicios 1, 2, 3, 4)

Diseñado para simular un sistema de ventas, permitiendo la gestión de inventario, clientes y transacciones.

| Tabla | Descripción | Columnas Clave |
| :--- | :--- | :--- |
| `clientes` | Datos maestros de los clientes. | `id` (PK) |
| `productos` | Catálogo de productos, precio y stock. | `id` (PK) |
| `ventas` | Registros de transacciones, con cantidad y fecha. | `id` (PK), `cliente_id` (FK), `producto_id` (FK) |

### 2. Gestión de Empleados y Temas Lógicos (Ejemplos de Control de Flujo)

Utilizado para demostrar el uso de parámetros y estructuras de control.

| Tabla | Descripción |
| :--- | :--- |
| `empleados` | Documentos, nombres, apellidos, sueldo y sección. |
| `provincias` | Nombres y códigos de provincias. |

---

## Procedimientos Almacenados por Funcionalidad

Los procedimientos almacenados se agrupan por el concepto técnico que ilustran:

### I. Tipos de Parámetros

| Procedimiento | Tipo de Parámetro | Descripción | Concepto Clave |
| :--- | :--- | :--- | :--- |
| `pa_ventas_total_producto` | `IN`, `OUT` | Retorna el **monto total** y la **cantidad total de unidades** vendidas de un producto por su ID. | Asignación múltiple con `SELECT ... INTO`. |
| `pa_actualizar_stock` | `IN`, `INOUT` | Disminuye el stock. El parámetro `INOUT` recibe la cantidad a vender y retorna el **nuevo stock**, o **-1** si el stock es insuficiente. | Control de errores explícito (uso de `-1`). |
| `pa_cantidad_hijos` | `IN`, `INOUT` | Recibe un documento y un valor inicial; retorna la suma de la **cantidad de hijos** del empleado más el valor inicial. | Utilización de un valor inicial para acumulación. |
| `pa_empleados_sueldo` | `IN` | Lista empleados con sueldo **superior o igual** al valor de entrada. | Filtrado simple en la cláusula `WHERE`. |
| `pa_seccion` | `IN`, `OUT` | Retorna el **promedio** y el **sueldo máximo** para una sección dada. | Cálculos agregados (`AVG`, `MAX`). |

### II. Estructuras Condicionales (`IF` y `CASE`)

| Procedimiento | Estructura | Descripción | Concepto Clave |
| :--- | :--- | :--- | :--- |
| `pa_mayor3` | `IF...ELSEIF...ELSE` | Muestra el mayor de **tres** enteros de entrada. | Uso de operadores lógicos (`AND`) en condiciones. |
| `pa_mas_clientes_provincias` | `IF...ELSEIF...ELSE` | Compara el número de clientes entre dos provincias dadas y retorna la provincia con más clientes. | Variables locales (`DECLARE`) y `JOIN`s dentro del procedimiento. |
| `pa_tipo_medalla` | `CASE puesto WHEN 1 THEN...` | Retorna el tipo de medalla (`oro`, `plata`, `bronce`) basado en un número de puesto de entrada (1, 2 o 3). | `CASE` simple con comparación de valores exactos. |
| `pa_cantidad_digitos` | `CASE WHEN condicion THEN...` | Retorna la cantidad de dígitos (1 a 3) de un número de entrada (1 a 999). | `CASE` basado en condiciones lógicas (rangos). |

### III. Estructuras Iterativas (Bucles)

Se emplean bucles para demostrar la ejecución repetitiva de código hasta que se cumple una condición de salida. Los siguientes procedimientos retornan dos valores aleatorios distintos entre 0 y 10:

| Procedimiento | Tipo de Bucle | Sintaxis y Lógica de Salida |
| :--- | :--- | :--- |
| `pa_generar_dos_aleatorios` (1) | `WHILE` | Se repite **mientras** la condición (`valor1 = valor2`) sea verdadera. |
| `pa_generar_dos_aleatorios` (2) | `REPEAT` | Se repite **hasta** que la condición (`valor1 <> valor2`) sea verdadera. |
| `pa_generar_dos_aleatorios` (3) | `LOOP` | Bucle infinito que requiere la sentencia `LEAVE [etiqueta]` para su finalización controlada. |

## Implementación Detallada (Ejemplo Destacado: `INOUT` y Lógica de Negocio)

El procedimiento `pa_actualizar_stock` es un ejemplo crucial de cómo los procedimientos almacenados manejan la lógica de negocio y comunican el estado de las operaciones:

