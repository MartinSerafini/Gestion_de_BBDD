-- ==========================================
-- Ejercicios de creación de vistas con MySQL
-- ==========================================

-- ==============================================================================================
-- Ejercicio 1: Crea una vista que muestre el título, el autor y el precio de todos los libros de 
-- la tabla titles.
-- ==============================================================================================
-- Solución: Se unen las tablas `titles`, `titleauthor` y `authors` para obtener el título del libro,
-- el nombre completo del autor y el precio.
--
CREATE VIEW view_title_author_price AS -- Crea la vista llamada 'view_title_author_price'
SELECT
    T.title AS Titulo,                             -- Selecciona el título del libro
    CONCAT(A.au_fname, ' ', A.au_lname) AS Autor,  -- Concatena el nombre y apellido del autor para crear una columna 'author'
    FORMAT(T.price,2) AS Precio                    -- Selecciona el precio del libro y fija en 2 decimales
FROM titles AS T                                   -- Selecciona de la tabla 'titles' y le da el alias 'T'
INNER JOIN titleauthor AS TA                       -- Realiza un Inner Join con la tabla 'titleauthor'
    ON T.title_id = TA.title_id                    -- Condición de unión: el ID del título en ambas tablas debe coincidir
INNER JOIN authors AS A                            -- Realiza un Inner Join con la tabla 'authors'
    ON TA.au_id = A.au_id;                         -- Condición de unión: el ID del autor en ambas tablas debe coincidir

-- =============================================================================================
-- Ejercicio 2: Crea una vista que muestre el título, el autor, el precio y el tipo de todos los 
-- libros de la tabla titles.
-- =============================================================================================
-- Solución: Similar a la vista anterior, se añade la columna `type` de la tabla `titles`.
--
CREATE VIEW view_title_author_price_type AS        -- Crea la vista 'view_title_author_price_type'
SELECT
    T.title AS Titulo,                             -- Selecciona el título del libro
    CONCAT(A.au_fname, ' ', A.au_lname) AS Autor,  -- Concatena el nombre y apellido del autor
    FORMAT(T.price,2) AS Precio,                   -- Selecciona el precio del libro
    T.type AS Categoria                            -- Selecciona el tipo de libro
FROM titles AS T                                   -- Selecciona de la tabla 'titles'
INNER JOIN titleauthor AS TA                       -- Une con la tabla 'titleauthor'
    ON T.title_id = TA.title_id                    -- Condición de unión por ID de título
INNER JOIN authors AS A                            -- Une con la tabla 'authors'
    ON TA.au_id = A.au_id;                         -- Condición de unión por ID de autor

-- =================================================================================================
-- Ejercicio 3: Crea una vista que muestre el título, el autor, el precio y la fecha de publicación 
-- de todos los libros de la tabla titles.
-- =================================================================================================
-- Solución: Se incluye la columna `pubdate` de la tabla `titles`.
--
CREATE VIEW view_title_author_price_pubdate AS -- Crea la vista 'view_title_author_price_pubdate'
SELECT
    T.title AS Titulo,                                     -- Selecciona el título del libro
    CONCAT(A.au_fname, ' ', UPPER(A.au_lname)) AS Autor,   -- Concatena el nombre y apellido del autor (En mayusculas)
    FORMAT(T.price,2) AS Precio,                           -- Selecciona el precio del libro
    DATE_FORMAT(T.pubdate, '%d/%m/%Y') AS Fecha_Publicacion-- Selecciona la fecha de publicación del libro, formatea en dd/mm/aaaa
FROM titles AS T                                           -- Selecciona de la tabla 'titles'
INNER JOIN titleauthor AS TA                               -- Une con la tabla 'titleauthor'
    ON T.title_id = TA.title_id                            -- Condición de unión por ID de título
INNER JOIN authors AS A                                    -- Une con la tabla 'authors'
    ON TA.au_id = A.au_id;                                 -- Condición de unión por ID de autor

