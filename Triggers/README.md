# Implementación de Triggers en MySQL (Control de Integridad de Datos)

Este repositorio contiene un trabajo práctico enfocado en el desarrollo y la implementación de **Triggers (Disparadores)** en MySQL. El objetivo es demostrar la capacidad de estos objetos de base de datos para centralizar la **lógica de negocio** y asegurar la **integridad de los datos** de manera automática, interceptando eventos DML (`INSERT`, `UPDATE`).

## Estructura del Esquema (`testDisparador`)

El ejercicio se desarrolla sobre un esquema simple para la gestión de notas estudiantiles.

| Tabla | Descripción | Columna Crítica | Regla |
| :--- | :--- | :--- | :--- |
| `alumnos` | Registro de estudiantes y su rendimiento académico. | `nota` (DECIMAL 4,2) | La nota debe estar **obligatoriamente** entre **0.00 y 10.00**. |

## Triggers Implementados

Se han creado dos triggers que actúan como "guardianes" de la tabla, corrigiendo cualquier valor de nota que intente violar la regla de negocio, sin generar errores en la aplicación que los invoca.

### 1. `trigger_check_nota_before_insert`

| Detalle | Lógica de Integridad |
| :--- | :--- |
| **Evento** | `BEFORE INSERT` |
| **Propósito** | Garantizar que todas las nuevas notas registradas cumplan con el rango [0, 10]. |
| **Mecanismo** | Utiliza la pseudo-fila `NEW` para inspeccionar el valor. Si `NEW.nota < 0`, se corrige a `0`. Si `NEW.nota > 10`, se corrige a `10`. |

### 2. `trigger_check_nota_before_update`

| Detalle | Lógica de Integridad |
| :--- | :--- |
| **Evento** | `BEFORE UPDATE` |
| **Propósito** | Garantizar que todas las modificaciones de notas que se registren cumplan con el rango [0, 10]. |
| **Mecanismo** | Utiliza la pseudo-fila `NEW` para inspeccionar el valor. Si `NEW.nota < 0`, se corrige a `0`. Si `NEW.nota > 10`, se corrige a `10`. |
