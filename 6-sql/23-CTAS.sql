-- CTAS
-- 'Create table as Select'
-- Create a new table based on result of an sql query

-- Two types of tables: Permanent table & Temporary tables
-- Permanent table:
-- Create/insert
-- CTAS

-- USES CASES:
-- #1 Optimize perfomance

SELECT
	DATENAME(month, OrderDate) OrderMonth,
	COUNT(OrderID) TotalOrders
INTO Sales.MonthlyOrders
FROM Sales.Orders
GROUP BY DATENAME(month, OrderDate)
-- We create a new table

-- Check this new table
SELECT * FROM Sales.MonthlyOrders

-- Drop this
DROP TABLE Sales.MonthlyOrders



-- How can we refresh CTAS data?
-- DROP and SELECT again using T-SQL
IF OBJECT ID('Sales.MonthlyOrders', 'U') IS NOT NULL
	DROP TABLE Sales.MonthlyOrders
GO
SELECT
	DATENAME(month, OrderDate) OrderMonth,
	COUNT(OrderID) TotalOrders
INTO Sales.MonthlyOrders
FROM Sales.Orders
GROUP BY DATENAME(month, OrderDate)



-- USES CASES
-- #2 Creating a snapshot
-- Preserve old information 

-- #3 Physical data marts in DWH
-- Persisting the data marts of a DWH improves the speed of data retrieval compared to using views

 
-- Temporary tables
-- Stores intermediate results in a temporary storage within the database during the session
-- The database will drop all temporary tables once the session ends
-- Session is the time between connecting to and disconneting from the database

SELECT 
	*
	INTO #Orders
FROM Sales.Orders 

-- check this temporary table
SELECT * FROM #Orders

-- DELETE this
-- for example
DELETE FROM #Orders
WHERE OrderStatus = 'Delivered'

-- USES CASES
-- #1 Intermediate Results











