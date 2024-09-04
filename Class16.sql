USE sakila;

CREATE TABLE `employees` (
  `employeeNumber` int(15) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `firstName` varchar(50) NOT NULL,
  `extension` varchar(10) NOT NULL,
  `email` varchar(100) NOT NULL,
  `officeCode` varchar(10) NOT NULL,
  `reportsTo` int(15) DEFAULT NULL,
  `jobTitle` varchar(50) NOT NULL,
  PRIMARY KEY (`employeeNumber`)
);

INSERT INTO `employees`(`employeeNumber`,`lastName`,`firstName`,`extension`,`email`,`officeCode`,`reportsTo`,`jobTitle`) VALUES 
(2023,'González','Carlos','x1234','cgonzalez@empresa.com','1',NULL,'President'),
(8982,'Martínez','Lucía','x5678','lmartinez@empresa.com','1',2023,'VP Sales'),
(1822,'Rodríguez','Juan','x9101','jrodriguez@empresa.com','1',2023,'VP Marketing');

-- QUERY 1

INSERT INTO `employees`(`employeeNumber`,`lastName`,`firstName`,`extension`,`email`,`officeCode`,`reportsTo`,`jobTitle`) VALUES
(9999,'Lucio','Peralta','x0878',NULL,'1','0002','RH Manager');

/*
Esta consulta devuelve la siguiente respuesta: Error Code: 1048. Column 'email' cannot be null.
Esto se debe a que, al crear la tabla employees, se agregó una restricción NOT NULL al campo email para evitar que se inserten valores nulos.
Al intentar realizar la inserción, se lanza el error mencionado y los valores no son insertados.
*/

-- QUERY 2

UPDATE employees SET employeeNumber = employeeNumber - 20;
UPDATE employees SET employeeNumber = employeeNumber + 20;

/*
Al ejecutar la primera consulta, cada instancia de employeeNumber en employees se reduce en 20. Por ejemplo, los valores de los empleados insertados eran (1002, 1056, 1076)
y se convirtieron en (982, 1036, 1056) después de la consulta.
Al ejecutar la segunda consulta, se lanza el siguiente error: Error Code: 1062. Duplicate entry '1056' for key 'employees.PRIMARY'.
Esto se debe a que cada employeeNumber se incrementa en el orden en que fueron declarados, y la segunda instancia de empleado se establece en 1056, que ya existe, antes de que el 
employeeNumber existente con ese valor sea incrementado. Como no puede haber dos valores de clave primaria iguales, se lanza el error anterior.
*/

-- QUERY 3

ALTER TABLE employees ADD COLUMN age INT(3) CHECK (age >= 16 AND age <= 70);

-- QUERY 4

/*
Las tablas film y actor existen de manera independiente, cada una con su propio ID (film_id y actor_id respectivamente).
Dado que una película puede tener múltiples actores y un actor puede estar en múltiples películas, se debe establecer una relación de muchos a muchos para conectarlos, 
pero esto no es recomendable debido a su complejidad.

En su lugar, se crea una tabla de detalle (conocida como tabla de unión) para conectarlos, que en este caso es la tabla film_actor.
La tabla film_actor utiliza dos claves foráneas: una que hace referencia a film_id de la tabla film y otra que hace referencia a actor_id de la tabla actor.
Estas claves foráneas deben hacer referencia a un registro existente y válido en sus respectivas tablas. Ambas claves juntas forman una clave primaria compuesta, 
lo que asegura que cada entrada en film_actor sea única.

La restricción ON DELETE RESTRICT en ambas claves foráneas evita que se eliminen películas y actores si existe una entrada en film_actor que los referencie, 
mientras que ON UPDATE CASCADE significa que cualquier actualización realizada en la película o actor referenciado también se aplica a film_actor.
*/

-- QUERY 5

ALTER TABLE employees ADD COLUMN lastUpdate DATETIME, ADD COLUMN lastMySqlUser VARCHAR(100);
CREATE TRIGGER before_employees_update BEFORE UPDATE ON employees FOR EACH ROW SET NEW.lastUpdate = NOW(), NEW.lastMySqlUser = USER();

-- QUERY 6

/*
film_text tiene 3 triggers relacionados con su carga:

CREATE TRIGGER `ins_film` AFTER INSERT ON `film` FOR EACH ROW BEGIN
    INSERT INTO film_text (film_id, title, description)
        VALUES (new.film_id, new.title, new.description);
  END;;
  
Este trigger realiza una inserción en la tabla film_text después de que se crea una película, tomando los valores de la película recién creada para sus campos. 
Esto significa que después de que se inserte una película, los valores de su film_id, title y description también se usarán para crear una inserción en film_text.


CREATE TRIGGER `upd_film` AFTER UPDATE ON `film` FOR EACH ROW BEGIN
    IF (old.title != new.title) OR (old.description != new.description) OR (old.film_id != new.film_id)
    THEN
        UPDATE film_text
            SET title=new.title,
                description=new.description,
                film_id=new.film_id
        WHERE film_id=old.film_id;
    END IF;
  END;;
  
Este trigger es muy similar al anterior, excepto que funciona después de que se actualiza una película en lugar de insertarse. 
Si se modifica el title, description o film_id de una película, el film_text correspondiente cuyo film_id coincidía con la película cambiada también recibirá estas modificaciones.


CREATE TRIGGER `del_film` AFTER DELETE ON `film` FOR EACH ROW BEGIN
    DELETE FROM film_text WHERE film_id = old.film_id;
  END;;
  
El trigger final sigue una lógica similar a las dos anteriores. Después de que se elimina una película, el film_text que coincidía con el film_id de la película también se eliminará.

Estos triggers están hechos para crear un film_text cada vez que se inserta una película, utilizando sus valores. 
Siempre que se actualice o elimine una película, se aplica el mismo tratamiento a su correspondiente film_text.
*/