-- ===============================================================================================
-- Ejercicio 4: Crea una vista que muestre el título, el autor, el precio y la cantidad vendida de
-- todos los libros de la tabla sales.
-- ===============================================================================================
-- Solución: Se unen las tablas `titles`, `titleauthor`, `authors` y `sales`. Se agrupan los resultados
-- por título y autor para sumar la cantidad vendida (`qty`).
--
CREATE VIEW view_title_author_price_sales AS              -- Crea la vista 'view_title_author_price_sales'
SELECT
    T.title AS Titulo,                                    -- Selecciona el título del libro
    CONCAT(A.au_fname, ' ', UPPER(A.au_lname)) AS Autor,  -- Concatena el nombre y apellido del autor
    FORMAT(T.price,2) AS Precio,                          -- Selecciona el precio del libro
    FORMAT(SUM(S.qty),0) AS Total_Ventas                  -- Suma la cantidad de ventas y la renombra como 'total_sold'
FROM titles AS T                                          -- Selecciona de la tabla 'titles'
INNER JOIN titleauthor AS TA                              -- Une con la tabla 'titleauthor'
    ON T.title_id = TA.title_id                           -- Condición de unión por ID de título
INNER JOIN authors AS A                                   -- Une con la tabla 'authors'
    ON TA.au_id = A.au_id                                 -- Condición de unión por ID de autor
INNER JOIN sales AS S                                     -- Une con la tabla 'sales'
    ON T.title_id = S.title_id                            -- Condición de unión por ID de título
GROUP BY T.title, Autor, T.price;                         -- Agrupa los resultados por título, autor y precio para la función de agregación

-- ============================================================================================
-- Ejercicio 5: Crea una vista que muestre el título, el autor, el precio y la cantidad vendida 
-- de todos los libros de la tabla sales por cada tienda.
-- ============================================================================================
-- Solución: Se añade la tabla `stores` para obtener el nombre de la tienda (`stor_name`) y se agrupa por esta columna.
--
CREATE VIEW view_sales_por_store AS                  -- Crea la vista 'view_sales_by_store'
SELECT
    S.stor_name AS Negocio,                               -- Selecciona el nombre de la tienda
    T.title AS Titulo,                                    -- Selecciona el título del libro
    CONCAT(A.au_fname, ' ', UPPER(A.au_lname)) AS Autor,  -- Concatena el nombre y apellido del autor
    FORMAT(T.price,2) AS Precio,                          -- Selecciona el precio del libro
    SUM(SA.qty) AS Total_Ventas                           -- Suma la cantidad de ventas por tienda
FROM sales AS SA                                          -- Selecciona de la tabla 'sales' y le da el alias 'SA'
INNER JOIN titles AS T                                    -- Une con la tabla 'titles'
    ON SA.title_id = T.title_id                           -- Condición de unión por ID de título
INNER JOIN titleauthor AS TA                              -- Une con la tabla 'titleauthor'
    ON T.title_id = TA.title_id                           -- Condición de unión por ID de título
INNER JOIN authors AS A                                   -- Une con la tabla 'authors'
    ON TA.au_id = A.au_id                                 -- Condición de unión por ID de autor
INNER JOIN stores AS S                                    -- Une con la tabla 'stores'
    ON SA.stor_id = S.stor_id                             -- Condición de unión por ID de tienda
GROUP BY Negocio, Titulo, Autor, Precio;                  -- Agrupa los resultados por tienda, título, autor y precio

-- ============================================================================================
-- Ejercicio 6: Crea una vista que muestre el título, el autor, el precio y la cantidad vendida
-- de todos los libros de la tabla sales por cada tipo de libro.
-- ============================================================================================
-- Solución: Se añade el `type` de la tabla `titles` y se utiliza para agrupar los resultados.
--
CREATE VIEW view_sales_por_type AS -- Crea la vista 'view_sales_by_type'
SELECT
    T.type AS Categoria,                                   -- Selecciona el tipo de libro
    T.title AS Titulo,                                     -- Selecciona el título del libro
    CONCAT(A.au_fname, ' ', UPPER(A.au_lname)) AS Autor,   -- Concatena el nombre y apellido del autor
    FORMAT(T.price,2) AS Precio,                           -- Selecciona el precio del libro
    SUM(S.qty) AS Total_Ventas                            -- Suma la cantidad de ventas por tipo de libro
