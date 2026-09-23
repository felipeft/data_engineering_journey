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
	
	
-- WHERE subquery
-- Used for complex filtering logic and makes query more flexible and dynamic
	
-- Divides by:
-- Comparison Operators (=; !=; >; <; >=; <=)
-- Used to filtering data by comparing two values
-- RULE: Only scalar subqueries are allowed to be used
	
-- TASK: Find the products that have a price higher than the average price of all products
-- Main query
SELECT 
	ProductID,
	Price
FROM Sales.Products
WHERE Price > 
-- Subquery
(SELECT AVG(Price) FROM Sales.Products)


-- Logical operators
-- IN operator: Checks wheter a value matches any value from a list

-- TASK: Show the details of orders made by customers in germany
-- Main query
SELECT * 
FROM Sales.Orders
WHERE CustomerID IN
				-- Subquery
				(SELECT 
					CustomerID
				FROM Sales.Customers
				WHERE Country = 'Germany')


-- TASK: Show the details of orders for customers who are not from germany
SELECT * 
FROM Sales.Orders
WHERE CustomerID NOT IN
				-- Subquery
				(SELECT 
					CustomerID
				FROM Sales.Customers
				WHERE Country = 'Germany')	
				
				
				
-- ANY Operator
-- Checks if a value matches ANY value within a list
-- Used to check if a value is true for AT LEAST one of the values in a list

-- TASK: Find female employees whose salaries are greater than the salaries of any male employees
-- Main query
SELECT 
	EmployeeID,
	FirstName,
	Salary
FROM Sales.Employees 
WHERE Gender = 'F' AND Salary > ANY	-- if we use only '<', doesn't work becasuse this is oly for scalar queries
	-- Subquery
	(SELECT 
		Salary
	FROM Sales.Employees
	WHERE Gender = 'M')
	
-- ALL Operator
-- Checks if a value matches ALL values within a list

-- TASK: Find female employees whose salaries are greater than the salaries of all male employees
SELECT 
	EmployeeID,
	FirstName,
	Salary
FROM Sales.Employees 
WHERE Gender = 'F' AND Salary > ALL
	-- Subquery
	(SELECT 
		Salary
	FROM Sales.Employees
	WHERE Gender = 'M')


				
-- Before learning about exist operator...
	
-- Dependancy
	
-- NON-CORELATED SUBQUERY
-- A subquery that can run independtly from the main query

	
-- CORRELATED SUBQUERY
-- A subquery that relays on values from the main query
				
-- TASK: Show all customer datails and find the tota orders of each customer
SELECT
	*,
	(SELECT CustomerID, COUNT(*) FROM Sales.Orders GROUP BY CustomerID) TotalSales
FROM Sales.Customers
-- SQL Error [116] [S0001]: Only one expression can be specified in the select list 
-- when the subquery is not introduced with EXISTS.

-- Solving this using correlated subquery
SELECT
	*,
	(SELECT COUNT(*) FROM Sales.Orders o WHERE o.CustomerID = c.CustomerID) TotalSales
FROM Sales.Customers c

-- Subquery is dependent of the main query in correlated subqueries
-- Executed for each row processd by the main query
-- cant be executed on its own
-- unfortunely, its harder to read and more complex than non correlated subqueries
-- executed multiple times leads to bad perfomance

				
-- Exists Operator
-- Check if a subquery returns any rows
				
-- TASK: Show the order details for customers in germany
-- Main query
SELECT
*
FROM Sales.Orders o 
WHERE EXISTS 
		-- Subquery
			(SELECT
			*
			FROM Sales.Customers c
			WHERE Country = 'Germany'
			AND o.CustomerID = c.CustomerID)
-- Correlated subquery
			
-- NOT EXISTS
SELECT
*
FROM Sales.Orders o 
WHERE NOT EXISTS 
		-- Subquery
			(SELECT
			*
			FROM Sales.Customers c
			WHERE Country = 'Germany'
			AND o.CustomerID = c.CustomerID)
