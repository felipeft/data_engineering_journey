-- Advanced SQL Techniques

-- SUBQUERIES
-- A query inside a query

-- Three categories:
-- 1. Dependancy
-- 2. Result type
-- 3. Location | clauses


-- Result Type

-- Scalar subquerie = single value
-- EX:
SELECT
	AVG(Score)			-- single value
FROM Sales.Customers

-- Row subquerie = multiple rows + single column
-- EX:
SELECT
	CustomerID
FROM Sales.Orders

-- Table subquerie = Multiple rows + multiple columns
-- EX:
SELECT 
	OrderID,
	OrderDate
FROM Sales.Orders


-- Location | clauses
-- FROM Subquery: used as a temporary table for the main query
-- TASK: Find the products that have a price higher than the average price of all products
-- Main query
SELECT *
FROM
	-- Subquery
	(SELECT
		ProductID,
		Price,
		AVG(Price) OVER() AvgPrice
	FROM Sales.Products
	)t
WHERE Price > t.AvgPrice 

-- TASK: Rank customers based on their total amount of sales
-- Main query
SELECT 
	*,
	RANK() OVER(ORDER BY TotalSales DESC) CustomerRank
FROM
-- subquery
	(SELECT
		CustomerID,
		SUM(Sales) totalSales
	FROM Sales.Orders
	GROUP BY CustomerID)t


-- SELECT Subquery
-- Used to aggregate data side by side with the main query's data, allowing for direct comparison
-- RULE: Only Scalar subqueries are allowed to be used
	
-- TASK: Show the product IDs, names, prices and total number of orders
-- Main query
SELECT
	ProductID,
	Product,
	Price,
	-- Subquery
	(SELECT COUNT(*) totalOrders FROM Sales.Orders) As totalOrders
FROM Sales.Products;

-- Subquery in JOIN Clause
-- Used to prepare the data (filtering or aggregation) before joining with other tables

-- TASK: Show all customer details and find the total orders for each customer

-- Main Query
SELECT
	c.*,
	o.TotalOrders
FROM Sales.Customers c
LEFT JOIN
	(SELECT
		CustomerID,
		COUNT(*) TotalOrders
	FROM Sales.Orders
	GROUP BY CustomerID) o
ON c.CustomerID = o.CustomerID
	
	
	
	
	
	
	
	
	
	
	
	
	
	






