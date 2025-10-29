# Procedimientos Almacenados en MySQL/MariaDB (Trabajo Práctico)

Este repositorio contiene la resolución de un Trabajo Práctico enfocado en el desarrollo y la implementación de **Procedimientos Almacenados (Stored Procedures)** en el entorno MySQL/MariaDB. El objetivo principal es demostrar el dominio en la gestión de **parámetros**, el control de **flujo de ejecución** y la manipulación de datos (**DML**) directamente desde el motor de la base de datos.

La base de datos de referencia es un esquema simple de **Sistema de Ventas**.

---

### 1. Gestión de Parámetros (`IN`, `OUT`, `INOUT`) 

**Sentido:** Adquirir dominio sobre la sintaxis de definición de procedimientos y la comunicación de datos entre el programa cliente y la base de datos.

* **Parámetros de Salida (`OUT`):**
    * `pa_ventas_total_producto`: Calcula y retorna el **monto total** de ventas, la **cantidad de unidades** vendidas y el **nombre del producto** para un ID dado. (Uso de `SELECT ... INTO` con múltiples variables de salida).
* **Parámetros de Entrada/Salida (`INOUT`):**
    * `pa_actualizar_stock`: Recibe la cantidad a vender. **Disminuye el stock** en la tabla y **retorna el nuevo stock** en el mismo parámetro, utilizando `-1` como **código de estado** si la venta no se pudo realizar por falta de existencias.

---

### 2. Control de Flujo Condicional (Lógica de Negocio) 

**Sentido:** Implementar lógica de negocio y validaciones utilizando estructuras de control dentro del procedimiento.

* **Condición Lógica (`IF/ELSE`):**
    * Utilizado en `pa_actualizar_stock` para validar si el `stock` actual es **suficiente** antes de ejecutar la sentencia `UPDATE` de manipulación de datos.
    * Utilizado en `pa_promedio_precio_cliente` para **prevenir la división por cero** antes de calcular el promedio, verificando que la cantidad total de unidades vendidas sea mayor a cero.

---

### 3. Cálculos y Agregación con Variables Locales 

**Sentido:** Utilizar variables locales para almacenar resultados intermedios de cálculos complejos, optimizando la legibilidad y el mantenimiento del código.

* **Cálculo de Métricas:**
    * `pa_promedio_precio_cliente`: Calcula el **Precio Promedio Ponderado** de compra por cliente.
    * Se utilizan variables locales (`DECLARE`) para almacenar el **monto total de compras** (numerador) y la **cantidad total de unidades** (denominador) antes de realizar la operación final de división.
    * $$\text{PPP} = \frac{\sum (\text{Cantidad} \times \text{Precio})}{\sum (\text{Cantidad})}$$

---

### 4. Consultas de Retorno y Formato (JOINs y Funciones) 

**Sentido:** Combinar datos de múltiples tablas para generar conjuntos de resultados útiles y aplicar formato.

* **Uniones Internas (`INNER JOIN`):**
    * `pa_ventas_cliente_rango`: Combina datos de `ventas`, `clientes` y `productos` para obtener una visión detallada de las transacciones.
* **Filtrado de Rangos:**
    * Se utiliza la cláusula `WHERE` con `BETWEEN` para listar las ventas que caen dentro de un **rango de fechas** específico (`p_fecha_inicio` y `p_fecha_fin`).
* **Función de Formato:**
    * Integración de una **función escalar personalizada** (`fecha_arg`) para modificar el formato de las fechas de salida de `AAAA-MM-DD` al estándar **`DD-MM-AAAA`**.

---

### 5. Sentencias DML Encapsuladas (Manipulación de Datos) 

**Sentido:** Practicar la inserción, actualización o eliminación de datos de manera controlada y segura a través de procedimientos, evitando la ejecución directa de comandos DML por parte del cliente.

* **Actualización (`UPDATE`):**
    * `pa_actualizar_stock`: La sentencia `UPDATE productos SET stock = stock - p_cantidad_vendida` se encapsula dentro de una validación `IF` para asegurar la **integridad referencial** y la **coherencia del inventario**.

---

##  Cómo Ejecutar

1.  **Configuración:** Ejecute el archivo `TP_Procedimientos_Almacenados.sql` para crear la base de datos `tp_procedimientos`, las tablas y los datos de prueba.
2.  **Funciones:** Asegúrese de crear la función auxiliar `fecha_arg` si desea ver el formato de fecha modificado en las salidas.
3.  **Llamada:** Utilice el comando `CALL` en su cliente SQL, declarando las variables de sesión (`@nombre`) para capturar los valores de los parámetros `OUT` o `INOUT`.

```sql
-- Ejemplo de llamada a un procedimiento con OUT:
CALL pa_ventas_total_producto(1, @nombre_prod, @total_monto, @total_cant);

-- Verificación de resultados:
SELECT @nombre_prod AS Producto, @total_monto AS MontoTotal, @total_cant AS Unidades;
