### **Ejercitación de Consultas SQL sobre la Base de Datos `PUBS`** 📚

El objetivo de este repositorio es demostrar las técnicas fundamentales de consulta y manipulación de datos en una base de datos relacional, tomando como referencia el esquema de la base de datos `PUBS`.

Las consultas están organizadas por el concepto central de SQL que abordan.

---

### **Estructura y Enfoque de la Ejercitación**

#### **1. Consultas Simples** 🎯

**Sentido:** Adquirir dominio sobre la sintaxis básica de la sentencia **`SELECT`** y la presentación de resultados.
* **Selección de Datos:** Uso de `SELECT *` y `SELECT columna1, columna2` para mostrar todos o un subconjunto de datos.
* **Formato y Alias:** Utilización de **Alias** (`AS`) para renombrar columnas y manipulación de cadenas con **Concatenación** (`CONCAT`) para generar campos descriptivos (ej. Nombre Completo).
* **Cálculos Directos:** Realizar operaciones aritméticas en línea, como calcular el precio con IVA.
* **Valores Únicos:** Uso de **`DISTINCT`** para listar elementos sin repeticiones (ej. países o ciudades únicas).

---

#### **2. Consultas Condicionales (Filtros)** 🔍

**Sentido:** Aplicar la cláusula **`WHERE`** para seleccionar solo aquellos registros que satisfacen criterios específicos, y ordenar los resultados.
* **Condiciones Lógicas:** Uso de `AND`, `OR` y negación (`NOT`) para combinar múltiples filtros.
* **Filtrado de Rangos:** Seleccionar datos que caen dentro de un rango numérico o de fecha, con y sin el operador `BETWEEN`.
* **Ausencia de Datos:** Uso de **`IS NULL`** para identificar registros con valores faltantes.
* **Búsqueda de Patrones:** Empleo de **`LIKE`** y comodines (`%`, `_`) para buscar texto que coincide con un formato específico (ej. nombres que empiezan con 'P' o direcciones que terminan en un número).
* **Ordenamiento:** Utilización de **`ORDER BY`** en modo ascendente (`ASC`) y descendente (`DESC`).

---

#### **3. Consultas Agrupadas y Agregación** 📈

**Sentido:** Utilizar funciones de agregación para resumir, contar y analizar datos, y la cláusula **`GROUP BY`** para aplicar estas agregaciones a subconjuntos de datos.
* **Agregaciones:** Uso de `COUNT`, `AVG`, `MIN` y `MAX` para obtener estadísticas.
* **Agrupamiento:** Calcular promedios, máximos o conteos para cada categoría distinta (ej. precio promedio por tipo de libro).
* **Filtrado de Grupos:** Aplicación de la cláusula **`HAVING`** para filtrar los resultados después de haber sido agrupados (ej. locales con ventas mayores a una cantidad específica).

---

#### **4. Consultas Relacionadas (JOINs y Uniones)** 🔗

**Sentido:** Combinar datos de dos o más tablas de la base de datos para obtener información completa y analizar las relaciones.
* **Uniones Internas (`INNER JOIN`):** Mostrar registros que tienen coincidencias en ambas tablas (ej. libros junto a su editorial).
* **Uniones Externas (`LEFT JOIN`):** Identificar registros que no tienen coincidencias en la tabla secundaria (ej. editoriales que no han publicado libros, o libros que nunca han sido vendidos).
* **Producto Cartesiano (`CROSS JOIN`):** Obtener todas las combinaciones posibles entre dos conjuntos de datos.
* **Operadores de Conjunto (`UNION`):** Combinar los resultados de consultas separadas en una sola lista, eliminando duplicados (ej. listar todas las ciudades mencionadas en la base de datos).

---

#### **5. Ejercicios de DML (Manipulación de Datos)** 💾

**Sentido:** Practicar sentencias para modificar el contenido de las tablas, crucial para la gestión de datos.
* **Inserción (`INSERT`):** Añadir nuevos registros, utilizando las sintaxis simplificada y extendida.
* **Actualización (`UPDATE`):** Modificar datos existentes, incluyendo la aplicación de cálculos porcentuales a los precios basados en rangos.
* **Eliminación (`DELETE`):** Borrar registros de las tablas basándose en condiciones específicas.
