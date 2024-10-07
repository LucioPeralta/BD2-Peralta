use sakila;

-- QUERY 1
drop view list_of_customers;
CREATE VIEW list_of_customers AS SELECT c.customer_id, c.first_name, c.last_name, a.address, a.postal_code, a.phone, ci.city, co.country, CASE WHEN c.active = 1 THEN 'active' ELSE 'inactive' END AS status, s.store_id FROM customer AS c
INNER JOIN address AS a ON c.address_id = a.address_id
INNER JOIN city AS ci ON a.city_id = ci.city_id
INNER JOIN country AS co ON ci.country_id = co.country_id
INNER JOIN store AS s ON c.store_id = s.store_id
;

-- QUERY 2
drop view film_details;
CREATE VIEW film_details AS 
SELECT f.film_id, f.title, f.description, c.name, f.rental_rate, f.length, f.rating, GROUP_CONCAT(CONCAT(a.first_name, ' ', a.last_name) SEPARATOR ', ') FROM film f
INNER JOIN film_category fc ON f.film_id = fc.film_id
INNER JOIN category c ON fc.category_id = c.category_id
INNER JOIN film_actor fa ON f.film_id = fa.film_id
INNER JOIN actor a ON a.actor_id = fa.actor_id
GROUP BY f.film_id, f.title, f.description, c.name, f.rental_rate, f.length, f.rating;

SELECT *
FROM film_details
LIMIT 10;

-- QUERY 3
drop view sales_by_film_category;
CREATE VIEW sales_by_film_category AS
SELECT c.name, SUM(p.amount) FROM rental r
JOIN inventory i ON i.inventory_id = r.inventory_id
JOIN film f ON f.film_id = i.film_id
JOIN film_category fc ON fc.film_id = f.film_id
JOIN category c ON c.category_id = fc.category_id
JOIN payment p ON p.rental_id = r.rental_id
GROUP BY c.name;

SELECT *
FROM sales_by_film_category
LIMIT 10;

-- QUERY 4
drop view actor_information;
CREATE VIEW actor_information AS
SELECT a.actor_id, a.first_name, a.last_name, COUNT(fa.film_id) FROM film_actor fa
JOIN actor a ON fa.actor_id = a.actor_id
JOIN film f ON fa.film_id = f.film_id
GROUP BY a.actor_id;

SELECT *
FROM actor_information
LIMIT 10;

-- QUERY 5

/*
Vista de actores y películas por categoría:
Esta vista devuelve información de cada actor en la base de datos, junto con las películas en las que ha participado, agrupadas por categoría.
La vista selecciona actor_id, first_name, last_name y un campo llamado film_info, que es una concatenación de las categorías y las películas correspondientes en las que ha actuado cada actor.
Para obtener los datos, se utiliza un LEFT JOIN entre las tablas actor, film_actor, film_category y category, asegurando que se incluyan los actores que no han participado en películas.
La subconsulta que crea film_info usa GROUP_CONCAT para unir las categorías y las películas, ordenadas alfabéticamente, de cada actor.
*/

-- QUERY 6

/*
Vistas materializadas:
Una vista materializada almacena el resultado de una consulta como una tabla física en disco, a diferencia de las vistas normales, que se actualizan dinámicamente. 
Esto mejora el rendimiento para consultas complejas que no requieren actualizaciones frecuentes, ya que evita recalcular los datos cada vez que se accede a la vista. 
Sin embargo, los datos pueden quedar desactualizados si no se refrescan manualmente.
Las vistas materializadas son útiles para tablas que realizan operaciones pesadas (como joins, agregaciones y filtros) que no necesitan actualizarse en tiempo real.
Alternativas incluyen vistas regulares, que se actualizan automáticamente pero pueden reducir el rendimiento, y los índices, que almacenan columnas específicas en RAM, 
pero tienen limitaciones y disminuyen el rendimiento si se usan muchos.
DBMS que soportan vistas materializadas incluyen Oracle, PostgreSQL, Snowflake, y BigQuery. MySQL no las soporta nativamente, pero pueden simularse con vistas regulares y triggers.
*/