USE sakila;

-- 1. LIST ALL ACTORS --
SELECT first_name, last_name FROM actor;

-- 2. Find the surname of the actor with the forename 'John' --
SELECT first_name, last_name FROM actor WHERE first_name='John';

-- 3. Find all actors with surname 'Neeson' --
SELECT first_name, last_name FROM actor WHERE last_name='Neeson';

-- 4. Find all actors with ID numbers divisible by 10 --
SELECT first_name, last_name, actor_id FROM actor WHERE actor_id LIKE '%0';

-- 5. What is the description of the movie with an ID of 100? --
SELECT film_id, description FROM film WHERE film_id=100;

-- 6. Find every R-rated movie --
SELECT * FROM film WHERE rating='R';

-- 7. Find every non-R-rated movie --
SELECT * FROM film 	WHERE rating!='R'; 

-- 8. Find the ten shortest movies --
SELECT title, length FROM film ORDER BY length ASC LIMIT 10;

-- 9. Find the movies with the longest runtime, without using LIMIT --
SELECT title, length FROM film WHERE length=(SELECT MAX(length) FROM film);

-- 10. Find all movies that have deleted scenes --
SELECT title, special_features FROM film WHERE special_features='Deleted Scenes';

-- 11. Using HAVING, reverse-alphabetically list the last names that are not repeated --
SELECT last_name FROM actor GROUP BY last_name HAVING COUNT(last_name)=1 ORDER BY last_name DESC;

-- 12. Using HAVING, list the last names that appear more than once, from highest to lowest frequency --
SELECT last_name, COUNT(last_name) AS frequency FROM actor 
GROUP BY last_name 
HAVING COUNT(last_name)>1 
ORDER BY frequency DESC;

-- 13. Which actor has appeared in the most films? --
SELECT count(fa.actor_id), a.first_name, a.last_name
FROM actor a
JOIN film_actor FA on a.actor_id=fa.actor_id
GROUP BY fa.actor_id ORDER BY COUNT(fa.actor_id) DESC;

-- 14. When is 'Academy Dinosaur' due? -- 
select f.title, f.rental_duration, r.rental_date, r.return_date, r.rental_date + interval f.rental_duration day as 'due date'
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id=f.film_id
WHERE r.return_date is null and f.title like 'Academy Dinosaur';

-- 15. What is the average runtime of all films? --
SELECT AVG(length) FROM film;

-- 16. List the average runtime for every film category --
SELECT AVG(f.length), c.name
FROM film f
JOIN film_category fc ON f.film_id=fc.film_id
JOIN category c ON c.category_id=fc.category_id
GROUP BY c.name;

-- 17. List all movies featuring a robot --
SELECT title FROM film WHERE description LIKE '%robot%';

-- 18. How many movies were released in 2010? --
SELECT COUNT(film_id) FROM film WHERE release_year='2010';

-- 19. Find the titles of all the horror movies --
SELECT f.title, c.name 
FROM film f
JOIN film_category fc ON f.film_id=fc.film_id
JOIN category c ON c.category_id=fc.category_id
WHERE name='horror';

-- 20. List the full name of the staff member with the ID of 2 --
SELECT first_name, last_name, staff_id FROM staff where staff_id=2;

-- 21. List all the movies that Fred Costner has appeared in --
SELECT a.first_name, a.last_name, f.title
FROM actor a
JOIN film_actor fa ON a.actor_id=fa.actor_id
JOIN film f ON fa.film_id=f.film_id
WHERE last_name='Costner';

-- 22. How many distinct countries are there? --
SELECT DISTINCT country FROM country;

-- 23. List the name of every language in reverse-alphabetical order --
SELECT name FROM language ORDER BY name DESC;

-- 24. List the full names of every actor whose surname ends with '-son' in alphabetical order by their forename --
SELECT first_name, last_name FROM actor WHERE last_name LIKE '%son' ORDER BY first_name ASC;

-- 25. Which category contains the most films? --
SELECT COUNT(c.name), c.name
FROM film f
JOIN film_category fc ON f.film_id=fc.film_id
JOIN category c ON c.category_id=fc.category_id
GROUP BY c.name ORDER BY COUNT(c.name) DESC LIMIT 1;

