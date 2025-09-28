----------------------------------
-- CONSULTAS BASE PUBS
----------------------------------
-- CONSULTAS SIMPLES
----------------------------------

-- Ejercicio 1: Posicionar el Analizador de Consultas en la base de datos PUBS.
USE pubs; -- Selecciona la base de datos 'pubs' para las consultas posteriores.

-- Ejercicio 2: Mostrar todos los autores.
SELECT * FROM authors; -- Selecciona todas las columnas de la tabla 'authors'.

-- Ejercicio 3: Mostrar todas las editoriales.
SELECT * FROM publishers; -- Selecciona todas las columnas de la tabla 'publishers'.

-- Ejercicio 4: Mostrar la estructura de la tabla STORES.
DESCRIBE stores; -- Muestra la estructura (columnas, tipos de datos, etc.) de la tabla 'stores'.

-- Ejercicio 5: Mostrar la estructura de la tabla SALES.
DESCRIBE sales; -- Muestra la estructura de la tabla 'sales'.

-- Ejercicio 6: Mostrar el código, nombre completo y fecha de ingreso de los empleados que trabajan para la editorial 877.
-- Tener en cuenta que el nombre completo es el resultado de la concatenación del nombre y apellido.
-- Las columnas deben estar apodadas según las siguientes leyendas: "Número de Empleado", "Nombre de Empleado" y "Fecha de Inicio".
SELECT
    emp_id AS "Número de Empleado", -- Selecciona el ID del empleado y lo apoda.
    CONCAT(fname, ' ', lname) AS "Nombre de Empleado", -- Concatena nombre y apellido, y apoda la columna.
    hire_date AS "Fecha de Inicio" -- Selecciona la fecha de contratación y la apoda.
FROM
    employee -- De la tabla 'employee'.
WHERE
    pub_id = '0877'; -- Filtra por la editorial '0877'.

-- Ejercicio 7: Mostrar el título, precio bruto y precio con IVA de los libros (Se formatean los precios a dos decimales).
SELECT
    title AS Título, -- Selecciona el título y lo apoda.
    ROUND(price, 2) AS Precio, -- Selecciona el precio bruto, lo redondea y apoda.
    ROUND(price * 1.21, 2) AS "Precio IVA" -- Calcula el precio con 21% de IVA, lo redondea y apoda.
FROM
    titles -- De la tabla 'titles'.
WHERE
    price IS NOT NULL; -- Excluye los libros donde el precio sea nulo.
    titles -- De la tabla 'titles'.
WHERE
    price IS NOT NULL; -- Excluye los libros donde el precio sea nulo.

-- Ejercicio 8: Mostrar los tipos de libros existentes.
SELECT DISTINCT type FROM titles; -- Selecciona los valores únicos de la columna 'type' de la tabla 'titles'.

-- Ejercicio 9: Listar los países de residencia de las editoriales. Evitar las repeticiones.
SELECT DISTINCT country FROM publishers; -- Selecciona los valores únicos de la columna 'country' de la tabla 'publishers'.

-- Ejercicio 10: Listar las ciudades y estados de residencia de los autores. Evitar las repeticiones.
SELECT DISTINCT city, state FROM authors; -- Selecciona pares únicos de 'city' y 'state' de la tabla 'authors'.

-- Ejercicio 10 (Variante): Formateando la salida
SELECT DISTINCT -- Se aplica DISTINCT a toda la fila resultante (la columna concatenada).
    CONCAT('Ciudad: ', city, ' Estado: ', state) AS ciudad_estado
FROM
    authors; -- De la tabla 'authors'.

----------------------------------
-- Consultas Condicionadas
----------------------------------

-- Ejercicio 11: Listar todos los empleados de la editorial número 877.
-- Ordenar por nivel de trabajo descendente y por fecha de incorporación ascendente.
SELECT
    * -- Selecciona todas las columnas.
FROM
    employee -- De la tabla 'employee'.
WHERE
    pub_id = '0877' -- Filtra por la editorial '0877'.
ORDER BY
    job_lvl DESC, -- Ordena primero por nivel de trabajo de forma descendente.
    hire_date ASC; -- Luego, por fecha de incorporación de forma ascendente.

-- Ejercicio 12: Listar el número, apellido, nombre y teléfono de los autores que NO tengan contrato
-- y que su estado de residencia sea California (CA).
SELECT
    au_id, -- Selecciona el número de autor.
    au_lname, -- Selecciona el apellido.
    au_fname, -- Selecciona el nombre.
    phone -- Selecciona el teléfono.
