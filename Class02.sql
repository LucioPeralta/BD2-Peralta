drop database imdb;
CREATE DATABASE IF NOT EXISTS imdb;

USE imdb;

CREATE TABLE IF NOT EXISTS film (
  film_id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  release_year INT
);

CREATE TABLE IF NOT EXISTS actor (
  actor_id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS film_actor (
  actor_id INT,
  film_id INT,
  PRIMARY KEY (actor_id, film_id),
  FOREIGN KEY (actor_id) REFERENCES actor(actor_id),
  FOREIGN KEY (film_id) REFERENCES film(film_id)
);

-- Insertar actores
INSERT INTO actor (first_name, last_name) VALUES 
('Johnny', 'Depp'),
('Tom', 'Hanks'),
('Angelina', 'Jolie');

-- Insertar películas
INSERT INTO film (title, description, release_year) VALUES
('Pirates of the Caribbean', 'Serie de películas de aventuras', 2003),
('Forrest Gump', 'Película dramática', 1994),
('Maleficent', 'Película de fantasía', 2014);

-- Insertar relaciones entre películas y actores
INSERT INTO film_actor (actor_id, film_id) VALUES
(1, 1), -- Johnny Depp en Piratas del Caribe
(2, 2), -- Tom Hanks en Forrest Gump
(3, 3); -- Angelina Jolie en Maleficent

-- Agregar columna last_update a la tabla de películas
ALTER TABLE film
ADD COLUMN last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

-- Agregar columna last_update a la tabla de actores
ALTER TABLE actor
ADD COLUMN last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