FROM sales AS S                                            -- Selecciona de la tabla 'sales'
INNER JOIN titles AS T
    ON S.title_id = T.title_id                             -- Une con la tabla 'titles' por ID de título
INNER JOIN titleauthor AS TA
    ON T.title_id = TA.title_id                            -- Une con la tabla 'titleauthor' por ID de título
INNER JOIN authors AS A
    ON TA.au_id = A.au_id                                  -- Une con la tabla 'authors' por ID de autor
GROUP BY Categoria, Titulo, Autor, Precio;                 -- Agrupa los resultados por tipo, título, autor y precio

-- ============================================================================================
-- Ejercicio 7: Crea una vista que muestre el título, el autor, el precio y la cantidad vendida 
-- de todos los libros de la tabla sales por cada tienda y tipo de libro.
-- ============================================================================================
-- Solución: Se combinan las agrupaciones por `stor_name` (tienda) y `type` (tipo de libro).
--
CREATE VIEW view_sales_por_store_y_type AS              -- Crea la vista 'view_sales_by_store_and_type'
SELECT
    S.stor_name AS Negocio,                             -- Selecciona el nombre de la tienda
    T.type AS Categoria,                                -- Selecciona el tipo de libro
    T.title AS Titulo,                                  -- Selecciona el título del libro
    CONCAT(A.au_fname, ' ', UPPER(A.au_lname)) AS Autor,-- Concatena el nombre y apellido del autor
    FORMAT(T.price,2) AS Precio,                        -- Selecciona el precio del libro
    SUM(SA.qty) AS Total_Ventas                         -- Suma la cantidad de ventas por tienda y tipo de libro
FROM sales AS SA                                        -- Selecciona de la tabla 'sales'
INNER JOIN titles AS T
    ON SA.title_id = T.title_id                         -- Une con la tabla 'titles' por ID de título
INNER JOIN titleauthor AS TA
    ON T.title_id = TA.title_id                         -- Une con la tabla 'titleauthor' por ID de título
INNER JOIN authors AS A
    ON TA.au_id = A.au_id                               -- Une con la tabla 'authors' por ID de autor
INNER JOIN stores AS S
    ON SA.stor_id = S.stor_id                           -- Une con la tabla 'stores' por ID de tienda
GROUP BY Negocio, Categoria, Titulo, Autor, Precio; -- Agrupa por tienda, tipo, título, autor y precio

-- ============================================================================================
-- Ejercicio 8: Crea una vista que muestre el título, el autor, el precio y la cantidad vendida 
-- de todos los libros de la tabla sales por cada tienda y año de publicación.
-- ============================================================================================
-- Solución: Se agrupa por `stor_name` y por el año de publicación del libro (`YEAR(T.pubdate)`).
--
CREATE VIEW view_sales_por_store_y_year AS -- Crea la vista 'view_sales_by_store_and_year'
SELECT
    S.stor_name AS Negocio,                              -- Selecciona el nombre de la tienda
    YEAR(T.pubdate) AS Año_Publicacion,                  -- Extrae el año de la fecha de publicación y lo renombra
    T.title AS Titulo,                                   -- Selecciona el título del libro
    CONCAT(A.au_fname, ' ', UPPER(A.au_lname)) AS Autor, -- Concatena el nombre y apellido del autor
    FORMAT(T.price,2) AS Precio,                         -- Selecciona el precio del libro
    SUM(SA.qty) AS Total_Ventas                          -- Suma la cantidad de ventas por tienda y año de publicación
FROM sales AS SA                                         -- Selecciona de la tabla 'sales'
INNER JOIN titles AS T
    ON SA.title_id = T.title_id                          -- Une con la tabla 'titles' por ID de título