FROM
    authors -- De la tabla 'authors'.
WHERE
    contract = 0 -- Filtra por autores que NO tienen contrato (0 o ' \0' en la base de datos proporcionada).
    AND state = 'CA'; -- Y cuyo estado de residencia es California.

-- Ejercicio 13: Listar los empleados cuyo año de incorporación fue 1990 y cuyo nivel de trabajo esté entre 100 Y 200.
SELECT
    * -- Selecciona todas las columnas.
FROM
    employee -- De la tabla 'employee'.
WHERE
    YEAR(hire_date) = 1990 -- Filtra por empleados contratados en el año 1990.
    AND job_lvl BETWEEN 100 AND 200; -- Y cuyo nivel de trabajo esté en el rango de 100 a 200 (inclusive).

-- Ejercicio 14: Listar los libros vendidos cuya condición de pago es sobre facturación ('ON invoice')
-- y cuya cantidad de venta esté entre 13 y 40. No utilizar el operador BETWEEN.
SELECT
    * -- Selecciona todas las columnas.
FROM
    sales -- De la tabla 'sales'.
WHERE
    payterms = 'ON invoice' -- Filtra por condición de pago 'ON invoice'.
    AND qty >= 13 -- Y donde la cantidad vendida es mayor o igual a 13.
    AND qty <= 40; -- Y donde la cantidad vendida es menor o igual a 40.

-- Ejercicio 15: Listar número y nombre de las editoriales cuyo estado de residencia contenga valor nulo.
SELECT
    pub_id, -- Selecciona el ID de la editorial.
    pub_name -- Selecciona el nombre de la editorial.
FROM
    publishers -- De la tabla 'publishers'.
WHERE
    state IS NULL; -- Filtra por editoriales cuyo estado de residencia es nulo.

-- Ejercicio 16: Listar el título y precio de los libros de cocina cuyo título no figure la palabra "sushi".
-- Ordenar por precio descendente.
SELECT
    title, -- Selecciona el título del libro.
    price -- Selecciona el precio.
FROM
    titles -- De la tabla 'titles'.
WHERE
    type IN ('mod_cook', 'trad_cook') -- Filtra por tipos de libros de cocina.
    AND title NOT LIKE '%sushi%' -- Y cuyo título NO contenga la palabra "sushi".
ORDER BY
    price DESC; -- Ordena por precio de forma descendente.

-- Ejercicio 17: Listar todos los empleados cuyo nombre empiece con la letra P y termine con la letra O,
-- y su apellido termine con la letra O.
SELECT
    * -- Selecciona todas las columnas.
FROM
    employee -- De la tabla 'employee'.
WHERE
    fname LIKE 'P%o' -- El nombre debe empezar con 'P' y terminar con 'o'.
    AND lname LIKE '%o'; -- Y el apellido debe terminar con 'o'.

-- Ejercicio 18: Listar todos los autores cuya dirección termine con un número y que la segunda letra de su apellido sea R.
SELECT
    * -- Selecciona todas las columnas.
FROM
    authors -- De la tabla 'authors'.
WHERE
    address REGEXP '[0-9]$' -- La dirección debe terminar con un dígito (usando expresión regular).
    AND au_lname LIKE '_r%'; -- Y la segunda letra del apellido debe ser 'r'.

-- Ejercicio 19: Mostrar todos los empleados cuyo nombre empiece con la letra P ó A.
-- La segunda letra no sea A y la última letra esté entre la H y la Z.
SELECT
    * -- Selecciona todas las columnas.
FROM
    employee -- De la tabla 'employee'.
WHERE
    (fname LIKE 'P%' OR fname LIKE 'A%') -- El nombre empieza con 'P' o 'A'.
    AND fname NOT LIKE '_a%' -- La segunda letra del nombre NO es 'a'.
    AND RIGHT(fname, 1) BETWEEN 'H' AND 'Z'; -- Y la última letra del nombre está entre 'H' y 'Z'.

-- Ejercicio 20: Listar todas las facturas que su condición de pago es a 30 días ('Net 30')
-- que hayan facturado durante el año 1992 y 1993,
-- ó los que su condición de pago es a 60 días ('Net 60') que han facturado durante el segundo semestre del año 1994.
-- Ordenar la consulta por código de libro (title_id).
SELECT
    * -- Selecciona todas las columnas.
FROM
    sales -- De la tabla 'sales'.
