USE sakila;

-- CONSULTA 1

SELECT postal_code AS 'Código Postal' FROM address WHERE postal_code IN (SELECT postal_code FROM address WHERE address_id > 500);

SELECT a.address_id, a.address, a.postal_code, c.city, co.country
FROM address a
JOIN city c ON a.city_id = c.city_id
JOIN country co ON c.country_id = co.country_id
WHERE a.postal_code NOT IN ('12345', '54321');

DROP INDEX postal_code ON address;

-- Duraciones sin Índices:
-- Consulta 1 Duración: 0.0017 seg / 0.000039 seg
-- Consulta 2 Duración: 0.0027 seg / 0.0015 seg

CREATE INDEX postal_code ON address(postal_code);

-- Duraciones con Índices:
-- Consulta 1 Duración: 0.00070 seg / 0.000018 seg
-- Consulta 2 Duración: 0.00087 seg / 0.00028 seg

-- Los índices en MySQL almacenan físicamente las filas de las tablas indexadas en el disco para recuperar la información rápidamente.
-- Esto reduce el tiempo de ejecución de las consultas ya que no es necesario escanear toda la tabla.
-- Aunque la diferencia puede ser pequeña en consultas simples, con datasets grandes, el aumento de velocidad es significativo.

-- CONSULTA 2
-- Ejecutar consultas usando la tabla actor, buscando por las columnas first_name y last_name por separado.
-- Explicar las diferencias y por qué sucede esto.

SELECT first_name FROM actor WHERE first_name LIKE 'A%';
SELECT last_name FROM actor WHERE last_name LIKE 'E%';

-- En estas dos consultas, se nota una diferencia más clara en los tiempos de ejecución en comparación con la actividad anterior.
-- La primera consulta, que extrae el `first_name` (una columna no indexada), tiene una duración promedio de 0.0011 seg / 0.000025 seg,
-- mientras que la segunda consulta, que usa la columna `last_name` (indexada), tiene una duración promedio de 0.00076 seg / 0.000016 seg.
-- Con un conjunto de datos más grande, la diferencia sería más notoria, ya que `last_name` se beneficia del índice, mientras que `first_name` requiere un escaneo completo.

-- CONSULTA 3
-- Comparar los resultados de buscar texto en la descripción en la tabla film usando LIKE y en film_text con MATCH ... AGAINST.
-- Explicar los resultados.

SELECT f.film_id AS 'ID', f.title AS 'Título', f.description AS 'Texto de Descripción' FROM film f WHERE f.description LIKE '%Girl%';
SELECT ft.film_id AS 'ID', ft.title AS 'Título', ft.description AS 'Texto de Descripción' FROM film_text ft WHERE MATCH(ft.title, ft.description) AGAINST ('Girl');

-- Al comparar estas dos consultas, la diferencia más importante es que la consulta con MATCH / AGAINST se ejecuta más rápido que la que usa LIKE.
-- LIKE escanea toda la tabla, verificando cada fila de la descripción individualmente para ver si contiene 'Girl', lo cual es ineficiente para campos de texto grandes.
-- MATCH / AGAINST usa el índice FULLTEXT creado en film_text para encontrar rápidamente las coincidencias sin escanear cada fila.
-- Para búsquedas en campos de texto largos, es ideal usar índices FULLTEXT, mientras que LIKE es útil para patrones más simples o textos pequeños.
