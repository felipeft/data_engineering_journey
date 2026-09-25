-- VIEWS
-- Virtual table based on the result set of a query without storing data in database

-- USES CASES:
-- 1. Central Query Logic
-- Store central, complex query logic in the database for access by multiple queries, reducing
-- project complexity


-- TASK: Find the running total of sales for each month

-- * using CTE
WITH CTE_monthly_Summary AS (
	SELECT
		DATETRUNC(month, OrderDate) OrderMonth,
		SUM(Sales) TotalSales,
		COUNT(OrderID) TotalOrders,
		SUM(Quantity) TotalQuantities
	FROM Sales.Orders
	GROUP BY DATETRUNC(month, OrderDate)
)
SELECT 
	OrderMonth,
	TotalSales,
	SUM(TotalSales) OVER(ORDER BY OrderMonth) AS RunningTotal
FROM CTE_monthly_Summary

-- we can put the logic of cte to reduce the redundancy in multiple queries
CREATE VIEW V_monthly_Summary AS 
(
	SELECT
		DATETRUNC(month, OrderDate) OrderMonth,
		SUM(Sales) TotalSales,
		COUNT(OrderID) TotalOrders,		
		SUM(Quantity) TotalQuantities
	FROM Sales.Orders
	GROUP BY DATETRUNC(month, OrderDate)
)

-- Now, we can just query in this view in anothers scripts

SELECT 
	*
FROM V_monthly_Summary

-- Is important to see: if in a creation of the view, we cant specified a schema, the default is 'dbo'
-- this happend here

-- Put the schema name in DDL
CREATE VIEW Sales.V_monthly_Summary AS 
(
	SELECT
		DATETRUNC(month, OrderDate) OrderMonth,
		SUM(Sales) TotalSales,
		COUNT(OrderID) TotalOrders,		
		SUM(Quantity) TotalQuantities
	FROM Sales.Orders
	GROUP BY DATETRUNC(month, OrderDate)
)

-- DROP a view
DROP VIEW V_monthly_Summary

-- If you change a view, you can drop it and then, create again
-- We can do this is simple way: Just drop and then create
-- or use T-sql (transct-sql is an extension of sql that adds programming features)

IF OBJECT_ID ('Sales.V_monthly_Summary', 'V') IS NOT NULL
	DROP VIEW Sales.V_monthly_Summary;
GO
CREATE VIEW Sales.V_monthly_Summary AS 
(
	SELECT
		DATETRUNC(month, OrderDate) OrderMonth,
		SUM(Sales) TotalSales,
		COUNT(OrderID) TotalOrders
	FROM Sales.Orders
	GROUP BY DATETRUNC(month, OrderDate)
)
-- *Diferrent view from the previous one, because only have 3 columns
-- command here: alt+x


-- USES CASES:
-- 2. Reduce complexity

-- TASK: Provide view that combines details from orders, products, cstomers and employees
CREATE VIEW Sales.V_Order_Details AS (
	SELECT 
		o.OrderID,
		o.OrderDate,
		p.Product,
		p.Category,
		COALESCE(c.FirstName, '') + ' ' + COALESCE(c.LastName, '') CustomerName,
		c.Country CustomerCountry,
		COALESCE(e.FirstName, '') + ' ' + COALESCE(e.LastName, '') SalesName,
		e.Department,
		o.Sales,
		o.Quantity
	FROM Sales.Orders o
	LEFT JOIN Sales.Products p
	ON p.ProductID = o.ProductID 
	LEFT JOIN Sales.Customers c
	ON c.CustomerID = o.CustomerID 
	LEFT JOIN Sales.Employees e 
	ON e.EmployeeID = o.SalesPersonID 
	)
	
-- explore this view now
SELECT * FROM Sales.V_Order_Details 


-- USES CASES:
-- 3. Data Security

-- TASK: Provide a view for EU sales team
-- that combines details from all tables
-- And excludes Data related to the USA
CREATE VIEW Sales.V_Order_Details_EU AS (
	SELECT 
		o.OrderID,
		o.OrderDate,
		p.Product,
		p.Category,
		COALESCE(c.FirstName, '') + ' ' + COALESCE(c.LastName, '') CustomerName,
		c.Country CustomerCountry,
		COALESCE(e.FirstName, '') + ' ' + COALESCE(e.LastName, '') SalesName,
		e.Department,
		o.Sales,
		o.Quantity
	FROM Sales.Orders o
	LEFT JOIN Sales.Products p
	ON p.ProductID = o.ProductID 
	LEFT JOIN Sales.Customers c
	ON c.CustomerID = o.CustomerID 
	LEFT JOIN Sales.Employees e 
	ON e.EmployeeID = o.SalesPersonID 
	WHERE c.Country != 'USA'
	)

-- explore this new view
SELECT * FROM Sales.V_Order_Details_EU


-- USES CASES:
-- 4. Flexibility & Dynamic

-- 5. Multiple languages

-- 6. Virtual Data Marts in DWH
-- Views can be used as data marts in data warehouse system because they provide 
-- a flexible and efficient way to preset










