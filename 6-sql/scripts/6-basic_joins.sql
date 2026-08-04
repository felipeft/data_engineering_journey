-- Joins (basic)


-- NO JOIN: Returns data from tables without combining them

-- TASK: retieve all data form customers and orders in two different results
SELECT *
FROM customers;


SELECT *
FROM orders;


-- INNER JOIN: Returns only matching rows from both tables

-- TASK: Get all customers along with their orders, but only for customers who have placed an order
SELECT
    c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM customers AS c
INNER JOIN orders AS o
ON c.id = o.customer_id


-- LEFT JOIN: returns all rows from left and only matching from right

-- TASK: Get all customers along with their orders, including those without orders;
SELECT *
FROM customers as c
LEFT JOIN orders as o
ON c.id = o.customer_id;

-- Inverts...
SELECT *
FROM orders as o
LEFT JOIN customers as c

ON c.id = o.customer_id 


-- RIGHT JOIN: Returns all rows from Right and only matching from Left

-- TASK: Get all customers along with their orders, "including orders without matching customers"
SELECT
 c.id,
 c.first_name,
 o.order_id,
 o.sales
FROM customers AS c
RIGHT JOIN orders AS o
ON c.id = o.customer_id;


-- CHALLENGE: solve the same task using LEFT JOIN

-- TASK: Get all customers along with their orders, "including orders without matching customers"
SELECT
 c.id,
 c.first_name,
 o.order_id,
 o.sales
FROM orders AS o
LEFT JOIN customers AS c
ON c.id = o.customer_id


-- FULL JOIN: Returns all rows from both tables
-- EVERYTHING!!!!

-- TASK: Get all customers and all orders, even if there's no match
SELECT *
FROM customers AS c
FULL JOIN orders AS o
ON c.id = o.customer_id;


SELECT *
FROM orders AS o
FULL JOIN customers AS c
ON c.id = o.customer_id 
