USE sakila;

-- Query 1: Add a new customer
INSERT INTO customer (store_id, first_name, last_name, email, address_id, create_date) VALUES
(1, 'Lucio', 'Peralta', 'lucio.peralta@gmail.com', 
(SELECT MAX(a.address_id) FROM address a 
INNER JOIN city ci USING (city_id) 
INNER JOIN country co USING (country_id)
WHERE co.country = 'United States'), 
NOW());

-- Query 2: Add a rental
INSERT INTO rental (rental_date, inventory_id, customer_id, return_date, staff_id, last_update) VALUES
(NOW(), 
(SELECT MAX(i.inventory_id) FROM inventory i 
INNER JOIN film f USING (film_id) 
WHERE i.store_id = 2
AND f.title = 'MODEL FISH'), 
(SELECT customer_id FROM customer c
WHERE first_name = 'Lucio' AND last_name = 'Peralta' AND email = 'lucio.peralta@gmail.com'), 
DATE_ADD(NOW(), INTERVAL 1 MONTH), 
(SELECT s.staff_id FROM staff s WHERE s.store_id = 2 ORDER BY RAND() LIMIT 1), 
NOW());

-- Query 3: Update film year based on the rating
UPDATE film SET release_year = 2001 WHERE rating = 'G';
UPDATE film SET release_year = 2005 WHERE rating = 'PG';
UPDATE film SET release_year = 2012 WHERE rating = 'PG-13';
UPDATE film SET release_year = 2017 WHERE rating = 'R';
UPDATE film SET release_year = 2020 WHERE rating = 'NC-17';

-- Query 4: Return a film
UPDATE rental SET return_date = NOW()
WHERE rental_id = (SELECT MAX(rental_id) WHERE rental_date = 
(SELECT MAX(rental_date) WHERE return_date IS null));

-- Query 5: Try to delete a film
DELETE FROM film WHERE film_id = 1000;

DELETE FROM film_actor WHERE film_id = 1000;
DELETE FROM film_category WHERE film_id = 1000;
DELETE FROM rental WHERE inventory_id IN (SELECT inventory_id FROM inventory WHERE film_id = 1000);
DELETE FROM inventory WHERE film_id = 1000;
DELETE FROM film WHERE film_id = 1000;

-- Query 6: Rent a film
SELECT * FROM inventory LEFT JOIN rental USING (inventory_id) WHERE rental_id IS null LIMIT 1;

INSERT INTO rental (rental_date, inventory_id, customer_id, return_date, staff_id, last_update) VALUES
(NOW(), 5, (SELECT customer_id FROM customer ORDER BY RAND() LIMIT 1), DATE_ADD(NOW(), INTERVAL 1 MONTH),
(SELECT staff_id FROM staff WHERE store_id = (SELECT store_id FROM inventory WHERE inventory_id = 5) ORDER BY RAND() LIMIT 1), NOW());

INSERT INTO payment (customer_id, staff_id, rental_id, amount, payment_date, last_update) VALUES
((SELECT customer_id FROM rental WHERE inventory_id = 5), (SELECT staff_id FROM rental WHERE inventory_id = 5), (SELECT rental_id FROM rental WHERE inventory_id = 5),
3.99, DATE_ADD((SELECT rental_date FROM rental WHERE inventory_id = 5), INTERVAL 1 DAY), NOW());

SELECT * FROM rental WHERE inventory_id = 5;
SELECT * FROM payment WHERE rental_id = 16050;