WHERE
    (payterms = 'Net 30' AND YEAR(ord_date) IN (1992, 1993)) -- Condición 1: Net 30 y años 1992 o 1993.
    OR -- O.
    (payterms = 'Net 60' AND YEAR(ord_date) = 1994 AND MONTH(ord_date) >= 7) -- Condición 2: Net 60, año 1994 y meses de Julio (7) a Diciembre (segundo semestre).
ORDER BY
    title_id; -- Ordena por el ID del título.

-- Ejercicio 21: Contar la cantidad de autores que su estado de residencia sea California (CA).
-- Poner un apodo al nombre de columna.
SELECT
    COUNT(au_id) AS "Autores en CA" -- Cuenta el número de IDs de autor y apoda la columna.
FROM
    authors -- De la tabla 'authors'.
WHERE
    state = 'CA'; -- Filtra por autores cuyo estado es California.

-- Ejercicio 22: Mostrar la fecha de inicio de facturación y el último número de comprobante emitido.
-- Poner un apodo a cada columna.
SELECT
    MIN(ord_date) AS "Fecha Inicio Facturación", -- Encuentra la fecha de pedido más antigua (inicio de facturación) y la apoda.
    MAX(ord_num) AS "Último Comprobante" -- Encuentra el número de pedido más alto (último comprobante, asumiendo orden alfanumérico) y lo apoda.
FROM
    sales; -- De la tabla 'sales'.

-- Ejercicio 23: Contar la cantidad de países que residen alguna editorial.
SELECT
    COUNT(DISTINCT country) AS "Cantidad de Países" -- Cuenta el número de países únicos y apoda la columna.
FROM
    publishers; -- De la tabla 'publishers'.

-- Ejercicio 24: Listar las categorías de libros y el valor promedio para cada tipo de libro.
SELECT
    type AS Categoría, -- Selecciona el tipo de libro y lo apoda.
    AVG(price) AS "Valor Promedio" -- Calcula el precio promedio para cada grupo y lo apoda.
FROM
    titles -- De la tabla 'titles'.
WHERE
    price IS NOT NULL -- Excluye libros sin precio para el cálculo.
GROUP BY
    type; -- Agrupa los resultados por tipo de libro.

-- Ejercicio 25: Idem ejercicio 24 pero no incluir dentro de la lista los libros que no tienen decidida una categoría (tipo de libro vacío/nulo).
SELECT
    type AS Categoría, -- Selecciona el tipo de libro y lo apoda.
    AVG(price) AS "Valor Promedio" -- Calcula el precio promedio para cada grupo y lo apoda.
FROM
    titles -- De la tabla 'titles'.
WHERE
    price IS NOT NULL -- Excluye libros sin precio para el cálculo.
    AND type IS NOT NULL -- Excluye libros con tipo nulo.
    AND type != '' -- Excluye libros con tipo de cadena vacía (como en el título 19 de la base de datos).
GROUP BY
    type; -- Agrupa los resultados por tipo de libro.

-- Ejercicio 26: Listar los locales que hayan vendido más de 100 libros.
SELECT
    stor_id, -- Selecciona el ID de la tienda.
    SUM(qty) AS "Total Libros Vendidos" -- Suma la cantidad vendida por tienda y la apoda.
FROM
    sales -- De la tabla 'sales'.
GROUP BY
    stor_id -- Agrupa las ventas por tienda.
HAVING
    SUM(qty) > 100; -- Filtra los grupos donde la suma de la cantidad sea mayor a 100.

-- Ejercicio 27: Listar la cantidad de ejemplares vendidos de cada libro en cada tienda.
-- Poner apodos a las columnas.
SELECT
    stor_id AS "Código Tienda", -- Selecciona el ID de la tienda y lo apoda.
    title_id AS "Código Libro", -- Selecciona el ID del libro y lo apoda.
    SUM(qty) AS "Ejemplares Vendidos" -- Suma la cantidad vendida para cada par (tienda, libro) y la apoda.
FROM
    sales -- De la tabla 'sales'.
GROUP BY
    stor_id, title_id; -- Agrupa por tienda y por libro.

-- Ejercicio 28: Listar el valor promedio de los libros agrupados por tipo de libro cuyo promedio esté entre 12 y 14.
-- Poner alias a los encabezados. Ordenar la consulta por promedio.
SELECT
    type AS Categoría, -- Selecciona el tipo de libro y lo apoda.
    AVG(price) AS Promedio -- Calcula el precio promedio para cada grupo y lo apoda.
FROM
    titles -- De la tabla 'titles'.
WHERE
    price IS NOT NULL -- Excluye libros sin precio para el cálculo.
