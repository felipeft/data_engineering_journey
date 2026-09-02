-- Aggregate Functions  
-- COUNT(*)
-- SUM()
-- AVG()
-- MAX()
-- MIN()

-- TASK: Find the total number of orders
SELECT 
	COUNT(*) AS Total_nr_Orders
FROM orders

-- TASK: Find the total sales of all orders
SELECT 
	COUNT(*) AS Total_nr_Orders,
	SUM(sales) AS total_sales
FROM orders

-- TASK: Find the average sales of all orders
SELECT 
	COUNT(*) AS Total_nr_Orders,
	SUM(sales) AS total_sales,
	AVG(sales) as Avg_sales
FROM orders

-- TASK: Find the highest sales of all orders
SELECT 
	COUNT(*) AS Total_nr_Orders,
	SUM(sales) AS total_sales,
	AVG(sales) as Avg_sales,
	MAX(sales) as highest_sales
FROM orders

-- TASK: Find the lowest sales of all orders
SELECT 
	COUNT(*) AS Total_nr_Orders,
	SUM(sales) AS total_sales,
	AVG(sales) as Avg_sales,
	MAX(sales) as highest_sales,
	MIN(sales) AS lowest_sales
FROM orders

-- you can combine aggregate functions with group by and use little numbers to this
SELECT 
	customer_id,
	COUNT(*) AS Total_nr_Orders,
	SUM(sales) AS total_sales,
	AVG(sales) as Avg_sales,
	MAX(sales) as highest_sales,
	MIN(sales) AS lowest_sales
FROM orders
GROUP BY customer_id


-- TASK: Analyze the scores in customers table
SELECT
	COUNT(*) AS total_nr_Scores,
	SUM(score) AS sum_of_scores,
	AVG(score) AS avg_scores,
	MAX(score) AS Highest_score,
	MIN(score) AS Lowest_score
FROM customers;


-- by each country (plus)
SELECT
	country,
	COUNT(*) AS total_nr_Scores,
	SUM(score) AS sum_of_scores,
	AVG(score) AS avg_scores,
	MAX(score) AS Highest_score,
	MIN(score) AS Lowest_score
FROM customers
GROUP BY country;






