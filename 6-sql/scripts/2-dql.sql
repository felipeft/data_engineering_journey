SELECT *

FROM customers


-- GROUP BY is like a smash
-- Find the total score fort each country


SELECT 
	country as costumer_country,
	sum(score) AS Total_score		-- AS (ALIAS (call this))
FROM customers
GROUP BY country



-- Find the total score and total number of customers for each country

SELECT 
	country,
	sum(score) as Total_score,
	count(id) as total_customers
FROM customers
GROUP BY country 


-- HAVING (filter agregated data)
-- can be used only with GROUP BY


-- Find the average score for each country
-- considering only costumers with a score not equal to 0
-- and return only those countries with
-- an average score greater than 430

SELECT 
	country,
	AVG(score) as avg_score
FROM customers
WHERE score != 0
GROUP BY country
HAVING AVG(score) > 430



-- Distinct (remove duplicates)
-- each value appears only once

-- Return unique list of all countries

SELECT DISTINCT country
FROM customers
	
-- uses only if has real duplicates to dont spent more computing power


-- TOP - limit your data
-- restrict the number of rows returned

-- retrieve only 3 costumers

SELECT TOP 3 *
FROM customers

-- Retrieve the top 3 customers with the highest scores

SELECT TOP 3 *
FROM customers
ORDER BY score DESC

-- Retrieve the lowest 2 customers based on the score


SELECT TOP 2*
FROM customers
ORDER BY score 


-- Get the two most recent orders

SELECT TOP 2 *
FROM orders
ORDER BY order_date DESC




-- multi queries

SELECT *
FROM customers


SELECT * 
FROM orders



-- Static numbers

SELECT 123 as static_number


SELECT 'hello' as static_string

SELECT 
	id,
	first_name,
	'new customer' as Customer_type
FROM customers


-- only for view and organized your queries