GROUP BY
    type -- Agrupa por tipo de libro.
HAVING
    AVG(price) BETWEEN 12 AND 14 -- Filtra los grupos cuyo promedio esté entre 12 y 14.
ORDER BY
    Promedio; -- Ordena los resultados por el valor promedio.

-- Ejercicio 29: Listar las categorías de libros junto con el precio del libro más caro, el más barato y la cantidad de libros existentes para esa categoría.
-- Mostrar solo aquellas categorías de libros cuyo precio de los libros económicos (más barato) sea inferior a $10 Y cuya cantidad de libros pertenecientes sean mayor a 2.
SELECT
    type AS Categoría, -- Selecciona el tipo de libro y lo apoda.
    MAX(price) AS "Precio Máximo", -- Encuentra el precio máximo por categoría y lo apoda.
    MIN(price) AS "Precio Mínimo", -- Encuentra el precio mínimo por categoría y lo apoda.
    COUNT(title_id) AS "Cantidad Libros" -- Cuenta el número de libros en la categoría y lo apoda.
FROM
    titles -- De la tabla 'titles'.
WHERE
    type IS NOT NULL AND type != '' -- Excluye categorías nulas o vacías.
GROUP BY
    type -- Agrupa por tipo de libro.
HAVING
    MIN(price) < 10 -- El precio mínimo debe ser inferior a 10.
    AND COUNT(title_id) > 2; -- La cantidad de libros debe ser mayor a 2.

-- Ejercicio 30: Contar la cantidad de empleados que trabajen en la compañía.
SELECT
    COUNT(emp_id) AS "Total Empleados" -- Cuenta el número total de IDs de empleado y apoda la columna.
FROM
    employee; -- De la tabla 'employee'.

-- Ejercicio 31: Seleccionar todos los libros junto a todos los datos de la editorial la cual lo publicó.
SELECT
    T.*, -- Selecciona todas las columnas de la tabla 'titles'.
    P.* -- Selecciona todas las columnas de la tabla 'publishers'.
FROM
    titles T -- Alias 'T' para la tabla 'titles'.
INNER JOIN
    publishers P ON T.pub_id = P.pub_id; -- Une con 'publishers' donde el ID de la editorial coincida.

-- Ejercicio 32: Mostrar el nombre del libro y el nombre de la editorial la cual lo publicó sólo de las editoriales que tengan residencia en USA.
-- Mostrar un apodo para cada columna.
SELECT
    T.title AS "Nombre Libro", -- Selecciona el título y lo apoda.
    P.pub_name AS "Nombre Editorial" -- Selecciona el nombre de la editorial y lo apoda.
FROM
    titles T -- Alias 'T' para la tabla 'titles'.
INNER JOIN
    publishers P ON T.pub_id = P.pub_id -- Une con 'publishers' donde el ID de la editorial coincida.
WHERE
    P.country = 'USA'; -- Filtra por editoriales que residen en USA.

-- Ejercicio 33: Listar los autores que residan en el mismo estado que las tiendas.
-- Mostrar el nombre y apellido del autor en una columna y el nombre de la tienda en otra.
-- Apodar ambas columnas. Ordenar por la columna 1.
SELECT
    CONCAT(A.au_fname, ' ', A.au_lname) AS "Nombre Autor", -- Concatena nombre y apellido del autor y lo apoda.
    S.stor_name AS "Nombre Tienda" -- Selecciona el nombre de la tienda y lo apoda.
FROM
    authors A -- Alias 'A' para la tabla 'authors'.
INNER JOIN
    stores S ON A.state = S.state -- Une 'authors' y 'stores' donde el estado del autor coincide con el estado de la tienda.
ORDER BY
    "Nombre Autor"; -- Ordena por la primera columna apodada.

-- Ejercicio 34: Mostrar el nombre y apellido del autor y el nombre de los libros publicados por el mismo.
-- Mostrar un apodo para cada columna. Ordenar por la primera columna de la consulta.
SELECT
    CONCAT(A.au_fname, ' ', A.au_lname) AS "Nombre Autor", -- Concatena nombre y apellido del autor y lo apoda.
    T.title AS "Título Libro" -- Selecciona el título del libro y lo apoda.
FROM
    authors A -- Alias 'A' para la tabla 'authors'.
INNER JOIN
    titleauthor TA ON A.au_id = TA.au_id -- Une 'authors' con 'titleauthor' por el ID del autor.
INNER JOIN
    titles T ON TA.title_id = T.title_id -- Une con 'titles' por el ID del libro.
