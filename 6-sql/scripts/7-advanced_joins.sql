-- ADVANCED JOINS


-- LEFT ANTI JOIN: Returns row from left that has no match in right

-- TASK: Get all customers who haven't placed any order
SELECT *
FROM customers AS  c
LEFT JOIN orders AS o
ON c.id = o.customer_id 
WHERE o.customer_id IS NULL


-- RIGHT ANTI JOIN: Returns row from right that has no match in left

-- TASK: Get all orders without matching customers
SELECT *
FROM customers AS  c
RIGHT JOIN orders AS o
ON c.id = o.customer_id 
WHERE c.id IS NULL

-- CHALLENGE: Solve the same task using left join
-- TASK: Get all orders without matching customers
SELECT *
FROM orders AS  o
LEFT JOIN customers AS c
ON o.customer_id = c.id 
WHERE c.id IS NULL


-- FULL ANTI JOIN: Returns only rows that don´t match in either tables
-- Only unmatching data (opossite)
-- The order of tables doesn´t matter

-- TASK: Find customers without orders and orders without customers
SELECT *
FROM customers AS c 
FULL JOIN orders AS o
ON c.id = o.customer_id 
WHERE 
	c.id IS NULL
	OR   
	o.customer_id IS NULL

	
	
-- CHALLENGE: Get all customers along with their orders, but only for customers who have placed an order
SELECT *
FROM customers AS c
INNER JOIN orders AS o
ON c.id = o.customer_id 

-- Now without using INNER JOIN
SELECT *
FROM customers AS c
FULL JOIN orders AS o
ON c.id = o.customer_id 
WHERE
	o.customer_id IS NOT NULL
	AND
	c.id IS NOT NULL
	
-- Possibility with LEFT JOIN
SELECT *
FROM customers AS c
LEFT JOIN orders AS o
ON c.id = o.customer_id 
WHERE
	o.customer_id IS NOT NULL
	

-- CROSS JOIN: Combines every row from left with every row from right
-- all possible combinations - cartesian join
	
-- TASK: Generate all possible combinations of customers and orders
SELECT *
FROM customers
CROSS JOIN orders
	
	
	
	