INNER JOIN titleauthor AS TA
    ON T.title_id = TA.title_id                          -- Une con la tabla 'titleauthor' por ID de título
INNER JOIN authors AS A
    ON TA.au_id = A.au_id                                -- Une con la tabla 'authors' por ID de autor
INNER JOIN stores AS S
    ON SA.stor_id = S.stor_id                            -- Une con la tabla 'stores' por ID de tienda
GROUP BY Negocio, Año_Publicacion, Titulo, Autor, Precio; -- Agrupa por tienda, año, título, autor y precio

-- ============================================================================================
-- Ejercicio 9: Crea una vista que muestre el título, el autor, el precio y la cantidad vendida 
-- de todos los libros de la tabla sales por cada tienda, tipo de libro y año de publicación.
-- ============================================================================================
-- Solución: Se combinan las agrupaciones por `stor_name`, `type` y `publication_year`.
--
CREATE VIEW view_sales_por_store_type_y_year AS         -- Crea la vista 'view_sales_by_store_type_and_year'
SELECT
    S.stor_name AS Negocio,                              -- Selecciona el nombre de la tienda
    T.type AS Categoria,                                   -- Selecciona el tipo de libro
    YEAR(T.pubdate) AS Año_Publicacion,                  -- Extrae y renombra el año de publicación
    T.title AS Titulo,                                   -- Selecciona el título del libro
    CONCAT(A.au_fname, ' ', UPPER(A.au_lname)) AS Autor, -- Concatena el nombre y apellido del autor
    FORMAT(T.price,2) AS Precio,                         -- Selecciona el precio del libro
    SUM(SA.qty) AS Total_Ventas                          -- Suma la cantidad de ventas por tienda, tipo y año
FROM sales AS SA                                         -- Selecciona de la tabla 'sales'
INNER JOIN titles AS T
    ON SA.title_id = T.title_id                          -- Une con la tabla 'titles' por ID de título
INNER JOIN titleauthor AS TA
    ON T.title_id = TA.title_id                          -- Une con la tabla 'titleauthor' por ID de título
INNER JOIN authors AS A
    ON TA.au_id = A.au_id                                -- Une con la tabla 'authors' por ID de autor
INNER JOIN stores AS S
    ON SA.stor_id = S.stor_id                            -- Une con la tabla 'stores' por ID de tienda
GROUP BY Negocio, Categoria, Año_Publicacion, Titulo, Autor, Precio; -- Agrupa por tienda, tipo, año, título, autor y precio

-- ==============================================================================================
-- Ejercicio 10: Crea una vista que muestre el título, el autor, el precio y la cantidad vendida 
-- de todos los libros de la tabla sales por cada tienda, tipo de libro, año de publicación y mes 
-- de publicación.
-- ==============================================================================================
-- Solución: Se añade la agrupación por mes de publicación (`MONTH(T.pubdate)`).
--
CREATE VIEW view_sales_por_store_type_year_y_month AS    -- Crea la vista 'view_sales_by_store_type_year_and_month'
SELECT
    S.stor_name AS Negocio,                               -- Selecciona el nombre de la tienda
    T.type AS Categoria,                                  -- Selecciona el tipo de libro
    YEAR(T.pubdate) AS Año_Publicacion,                   -- Extrae y renombra el año de publicación
    MONTH(T.pubdate) AS Mes_Publicacion,                  -- Extrae y renombra el mes de publicación
    T.title AS Titulo,                                    -- Selecciona el título del libro
    CONCAT(A.au_fname, ' ', UPPER(A.au_lname)) AS Autor,  -- Concatena el nombre y apellido del autor
    FORMAT(T.price,2) AS Precio,                          -- Selecciona el precio del libro
    SUM(SA.qty) AS Total_Ventas                           -- Suma la cantidad de ventas por tienda, tipo, año y mes
FROM sales AS SA                                          -- Selecciona de la tabla 'sales'
INNER JOIN titles AS T
    ON SA.title_id = T.title_id                           -- Une con la tabla 'titles' por ID de título
