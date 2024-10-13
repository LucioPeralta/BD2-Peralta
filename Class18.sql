USE sakila;

-- Query 1
/*
#DROP PROCEDURE get_customers_country;
DELIMITER //

CREATE FUNCTION get_copias_peliculas(identificador_pelicula VARCHAR(255), store_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE cuenta_copias INT;
    
    IF identificador_pelicula REGEXP '^[0-9]+$' THEN
		SELECT COUNT(*) INTO cuenta_copias FROM inventory WHERE film_id = identificador_pelicula AND store_id = store_id;
    ELSE
		SELECT COUNT(*) INTO cuenta_copias FROM inventory i INNER JOIN film f ON f.film_id = i.film_id WHERE f.title = identificador_pelicula
        AND i.store_id = store_id;
	END IF;
    RETURN cuenta_copias;
END //
DELIMITER ;

select get_copias_peliculas('ACADEMY DINOSAUR', 1);
select get_copias_peliculas('1', 1);
*/
-- Query 2
/*
#DROP PROCEDURE get_customers_country;
DELIMITER //

CREATE PROCEDURE get_customers_country(IN country_name VARCHAR(50), OUT customer_list TEXT)
BEGIN
	DECLARE done INT default 0;
    DECLARE first_name VARCHAR(50);
    DECLARE last_name VARCHAR(50);
    DECLARE temp_list TEXT DEFAULT '';
    DECLARE cur CURSOR FOR
		SELECT c.first_name, c.last_name FROM customer c
        INNER JOIN address a ON c.address_id = a.address_id
        INNER JOIN city ci ON a.city_id = ci.city_id
        INNER JOIN country co ON ci.country_id = co.country_id
        WHERE co.country = country_name;
        
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    OPEN cur;
    
    fetch_loop: LOOP
		FETCH cur INTO first_name, last_name;
        IF done THEN LEAVE fetch_loop;
        END IF;
        
        SET temp_list = CONCAT(temp_list, first_name, ' ', last_name, '; ');
	END LOOP;
    CLOSE cur;
    
    SET customer_list = TRIM(TRAILING '; ' FROM temp_list);
END //

DELIMITER ;

CALL get_customers_country('Canada', @customer_list);
SELECT @customer_list;
*/

-- Query 3

/*
La función `inventory_in_stock` está diseñada para verificar si un artículo específico del inventario de la tienda está disponible (en stock).
Funciona de la siguiente manera: se pasa un `inventory_id` como parámetro. Primero, se verifica si hay alquileres activos para ese artículo, contando las filas en la tabla `rental` 
que coinciden con el `inventory_id` dado. Si no se encuentran alquileres, la función devuelve `TRUE`, indicando que el artículo está en stock. Si existen alquileres, la función 
comprueba si alguno de ellos tiene un `return_date` que aún sea `NULL`, lo que indica que el artículo sigue alquilado. Si todos los alquileres han sido devueltos (sin fechas nulas), 
la función devuelve `TRUE`. De lo contrario, devuelve `FALSE`, indicando que el artículo aún está alquilado.

El procedimiento `film_in_stock` tiene un propósito similar, pero en lugar de verificar un solo artículo, devuelve el número total de copias disponibles de una película específica 
en una tienda. Toma dos parámetros: `p_film_id` y `p_store_id`. Primero, obtiene los `inventory_id` de los artículos que coinciden con el `film_id` y `store_id` dados y que están 
disponibles para alquiler. La disponibilidad se verifica usando la función `inventory_in_stock`. Luego, cuenta cuántas copias de la película están disponibles y guarda el resultado 
en la variable `p_film_count`, indicando cuántas copias de la película están en stock en esa tienda.
*/