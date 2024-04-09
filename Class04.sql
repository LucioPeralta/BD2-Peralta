-- Utilizar la base de datos sakila
USE sakila;

-- Mostrar título y características especiales de películas clasificadas PG-13
SELECT title, special_features FROM film
WHERE rating = 'PG-13';

-- Obtener una lista de todas las duraciones de las películas diferentes
SELECT DISTINCT length FROM film;

-- Mostrar título, tarifa de alquiler y costo de reposición de películas con un costo de reposición de 20.00 a 24.00
SELECT title, rental_rate, replacement_cost FROM film 
WHERE replacement_cost BETWEEN 20.00 AND 24.00;

-- Mostrar título, categoría y clasificación de películas que tienen 'Behind the Scenes' como características especiales
SELECT f.title, c.name, f.rating FROM film_category AS f_c
INNER JOIN film AS f ON f.film_id = f_c.film_id
INNER JOIN category AS c ON c.category_id = f_c.category_id
WHERE f.special_features LIKE '%Behind the Scenes%';

-- Mostrar nombre y apellido de actores que actuaron en 'ZOOLANDER FICTION'
SELECT a.first_name, a.last_name FROM film_actor AS f_a
INNER JOIN actor AS a ON a.actor_id = f_a.actor_id
INNER JOIN film AS f ON f.film_id = f_a.film_id
WHERE f.title = 'ZOOLANDER FICTION';

-- Mostrar dirección, ciudad y país de la tienda con id 1
SELECT a.address, ci.city, co.country FROM store AS s
INNER JOIN address AS a ON a.address_id = s.address_id
INNER JOIN city AS ci ON ci.city_id = a.city_id
INNER JOIN country AS co ON co.country_id = ci.country_id
WHERE s.store_id = 1;

-- Mostrar par de títulos de películas y clasificación de películas que tienen la misma clasificación
SELECT f1.title, f2.title, f1.rating FROM film AS f1, film AS f2 
WHERE f1.rating = f2.rating;

-- Obtener todas las películas disponibles en la tienda con id 2 y el nombre y apellido del gerente de esta tienda (el gerente aparecerá en todas las filas)
SELECT f.title, sta.first_name, sta.last_name FROM inventory AS i
INNER JOIN store AS s ON s.store_id = i.store_id
INNER JOIN staff AS sta ON sta.staff_id = s.manager_staff_id
INNER JOIN film AS f ON f.film_id = i.film_id
WHERE s.store_id = 2;
