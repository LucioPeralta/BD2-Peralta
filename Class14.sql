USE sakila;

-- QUERY 1
SELECT CONCAT(c.first_name, ' ', c.last_name) AS 'Customer', 
CONCAT(a.address, ', ', a.district) AS 'Address', 
CONCAT(ci.city, ', ', co.country) AS 'City' 
FROM customer c 
INNER JOIN address a USING (address_id)
INNER JOIN city ci USING (city_id) 
INNER JOIN country co USING (country_id)
WHERE co.country = 'Argentina';

-- QUERY 2
SELECT f.title AS 'Título', l.name AS 'Lenguaje', 
CASE f.rating 
    WHEN 'G' THEN 'G (General Audiences) – All ages admitted.'
    WHEN 'PG' THEN 'PG (Parental Guidance Suggested) – Some material may not be suitable for children.'
    WHEN 'PG-13' THEN 'PG-13 (Parents Strongly Cautioned) – Some material may be inappropriate for children under 13.'
    WHEN 'R' THEN 'R (Restricted) – Under 17 requires accompanying parent or adult guardian.'
    WHEN 'NC-17' THEN 'NC-17 (Adults Only) – No one 17 and under admitted.'
END AS 'Rating' 
FROM film f 
INNER JOIN language l USING (language_id);

-- QUERY 3
SELECT CONCAT(a.first_name, ' ', a.last_name) AS 'Actor', 
GROUP_CONCAT(' ', f.title, ' ', f.release_year) AS 'Película'
FROM actor a 
INNER JOIN film_actor fa USING (actor_id) 
INNER JOIN film f USING (film_id)
WHERE CONCAT(a.first_name, ' ', a.last_name) LIKE '%%' 
GROUP BY a.actor_id;

-- QUERY 4
SELECT f.title AS 'Título', r.rental_date AS 'Fecha de Renta', 
CONCAT(c.first_name, ' ', c.last_name) AS 'Customer', 
IF(r.return_date IS NOT NULL, 'Yes', 'No') AS 'Devuelto'
FROM rental r 
INNER JOIN inventory i USING (inventory_id) 
INNER JOIN customer c USING (customer_id) 
INNER JOIN film f USING (film_id)
WHERE MONTH(r.rental_date) BETWEEN 5 AND 6;

-- QUERY 5

/*
CAST y CONVERT solo tienen una diferencia menor cuando se utiliza en MySQL, y esa es su sintaxis:
CAST(expr AS type) // CONVERT(expr, type)
Sin embargo, en SQL Server, esto no es así. Mientras que CAST permanece igual, CONVERT tiene una entrada adicional de 'style' que permite más opciones de formato.
Otro aspecto importante es que CONVERT se puede utilizar de 2 maneras. Usar la sintaxis mencionada anteriormente es lo mismo que usar CAST, mientras que utilizarlo como
CONVERT(expr USING type) convierte el conjunto de caracteres de una cadena.
En resumen, CAST y CONVERT deberían ser intercambiables cuando se opera en MySQL, pero esto puede variar en diferentes dialectos SQL. 
Esto significa que CAST es mejor cuando se intenta hacer código portátil, mientras que CONVERT puede hacer uso de opciones de personalización más flexibles dependiendo del dialecto.
Aquí hay un ejemplo utilizando ambos:
*/

SELECT CAST(rental_date AS DATE) AS 'Fecha desde CAST' FROM rental; -- Convierte el campo datetime rental_date en una fecha.
SELECT CONVERT(rental_date, DATE) AS 'Fecha desde CONVERT' FROM rental; -- Igual que usar CAST

-- QUERY 6

/*
NVL es una función que verifica si un valor es NULL y lo reemplaza con un valor especificado si lo es. Sin embargo, NO está disponible en MySQL (se usa en bases de datos Oracle).
Sintaxis: NVL(field, replacement_value), Ejemplo: NVL(rental_date, '2005-05-24') <- Reemplazaría rental_date con la fecha dada si es NULL.

IFNULL cumple la misma función que NVL, la diferencia clave es que esta SÍ está disponible en MySQL.
Sintaxis: IFNULL(field, replacement_value);

ISNULL es diferente en MySQL que las otras dos. En lugar de reemplazar un valor, devuelve 1 si el valor es NULL, y 0 si no lo es.
Sintaxis: ISNULL(value);

Finalmente, COALESCE devuelve el primer valor que no es NULL en una lista de expresiones. Si todos los valores listados son NULL, también devuelve NULL. Esto significa que debes proporcionar una lista de valores en el orden en que deseas que se verifiquen.
Sintaxis: COALESCE(value1, value2, value3, value4, value5...);

También existe NULLIF, que compara 2 valores y devuelve NULL si son iguales. Si no lo son, devuelve el primer valor.
Sintaxis: NULLIF(value1, value2);
*/

SELECT address AS 'Dirección', IFNULL(address2, 'Esta dirección no tiene address 2') FROM address; -- Algunas address2 son ''
SELECT address AS 'Dirección', ISNULL(address2) AS '¿Hay alguna fecha de retorno NULL?' FROM address;
SELECT COALESCE(address2, address) AS 'Dirección' FROM address; -- Esto devolverá la dirección si address2 es NULL debido al orden de la sintaxis
SELECT NULLIF(c.first_name, s.first_name) AS 'Nombre del Cliente' -- Devuelve el nombre del cliente si el cliente y el empleado no tienen el mismo nombre
FROM rental r INNER JOIN customer c USING (customer_id) INNER JOIN staff s USING (staff_id);