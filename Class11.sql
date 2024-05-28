use sakila;

-- Find all the film titles that are not in the inventory.

select * from film as f
LEFT OUTER JOIN inventory as i using (film_id)
where i.inventory_id is null;

-- Find all the films that are in the inventory but were never rented.

SELECT f.title, i.inventory_id
FROM inventory i
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE r.rental_id IS NULL;

-- Generate a report with:

SELECT 
    c.first_name, c.last_name, s.store_id, f.title, 
    r.rental_date, r.return_date
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN store s ON c.store_id = s.store_id
ORDER BY s.store_id, c.last_name;

-- Show sales per store (money of rented films)

SELECT 
    CONCAT(city.city, ', ', country.country) AS location, 
    CONCAT(manager.first_name, ' ', manager.last_name) AS manager_name,
    SUM(payment.amount) AS total_sales
FROM store
JOIN address ON store.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id
JOIN staff AS manager ON store.manager_staff_id = manager.staff_id
JOIN inventory ON store.store_id = inventory.store_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY store.store_id, location, manager_name;


-- Which actor has appeared in the most films?

SELECT 
    a.first_name, a.last_name, COUNT(*) AS film_count
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY film_count DESC
LIMIT 1;
