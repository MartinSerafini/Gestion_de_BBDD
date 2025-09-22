### Ejercitacion de SQL

Este repositorio contiene las soluciones para una serie de ejercicios de bases de datos, implementadas en SQL. Los ejercicios están diseñados para practicar y demostrar habilidades en el uso de consultas de SQL, abarcando desde selecciones básicas hasta uniones complejas y manipulación de datos.

Los ejercicios se basan en la base de datos `PUBS`, que es ideal para practicar conceptos fundamentales de bases de datos. Las soluciones están organizadas en diferentes archivos para que sea fácil seguir cada categoría de ejercicios.

---

### Estructura del Repositorio

El repositorio está organizado por categorías de ejercicios, cada una con su propio archivo SQL. Puedes encontrar las siguientes secciones:

#### Consultas Simples 
Esta sección cubre las consultas más básicas, como la selección de datos, la visualización de la estructura de las tablas, el uso de alias para las columnas y la concatenación de campos para crear un nuevo valor.
* Listar todos los autores y editoriales.
* Mostrar la estructura de tablas como `STORES` y `SALES`.
* Concatenar nombres de empleados y mostrar sus fechas de contratación.
* Calcular el precio de los libros con y sin IVA, usando alias para las columnas.
* Listar países y ciudades únicos de editoriales y autores, evitando repeticiones.

---

#### Consultas Condicionales 
Aquí se aplican filtros a las consultas usando la cláusula `WHERE`. Esto permite seleccionar datos que cumplen con condiciones específicas.
* Filtrar empleados por editorial, nivel de trabajo y fecha de contratación.
* Encontrar autores sin contrato que residen en California.
* Filtrar ventas por condiciones de pago y cantidad sin usar `BETWEEN`.
* Buscar editoriales con un estado de residencia nulo.
* Utilizar `LIKE` y comodines (`%`, `_`) para encontrar datos que coinciden con patrones de texto.
* Filtrar facturas por condiciones de pago y rangos de años.

---

#### Consultas Agrupadas 
Esta sección se centra en el uso de `GROUP BY` y funciones de agregación como `COUNT`, `AVG`, `MIN` y `MAX` para resumir datos y obtener información sobre grupos.
* Contar autores por estado, editoriales por país, y empleados en la compañía.
* Calcular el precio promedio de los libros por categoría, con o sin categorías nulas.
* Encontrar tiendas que han vendido más de 100 libros.
* Usar la cláusula `HAVING` para filtrar los resultados de las agrupaciones.

---

#### Consultas Relacionadas 
Aquí se utilizan `JOIN` para combinar datos de múltiples tablas, lo cual es esencial para obtener información completa de la base de datos.
* Combinar tablas de libros y editoriales para ver sus detalles juntos.
* Encontrar autores y tiendas que están en el mismo estado.
* Listar editoriales que no han publicado ningún libro.
* Identificar libros que nunca se han vendido.
* Realizar un producto cartesiano (`CROSS JOIN`) entre libros de negocios y tiendas en California.
* Listar todas las ciudades únicas en la base de datos.

---

#### Ejercicios de DDL y DML 
Esta sección contiene sentencias para la **Manipulación de Datos (DML)**, como `INSERT`, `UPDATE` y `DELETE`, que son cruciales para modificar y gestionar los datos en las tablas.
* Insertar nuevos registros de clientes usando las sintaxis `INSERT` simplificada y extendida.
* Actualizar la información de clientes, como su nombre, apellido y CUIT.
* Eliminar clientes basados en su apellido o CUIT.
* Modificar precios de artículos aplicando porcentajes de aumento o disminución.
* Borrar artículos con stock igual a cero.

---

#### Uso de este Repositorio
Para utilizar este repositorio, simplemente clona el proyecto y ejecuta los archivos `.sql` en un cliente de base de datos conectado a tu instancia de la base de datos `PUBS`. Los archivos están nombrados según el número del ejercicio para facilitar su uso.
