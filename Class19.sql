USE sakila;

-- QUERY 1
CREATE USER 'data_analyst'@'localhost' IDENTIFIED BY 'password';
CREATE USER 'data_analyst'@'%' IDENTIFIED BY 'password';

-- QUERY 2
GRANT SELECT, UPDATE, DELETE ON sakila.* TO 'data_analyst'@'localhost';
SHOW GRANTS FOR data_analyst;

-- QUERY 3
CREATE TABLE neighborhood (
  neighborhood_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  neighborhood VARCHAR(50) NOT NULL,
  city_id SMALLINT UNSIGNED NOT NULL,
  last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (neighborhood_id),
  KEY idx_fk_city_id (city_id),
  CONSTRAINT `fk_neighborhood_city` FOREIGN KEY (city_id) REFERENCES city (city_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- QUERY 4
SELECT title FROM film WHERE film_id = 371;
UPDATE film SET title='Film Title' WHERE film_id = 371;

/*
Response: 
Query OK, 1 row affected (0,05 sec)
Rows matched: 1  Changed: 1  Warnings: 0
*/

-- QUERY 5
REVOKE UPDATE ON sakila.*  FROM 'data_analyst'@'localhost';
FLUSH PRIVILEGES;

-- QUERY 6
UPDATE film SET title='Film Title' WHERE film_id = 371;

/*
Response: 
ERROR 1142 (42000): UPDATE command denied to user 'data_analyst'@'localhost' for table 'film'
*/