ORDER BY
    "Nombre Autor"; -- Ordena por la primera columna apodada.

-- Ejercicio 35: Mostrar los libros junto a su autor y su editorial.
-- Se debe mostrar los datos en una única columna de la siguiente manera con los siguientes textos literales:
-- 'El libro XXXXXXXXXXXXX fue escrito por XXXXXXXXXXXXX y publicado por la editorial XXXXXXXXXXXXX'
SELECT
    CONCAT(
        'El libro ', T.title,
        ' fue escrito por ', A.au_fname, ' ', A.au_lname,
        ' y publicado por la editorial ', P.pub_name
    ) AS Detalle_Publicación -- Concatena los textos y los datos de las tres tablas para formar la frase.
FROM
    titles T -- Alias 'T' para 'titles'.
INNER JOIN
    titleauthor TA ON T.title_id = TA.title_id -- Une con 'titleauthor'.
INNER JOIN
    authors A ON TA.au_id = A.au_id -- Une con 'authors'.
LEFT JOIN
    publishers P ON T.pub_id = P.pub_id; -- Une con 'publishers' (LEFT JOIN para incluir libros con editorial nula si existieran, aunque en este caso pub_id es una FK).

-- Ejercicio 36: Mostrar el nombre de las editoriales que no hayan publicado ningún libro.
SELECT
    P.pub_name AS "Editorial Sin Libros" -- Selecciona el nombre de la editorial y lo apoda.
FROM
    publishers P -- Alias 'P' para 'publishers'.
LEFT JOIN
    titles T ON P.pub_id = T.pub_id -- Realiza un LEFT JOIN con 'titles'.
WHERE
    T.title_id IS NULL; -- Filtra donde no hay coincidencias en 'titles' (es decir, la editorial no publicó libros).

-- Ejercicio 37: Mostrar el nombre de los libros que nunca fueron vendidos.
SELECT
    T.title AS "Libro No Vendido" -- Selecciona el título del libro y lo apoda.
FROM
    titles T -- Alias 'T' para 'titles'.
LEFT JOIN
    sales S ON T.title_id = S.title_id -- Realiza un LEFT JOIN con 'sales'.
WHERE
    S.ord_num IS NULL -- Filtra donde no hay coincidencias en 'sales' (es decir, el libro nunca fue vendido).
    AND T.title_id IS NOT NULL AND T.title != ''; -- Filtra títulos no nulos ni vacíos.

-- Ejercicio 38: Mostrar el nombre y apellido de los empleados y la descripción del trabajo que realiza.
-- Basar la relación en el nivel de trabajo. (Nota: La relación correcta es por job_id, pero se sigue la instrucción de job_lvl)
SELECT
    CONCAT(E.fname, ' ', E.lname) AS "Nombre Empleado", -- Concatena nombre y apellido.
    J.job_desc AS "Descripción Trabajo" -- Selecciona la descripción del trabajo.
FROM
    employee E -- Alias 'E' para 'employee'.
INNER JOIN
    jobs J ON E.job_lvl BETWEEN J.min_lvl AND J.max_lvl; -- Une 'employee' con 'jobs' donde el job_lvl del empleado cae dentro del rango de niveles del trabajo.

-- Ejercicio 39: Mostrar el producto cartesiano entre los libros de negocio ('business') y las tiendas ubicadas en California (CA).
-- Mostrar el nombre de la tienda y el nombre del libro. Ordenar por nombre de tienda.
SELECT
    S.stor_name AS "Nombre Tienda", -- Selecciona el nombre de la tienda.
    T.title AS "Nombre Libro" -- Selecciona el título del libro.
FROM
    titles T, -- Tabla 'titles'.
    stores S -- Tabla 'stores'.
WHERE
    T.type = 'business' -- Filtra libros de categoría 'business'.
    AND S.state = 'CA' -- Filtra tiendas en California (CA).
ORDER BY
    "Nombre Tienda"; -- Ordena por nombre de tienda.

-- Ejercicio 40: Listar todas las ciudades mencionadas en la base de datos.
SELECT city FROM authors -- Selecciona ciudades de la tabla 'authors'.
UNION -- Combina los resultados y elimina duplicados.
SELECT city FROM publishers -- Selecciona ciudades de la tabla 'publishers'.
UNION -- Combina los resultados y elimina duplicados.
SELECT city FROM stores -- Selecciona ciudades de la tabla 'stores'.
ORDER BY 
    city ASC; -- Ordena las ciudades en orden ascendente.