INNER JOIN titleauthor AS TA
    ON T.title_id = TA.title_id                           -- Une con la tabla 'titleauthor' por ID de título
INNER JOIN authors AS A
    ON TA.au_id = A.au_id                                 -- Une con la tabla 'authors' por ID de autor
INNER JOIN stores AS S
    ON SA.stor_id = S.stor_id                             -- Une con la tabla 'stores' por ID de tienda
GROUP BY Negocio, Categoria, Año_Publicacion, Mes_Publicacion, Titulo, Autor, Precio; -- Agrupa por tienda, tipo, año, mes, título, autor y precio

-- ====================================================
-- Vistas que tienen condiciones con la cláusula WHERE:
-- ====================================================

-- =================================================================================================
-- Ejercicio 11: Crea una vista que muestre el título, el autor, el precio y la cantidad vendida de 
-- todos los libros de la tabla sales por cada tienda, tipo de libro y año de publicación, pero solo 
-- para las ventas que superaron los 10 libros.
-- =================================================================================================
-- Solución: Se agrega una cláusula `WHERE` para filtrar las ventas con una cantidad (`qty`) mayor a 10.
--
CREATE VIEW view_sales_superior_a_10 AS             -- Crea la vista 'view_sales_over_10_qty'
SELECT
    S.stor_name AS Negocio,                         -- Selecciona el nombre de la tienda
    T.type AS Categoria,                             -- Selecciona el tipo de libro
    YEAR(T.pubdate) AS Año_Publicacion,             -- Extrae y renombra el año de publicación
    T.title AS Titulo,                              -- Selecciona el título del libro
    CONCAT(A.au_fname, ' ', UPPER(A.au_lname)) AS Autor,   -- Concatena el nombre y apellido del autor
    FORMAT(T.price,2) AS Precio,                              -- Selecciona el precio del libro
    SUM(SA.qty) AS Total_Ventas                     -- Suma la cantidad de ventas
FROM sales AS SA                                    -- Selecciona de la tabla 'sales'
INNER JOIN titles AS T
    ON SA.title_id = T.title_id                     -- Une con 'titles' por ID de título
INNER JOIN titleauthor AS TA
    ON T.title_id = TA.title_id                     -- Une con 'titleauthor' por ID de título
INNER JOIN authors AS A
    ON TA.au_id = A.au_id                           -- Une con 'authors' por ID de autor
INNER JOIN stores AS S
    ON SA.stor_id = S.stor_id                       -- Une con 'stores' por ID de tienda
WHERE SA.qty > 10                                   -- Filtra los registros donde la cantidad vendida es mayor a 10
GROUP BY Negocio, Categoria, Año_Publicacion, Titulo, Autor, Precio; -- Agrupa los resultados

-- ===============================================================================================
-- Ejercicio 12: Crea una vista que muestre el título, el autor, el precio y la cantidad vendida 
-- de todos los libros de la tabla sales por cada tienda, tipo de libro y año de publicación, pero 
-- solo para las ventas que se realizaron en el año 1990.
-- ================================================================================================
-- Solución: Se usa una cláusula `WHERE` para filtrar las ventas con `YEAR(SA.ord_date) = 1990`.
--
CREATE VIEW view_sales_en_1990 AS                   -- Crea la vista 'view_sales_in_1990'
SELECT
    S.stor_name AS Negocio,                         -- Selecciona el nombre de la tienda
    T.type AS Categoria,                            -- Selecciona el tipo de libro
    YEAR(T.pubdate) AS Año_Publicacion,             -- Extrae y renombra el año de publicación
    T.title AS Titulo,                              -- Selecciona el título del libro
    CONCAT(A.au_fname, ' ', UPPER(A.au_lname)) AS Autor,   -- Concatena el nombre y apellido del autor
    FORMAT(T.price,2) AS Precio,                              -- Selecciona el precio del libro
    SUM(SA.qty) AS Total_Ventas                     -- Suma la cantidad de ventas
