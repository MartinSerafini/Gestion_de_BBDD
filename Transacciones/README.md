# Gestión de Transacciones en SQL 
Este repositorio contiene código SQL enfocado en la implementación y demostración del uso de **Transacciones ACID** (Atomicidad, Consistencia, Aislamiento y Durabilidad).

El objetivo principal es asegurar la integridad de los datos en operaciones críticas de negocio (como transferencias de fondos y registros de compras) mediante el uso de los comandos `START TRANSACTION`, `COMMIT`, y `ROLLBACK`.

***

## Estructura del Esquema

El código utiliza un esquema de base de datos simple que simula un sistema de contabilidad o banca básica:

| Tabla | Descripción | Columnas Críticas |
| :--- | :--- | :--- |
| `cuentas` | Almacena los saldos de diferentes cuentas para las transferencias. | `numero_cuenta`, `saldo` |
| `cuentas_clientes` | Almacena saldos de clientes, utilizada para la lógica de compra. | `numero_cuenta`, `saldo` |
| `transacciones` | Registro histórico de las operaciones de compra exitosas. | `numero_cuenta`, `monto` |

***

## Conceptos Implementados

La ejercitación demuestra dos enfoques principales en la gestión transaccional: el manejo de transacciones a nivel de sentencia SQL y la encapsulación de transacciones dentro de un Procedimiento Almacenado.

### 1. Transacciones a Nivel de Sentencia SQL (Ejemplo Directo)

* **Objetivo:** Demostrar el principio de **Atomicidad** en una transferencia de fondos.
* **Lógica:** La transferencia requiere dos pasos DML (`UPDATE`): restar fondos de la cuenta de origen (`A`) y sumar fondos a la cuenta de destino (`B`).
* **Mecanismo:** El uso de `START TRANSACTION` y `COMMIT` asegura que *ambas* o *ninguna* de las sentencias `UPDATE` se apliquen. Si la segunda falla, el `ROLLBACK` implícito o explícito revertiría la primera.

### 2. Transacciones Encapsuladas en Procedimientos Almacenados

* **Procedimiento:** `RegistrarCompra`
* **Objetivo:** Validar el saldo antes de procesar una compra y garantizar que la actualización del saldo y el registro histórico sean atómicos.
* **Mecanismo de Control:** 
    * **`START TRANSACTION`:** Inicia la unidad lógica de trabajo.
    * **Validación (`IF/ELSE`):** Verifica si el saldo actual (`v_saldo_actual`) es suficiente para el `p_monto` de la compra.
    * **Ruta Exitosa:** Si hay saldo, ejecuta el `UPDATE` (restar saldo) y el `INSERT` (registrar compra), seguido de **`COMMIT`** para guardar los cambios permanentemente.
    * **Ruta Fallida:** Si el saldo es insuficiente, se ejecuta **`ROLLBACK`**, revirtiendo cualquier cambio parcial que pudiera haber ocurrido y manteniendo la consistencia de la base de datos.

***

## Uso y Ejecución

Para probar el código, simplemente ejecute el script `transacciones.sql` en su cliente SQL. El script incluye:

1.  La creación y población inicial de las tablas.
2.  El bloque de transferencia de fondos con `COMMIT`.
3.  La definición del procedimiento `RegistrarCompra`.
4.  Llamadas de prueba (`CALL`) al procedimiento, incluyendo un caso **exitoso** y un caso diseñado para forzar un **`ROLLBACK`** debido a saldo insuficiente.
