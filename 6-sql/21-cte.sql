-- CTE (Common Table Expression)
-- Temporary, named result set (virtual table), that can be used to multiple
-- times within your query to simplify and organize complex query

-- Standalone CTE
-- Defined and used independently
-- Runs independently and its self-contained and doesn't rely on other CTEs or queries

-- TASK: Find the total sales per customer

-- Without CTE
SELECT 
	CustomerID,
	SUM(Sales) AS TotalSales
FROM Sales.Orders
GROUP BY CustomerID

-- Using CTE
-- Step 1: Find the total Sales per Customer
WITH CTE_Total_Sales AS
(
SELECT 
	CustomerID,
	SUM(Sales) AS TotalSales
FROM Sales.Orders
GROUP BY CustomerID
)
-- Main query
SELECT
	c.CustomerID,
	c.FirstName,
	c.LastName,
	cts.TotalSales
FROM Sales.Customers c
LEFT JOIN CTE_Total_Sales cts
ON cts.CustomerID = c.CustomerID 


-- you can use everything in cte like window functions, agreggate, but...
-- you cannot use order by directly within the cte
WITH CTE_Total_Sales AS
(
SELECT 
	CustomerID,
	SUM(Sales) AS TotalSales
FROM Sales.Orders
GROUP BY CustomerID
ORDER BY CustomerID
)
-- Main query
SELECT
	c.CustomerID,
	c.FirstName,
	c.LastName,
	cts.TotalSales
FROM Sales.Customers c
LEFT JOIN CTE_Total_Sales cts
ON cts.CustomerID = c.CustomerID 

--SQL Error [1033] [S0001]: The ORDER BY clause is invalid in views, inline functions, derived tables, subqueries, and common table expressions, unless TOP, OFFSET or FOR XML is also specified.


-- Multiple Standalone CTE
-- TASK:
-- #1 step: Find the total sales per customer
-- #2 step: Find the last order date per customer

-- #1
WITH CTE_total_sales AS
(
SELECT 
	CustomerID,
	SUM(Sales) as TotalSales
FROM Sales.Orders
GROUP BY CustomerID
)
-- #2
,CTE_Last_date AS
(
SELECT 
	CustomerID,
	MAX(OrderDate) LastOrderDate
FROM Sales.Orders
GROUP BY CustomerID
)
-- Main query
SELECT
	c.CustomerID,
	c.FirstName,
	c.LastName,
	cts.TotalSales,
	cld.LastOrderDate 
FROM Sales.Customers c
lEFT JOIN CTE_total_sales cts
ON c.CustomerID = cts.CustomerID
LEFT JOIN CTE_Last_date cld
ON c.customerID = cld.CustomerID


-- NESTED CTE
-- CTE inside another CTE
-- A nested CTE uses the result of another CTE, so it can't run independently


-- TASK:
-- #1 Step: Find the total sales per customer
-- #2 Step: Find the last order date per customer
-- #3 Step: Rank customers based on total sales per customer
-- #4 Step: Segment customers based on their total sales

-- #1 (standalone cte)
WITH CTE_Total_Sales AS
	(SELECT
		CustomerID,
		SUM(Sales) Total_sales
	FROM Sales.Orders
	GROUP BY CustomerID)
-- #2 (standalone cte)
, CTE_Last_Date AS
	(SELECT
		CustomerID,
		MAX(OrderDate) Last_order_date
	FROM Sales.Orders
	GROUP BY CustomerID)
-- #3 (nested cte)
, CTE_Rank_customers AS
	(SELECT
		CustomerID,
		RANK() OVER(ORDER BY Total_sales DESC) Rank_Customers
	FROM CTE_Total_Sales)
-- #4 (nested cte)
, CTE_Customer_segments AS 
	(SELECT 
	CustomerID,
	Total_sales,
	CASE WHEN Total_sales > 100 THEN 'High'
		 WHEN Total_sales > 50 THEN 'Medium'
		 ELSE 'Low'
	END Customer_segments
	FROM CTE_Total_Sales
	)	
-- Main query
SELECT
	c.CustomerID,
	c.FirstName,
	c.LastName,
	cts.Total_sales,
	cld.Last_order_date,
	crc.Rank_Customers,
	ccs.Customer_segments
FROM Sales.Customers c
LEFT JOIN CTE_Total_Sales cts
ON c.CustomerID = cts.CustomerID
LEFT JOIN CTE_Last_Date cld
ON c.CustomerID = cld.customerID
LEFT JOIN CTE_Rank_customers crc
ON c.CustomerID = crc.CustomerID
LEFT JOIN CTE_Customer_segments ccs
ON c.CustomerID = ccs.CustomerID
ORDER BY crc.Rank_Customers 
	
	


-- Non-recursive CTE: Is executed only once without any repetition

-- Recursive CTE: Self-referencing query that repeatedly processes data until a specific condition is met

-- TASK; Generate a sequence of numbers from 1 to 20
WITH Series AS
-- Anchor query
	(SELECT
		1 AS MyNumber
	UNION ALL
	-- Recursive query
	SELECT
	MyNumber + 1
	FROM Series
	WHERE MyNumber < 20
	)
-- Main query
SELECT *
FROM Series
-- If you needs a limit:
--OPTION (MAXRECURSION 10)


-- more advanced
-- TASK: Show the employee hierarchy by displaying each employee's level within the organization
WITH CTE_Emp_Hierarchy AS
-- Anchor Query
	(
	SELECT 
			EmployeeID,
			FirstName,
			ManagerID,
			1 AS level
	FROM Sales.Employees 
	WHERE ManagerID IS NULL
	UNION ALL
	-- Recursive query
	SELECT
		e.EmployeeID,
		e.FirstName,
		e.ManagerID,
		Level + 1
	FROM Sales.Employees AS e
	INNER JOIN CTE_Emp_Hierarchy ceh
	ON e.ManagerID  = ceh.EmployeeID
	)
-- Main query
SELECT 
	*
FROM CTE_Emp_Hierarchy