FROM sales AS SA                                    -- Selecciona de la tabla 'sales'
INNER JOIN titles AS T
    ON SA.title_id = T.title_id                     -- Une con 'titles' por ID de título
INNER JOIN titleauthor AS TA
    ON T.title_id = TA.title_id                     -- Une con 'titleauthor' por ID de título
INNER JOIN authors AS A
    ON TA.au_id = A.au_id                           -- Une con 'authors' por ID de autor
INNER JOIN stores AS S
    ON SA.stor_id = S.stor_id                       -- Une con 'stores' por ID de tienda
WHERE YEAR(SA.ord_date) = 1990                      -- Filtra los registros donde el año de la fecha de la orden es 1990
GROUP BY Negocio, Categoria, Año_Publicacion, Titulo, Autor, Precio; -- Agrupa los resultados

-- ===============================================================================================
-- Ejercicio 13: Crea una vista que muestre el título, el autor, el precio y la cantidad vendida 
-- de todos los libros de la tabla sales por cada tienda, tipo de libro y año de publicación, pero 
-- solo para las ventas que se realizaron entre 1990 y 1994.
-- ===============================================================================================
-- Solución: Se usa la cláusula `WHERE` con `BETWEEN` para filtrar el rango de años de la fecha de 
-- la orden.
--
CREATE VIEW view_sales_entre_1990_y_1994 AS             -- Crea la vista 'view_sales_1990_to_1994'
SELECT
    S.stor_name AS Negocio,                             -- Selecciona el nombre de la tienda
    T.type AS Categoria,                                -- Selecciona el tipo de libro
    YEAR(T.pubdate) AS Año_Publicacion,                 -- Extrae y renombra el año de publicación
    T.title AS Titulo,                                  -- Selecciona el título del libro
    CONCAT(A.au_fname, ' ', UPPER(A.au_lname)) AS Autor,-- Concatena el nombre y apellido del autor
    FORMAT(T.price,2) AS Precio,                                  -- Selecciona el precio del libro
    SUM(SA.qty) AS Total_Ventas                         -- Suma la cantidad de ventas
FROM sales AS SA                                        -- Selecciona de la tabla 'sales'
INNER JOIN titles AS T
    ON SA.title_id = T.title_id                         -- Une con 'titles' por ID de título
INNER JOIN titleauthor AS TA
    ON T.title_id = TA.title_id                         -- Une con 'titleauthor' por ID de título
INNER JOIN authors AS A
    ON TA.au_id = A.au_id                               -- Une con 'authors' por ID de autor
INNER JOIN stores AS S
    ON SA.stor_id = S.stor_id                           -- Une con 'stores' por ID de tienda
WHERE YEAR(SA.ord_date) BETWEEN 1990 AND 1994           -- Filtra por ventas realizadas entre 1990 y 1994
GROUP BY Negocio, Categoria, Año_Publicacion, Titulo, Autor, Precio; -- Agrupa los resultados

-- ===============================================================================================
-- Ejercicio 14: Crea una vista que muestre el título, el autor, el precio y la cantidad vendida 
-- de todos los libros de la tabla sales por cada tienda, tipo de libro y año de publicación, pero 
-- solo para las ventas que se realizaron en la tienda con el ID 7066.
-- ===============================================================================================
-- Solución: Se filtra por el `stor_id` de la tabla `stores`.
--
CREATE VIEW view_sales_en_store_7066 AS                     -- Crea una vista llamada 'view_sales_en_store_7066'
SELECT
    S.stor_name AS Negocio,                                 -- Selecciona el nombre de la tienda y lo renombra como 'Negocio'
    T.type AS Categoria,                                    -- Selecciona el tipo de libro (categoría) y lo renombra como 'Categoria'
    YEAR(T.pubdate) AS Año_Publicacion,                     -- Extrae solo el año de la fecha de publicación y lo renombra como 'Año_Publicacion'
    T.title AS Titulo,                                      -- Selecciona el título del libro y lo renombra como 'Titulo'
    CONCAT(A.au_fname, ' ', UPPER(A.au_lname)) AS Autor,    -- Une el nombre y apellido del autor en un solo campo llamado 'Autor'
    FORMAT(T.price,2) AS Precio,                            -- Selecciona el precio del libro con 2 decimales fijos y lo renombra como 'Precio'
    SUM(SA.qty) AS Total_Ventas                             -- Suma la cantidad total de ventas por cada libro y lo renombra como 'Total_Ventas'
