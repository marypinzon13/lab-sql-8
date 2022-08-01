/*
Write a query to display for each store its store ID, city, and country.
Write a query to display how much business, in dollars, each store brought in.
Which film categories are longest?
Display the most frequently rented movies in descending order.
List the top five genres in gross revenue in descending order.
Is "Academy Dinosaur" available for rent from Store 1?
Get all pairs of actors that worked together.
Get all pairs of customers that have rented the same film more than 3 times.
For each film, list actor that has acted in more films.
*/

-- Write a query to display for each store its store ID, city, and country.

SELECT * FROM sakila.store;
SELECT * FROM sakila.address;
SELECT * FROM sakila.city;
SELECT * FROM sakila.country;


SELECT s.store_id, c.city, co.country
FROM sakila.store as s
INNER JOIN sakila.address as a
ON s.address_id = a.address_id
INNER JOIN sakila.city as c
ON a.city_id = c.city_id
INNER JOIN sakila.country as co
ON c.country_id = co.country_id;

-- Write a query to display how much business, in dollars, each store brought in.
SELECT * FROM sakila.payment;
SELECT * FROM sakila.store;
SELECT * FROM sakila.staff;

SELECT st.store_id, SUM(p.amount) as business
FROM sakila.store as st
INNER JOIN sakila.staff as s
ON st.store_id = s.store_id
INNER JOIN sakila.payment as p
ON s.staff_id = p.staff_id
GROUP BY  s.staff_id;

-- Which film categories are longest?
SELECT * FROM  sakila.category;
SELECT * FROM sakila.film_category;
SELECT * FROM sakila.film;

SELECT ca.name, SUM(f.length) as longest
FROM sakila.category as ca
INNER JOIN sakila.film_category as fc
ON ca.category_id = fc.category_id
INNER JOIN sakila.film as f
ON fc.film_id = f.film_id
WHERE f.length > 180
GROUP BY ca.name
ORDER BY SUM(f.length) DESC;

-- Display the most frequently rented movies in descending order.
SELECT * FROM sakila.rental;
SELECT * FROM sakila.inventory;
SELECT * FROM sakila.film;


SELECT  r.rental_id, f.title as title, f.rental_duration, COUNT(r.rental_date)
FROM sakila.rental as r
INNER JOIN sakila.inventory as i
ON r.inventory_id = i.inventory_id
INNER JOIN sakila.film as f
ON i.film_id = f.film_id
GROUP BY  title
ORDER BY COUNT(r.rental_date) DESC;

/*


Get all pairs of actors that worked together.
Get all pairs of customers that have rented the same film more than 3 times
*/

-- List the top five genres in gross revenue in descending order.
SELECT * FROM sakila.film_category;
SELECT * FROM sakila.film;
SELECT * FROM sakila.inventory;
SELECT * FROM sakila.rental;
SELECT * FROM sakila.payment;



SELECT  fi.title  as title,  SUM(pa.amount) as amount
FROM sakila.film_category as ca
INNER JOIN sakila.film as fi
ON ca.film_id = fi.film_id
INNER JOIN sakila.inventory as inv
ON fi.film_id = inv.film_id
INNER JOIN sakila.rental as re
ON inv.inventory_id = re.inventory_id
INNER JOIN sakila.payment as pa
ON re.rental_id = pa.rental_id
GROUP BY title
ORDER BY amount DESC
LIMIT 5;


-- Is "Academy Dinosaur" available for rent from Store 1?
SELECT * FROM sakila.film;
SELECT * FROM sakila.inventory;
SELECT * FROM sakila.rental;
SELECT * FROM sakila.store;


SELECT fi.title as title, re.rental_id, re.rental_date, re.return_date
FROM sakila.film as fi
INNER JOIN sakila.inventory as inv
ON fi.film_id = inv.film_id
INNER JOIN sakila.rental as re
ON inv.inventory_id = re.inventory_id
INNER JOIN  sakila.store as st
ON inv.store_id = st.store_id
WHERE st.store_id = 1 and title = 'Academy Dinosaur';

-- Get all pairs of actors that worked together.
SELECT * FROM sakila.actor;
SELECT * FROM  sakila.film_actor;
SELECT * FROM sakila.film;


SELECT ac.actor_id, ac.first_name as name, COUNT(fa.film_id) as film, fi.title 
FROM sakila.actor as ac
INNER JOIN sakila.film_actor as fa
ON ac.actor_id = fa.actor_id
INNER JOIN sakila.film as fi
ON fa.film_id = fi.film_id
GROUP BY fi.title; 

-- i am trying to resolve the question but the query does not work properly.

-- Get all pairs of customers that have rented the same film more than 3 times

SELECT * FROM sakila.customer;
SELECT * FROM  sakila.rental;
SELECT * FROM  sakila.inventory;



SELECT DISTINT(cu.customer_id), re.rental_id, inv.inventory_id
FROM sakila.customer as cu
INNER JOIN  sakila.rental as re
ON cu.customer_id = re.customer_id
INNER JOIN sakila.inventory as inv
ON re.inventory_id = inv.inventory_id
WHERE cu.active = 1;

-- i am trying to resolve the question but the query does not work properly.