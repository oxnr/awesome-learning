SELECT * FROM movies WHERE year IS NOT NULL ORDER BY year;

select * FROM actors WHERE name like "Tom%";

select * FROM actors ORDER BY name DESC;

SELECT * FROM actors LIMIT 100, 100;

USE movie_db_1;

-- Table and Schema defintion (DDL)

CREATE SCHEMA IF NOT EXISTS movie_db_1;

CREATE TABLE actors (name VARCHAR(50) NOT NULL);

CREATE TABLE movies (title VARCHAR(200) NOT NULL, year INTEGER);

SHOW ENGINES;

CREATE TABLE products (name VARCHAR(100), description TEXT, stock_count INTEGER);

INSERT INTO movies VALUES ("Back to the future", 1985);

SET SQL_SAFE_UPDATES = 1;

Update movies SET year=2016, title="Avatar Reloaded" WHERE title="Avatar 2";

DELETE FROM movies WHERE title ="Avatar Reloaded" AND year=2016;

INSERT INTO movies (title, year) VALUES ("Aliens", 1986);

UPDATE movies SET year=1979 WHERE title="Alien";

DELETE FROM movies WHERE year = "1985";

RENAME TABLE actors_table TO actor_table;

DROP TABLE IF EXISTS products;

TRUNCATE TABLE movie_table;

ALTER TABLE movie_table ADD COLUMN genre VARCHAR(100);

ALTER TABLE actor_table CHANGE COLUMN pob place_of_birth VARCHAR(100);
ALTER TABLE actor_table CHANGE COLUMN dob date_of_birth DATE;
ALTER TABLE movie_table CHANGE COLUMN year year_releasd YEAR;

DROP DATABASE IF EXISTS movie_db_3;

USE treehouse_movie_db;

-- CRUD operators (DML)

CREATE TABLE genres (id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY, name VARCHAR(30) NOT NULL UNIQUE KEY);

INSERT INTO genres (name) VALUES ("Musical");

SELECT movies.title, genres.name AS genre_name FROM movies LEFT OUTER JOIN genres ON movies.genre_id = genres.id WHERE name IS NOT NULL;

ALTER TABLE movies ADD COLUMN genre_id INTEGER NULL, ADD CONSTRAINT FOREIGN KEY (genre_id) REFERENCES genres(id);

UPDATE movies SET genre_id = 1 where id = 8 OR id = 9;

-- Math operations

SELECT title, MIN(score) AS minimum_score,
	MAX(score) AS maximum_score,
	IFNULL(AVG(score),0) AS average
FROM movies LEFT OUTER JOIN reviews
ON movies.id = reviews.movie_id
WHERE year_released > 2000
GROUP BY movie_id HAVING average > 3;

-- Concat Strings

SELECT CONCAT(first_name," ",UPPER(last_name)) AS full_name,
	SUBSTRING(LOWER(email),1,10) AS partial_email, LENGTH(username) AS username_length
FROM users
HAVING username_length < 19;

-- Explain Query

EXPLAIN SELECT * FROM users WHERE last_name="Chalkley";

-- Working with Index

CREATE INDEX last_name_idx ON users(last_name);

SELECT * FROM users WHERE last_name="Chalkley";
EXPLAIN SELECT * FROM users WHERE last_name="Chalkley";

INSERT INTO users (username, email, first_name, last_name) VALUES ("henry", "henry@email.com", "Henry", "Chalkley");

SELECT * FROM users WHERE first_name = "Andrew" AND last_name="Chalkley";

-- Create User1 - read access

GRANT SELECT
ON treehouse_movie_db.*
TO user1@'%'
IDENTIFIED BY 'password';

FLUSH PRIVILEGES;

-- Create User2 - CRUD (DML) access

GRANT SELECT, INSERT, UPDATE, DELETE
ON treehouse_movie_db.*
TO user2@'%'
IDENTIFIED BY 'password';

FLUSH PRIVILEGES;

-- Create User3 - DDL access

GRANT ALTER, CREATE, DROP
ON treehouse_movie_db.*
TO user3@'%'
IDENTIFIED BY 'password';

FLUSH PRIVILEGES;