FROM sales AS SA                                            -- Se toma como tabla principal 'sales', renombrada como SA
INNER JOIN titles AS T                                      -- Se une con la tabla 'titles' (información de los libros)
    ON SA.title_id = T.title_id                             -- Relaciona ventas con títulos mediante el 'title_id'
INNER JOIN titleauthor AS TA                                -- Se une con la tabla 'titleauthor' (relación entre títulos y autores)
    ON T.title_id = TA.title_id                             -- Relaciona títulos con autores por 'title_id'
INNER JOIN authors AS A                                     -- Se une con la tabla 'authors' (información de los autores)
    ON TA.au_id = A.au_id                                   -- Relaciona 'titleauthor' con 'authors' por 'au_id'
INNER JOIN stores AS S                                      -- Se une con la tabla 'stores' (información de las tiendas)
    ON SA.stor_id = S.stor_id                               -- Relaciona ventas con la tienda mediante 'stor_id'
WHERE SA.stor_id = '7066'                                   -- Filtra para que solo aparezcan los registros de la tienda con ID = 7066
GROUP BY 
    Negocio,                                                -- Agrupa por el nombre de la tienda
    Categoria,                                              -- Agrupa por la categoría del libro
    Año_Publicacion,                                        -- Agrupa por el año de publicación
    Titulo,                                                 -- Agrupa por título de libro
    Autor,                                                  -- Agrupa por autor
    Precio;                                                 -- Agrupa por precio del libro

-- ===============================================================================================
-- Ejercicio 15: Crea una vista que muestre el título, el autor, el precio y la cantidad vendida 
-- de todos los libros de la tabla sales por cada tienda, tipo de libro y año de publicación, pero 
-- solo para las ventas que se realizaron por el autor con el ID 172.
-- ===============================================================================================
-- Solución: Se filtra por el `au_id` de la tabla `authors`.
--
CREATE VIEW view_sales_del_autor_172 AS                     -- Crea la vista 'view_sales_by_author_172'
SELECT
    S.stor_name AS Negocio,                                 -- Selecciona el nombre de la tienda y lo renombra como 'Negocio'
    T.type AS Categoria,                                    -- Selecciona el tipo de libro (categoría) y lo renombra como 'Categoria'
    YEAR(T.pubdate) AS Año_Publicacion,                     -- Extrae solo el año de la fecha de publicación y lo renombra como 'Año_Publicacion'
    T.title AS Titulo,                                      -- Selecciona el título del libro y lo renombra como 'Titulo'
    CONCAT(A.au_fname, ' ', UPPER(A.au_lname)) AS Autor,    -- Une el nombre y apellido del autor en un solo campo llamado 'Autor'
    FORMAT(T.price,2) AS Precio,                            -- Selecciona el precio del libro con 2 decimales fijos y lo renombra como 'Precio'
    SUM(SA.qty) AS Total_Ventas                             -- Suma la cantidad total de ventas por cada libro y lo renombra como 'Total_Ventas'
FROM sales AS SA                                            -- Selecciona de la tabla 'sales'
INNER JOIN titles AS T
    ON SA.title_id = T.title_id                             -- Une con 'titles' por ID de título
INNER JOIN titleauthor AS TA
    ON T.title_id = TA.title_id                             -- Une con 'titleauthor' por ID de título
INNER JOIN authors AS A
    ON TA.au_id = A.au_id                                   -- Une con 'authors' por ID de autor
INNER JOIN stores AS S
    ON SA.stor_id = S.stor_id                               -- Une con 'stores' por ID de tienda
WHERE A.au_id = 172                                         -- Filtra los registros por el autor con el ID '172'
GROUP BY 
    Negocio,                                                -- Agrupa por el nombre de la tienda
    Categoria,                                              -- Agrupa por la categoría del libro
    Año_Publicacion,                                        -- Agrupa por el año de publicación
    Titulo,                                                 -- Agrupa por título de libro
    Autor,                                                  -- Agrupa por autor
    Precio;                                                 -- Agrupa por precio del libro

-- =====================================================================
-- Actualización de datos en tablas mediante la actualización de vistas:
-- =====================================================================
-- Para que las vistas sean actualizables, deben cumplir ciertas condiciones 
-- (ej. no contener GROUP BY, JOIN, etc.).
--

-- =============================================================================================
-- Ejercicio 16: Crea una vista que permita actualizar el precio de un libro en la tabla titles.
-- =============================================================================================
-- Solución: Esta vista simple se basa en la tabla `titles` para permitir la actualización de la 
-- columna `price`.
--
CREATE VIEW actualizable_titles_price AS    -- Crea la vista 'actualizable_titles_price'
SELECT title_id, title, price               -- Selecciona las columnas necesarias para actualizar el precio
FROM titles;                                -- Selecciona de la tabla 'titles'

-- Ejemplo de uso:
UPDATE actualizable_titles_price SET price = 25.00 WHERE title_id = '13';

-- ==============================================================================================
-- Ejercicio 17: Crea una vista que permita actualizar el nombre de un autor en la tabla authors.
-- ==============================================================================================
-- Solución: Una vista basada en la tabla `authors` para actualizar el nombre y apellido del autor.
--
CREATE VIEW actualizable_authors_name AS    -- Crea la vista 'actualizable_authors_name'
SELECT au_id, au_fname, au_lname            -- Selecciona las columnas necesarias para actualizar el nombre del autor
FROM authors;                               -- Selecciona de la tabla 'authors'

-- Ejemplo de uso:
UPDATE actualizable_authors_name SET au_lname = 'Bennet-Smith' WHERE au_id = '409';

-- ===============================================================================================
-- Ejercicio 18: Crea una vista que permita actualizar la cantidad vendida de un libro en la tabla 
-- sales.
-- ===============================================================================================
-- Solución: Esta vista permite actualizar el campo `qty` en la tabla `sales`.
--
CREATE VIEW actualizable_sales_qty AS       -- Crea la vista 'actualizable_sales_qty'
SELECT stor_id, ord_num, title_id, qty      -- Selecciona las columnas de la tabla 'sales'
FROM sales;                                 -- Selecciona de la tabla 'sales'

-- Ejemplo de uso:
UPDATE actualizable_sales_qty SET qty = 100 WHERE ord_num = '6871' AND title_id = '2';

-- ==========================================================================================
-- Ejercicio 19: Crea una vista que permita actualizar la fecha de publicación de un libro en 
-- la tabla titles.
-- ==========================================================================================
-- Solución: Una vista simple para actualizar la columna `pubdate` en la tabla `titles`.
--
CREATE VIEW actualizable_titles_pubdate AS  -- Crea la vista 'actualizable_titles_pubdate'
SELECT title_id, title, pubdate             -- Selecciona las columnas para actualizar la fecha
FROM titles;                                -- Selecciona de la tabla 'titles'

-- Ejemplo de uso:
UPDATE actualizable_titles_pubdate SET pubdate = '2000-01-01' WHERE title_id = '13';

-- ===========================================================================================
-- Ejercicio 20: Crea una vista que permita actualizar el tipo de un libro en la tabla titles.
-- ===========================================================================================
-- Solución: Vista para modificar el `type` de un libro.
--
CREATE VIEW actualizable_titles_type AS -- Crea la vista 'actualizable_titles_type'
SELECT title_id, title, type -- Selecciona las columnas para actualizar el tipo de libro
FROM titles; -- Selecciona de la tabla 'titles'

-- Ejemplo de uso:
UPDATE actualizable_titles_type SET type = 'computer_science' WHERE title_id = '15';