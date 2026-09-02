-- Window Functions

-- Why we need window functions?
-- Why group by is not enough?


-- ex:
-- TASK: Find the total sales across all orders
SELECT
	SUM(Sales) TotalSales
FROM Sales.Orders

SELECT *
FROM Sales.Orders

-- Find the total sales for each product
SELECT
	ProductID,
	SUM(Sales) TotalSales
FROM Sales.Orders
GROUP BY ProductID

-- Find the total sales for each product, additionally provide details such order id and order date
SELECT
	OrderID,
	OrderDate,
	ProductID,
	SUM(Sales) TotalSales
FROM Sales.Orders
GROUP BY ProductID

--SQL Error [8120] [S0001]: Column 'Sales.Orders.OrderID' is invalid in the select list because it is not contained in either an aggregate function or the GROUP BY clause.

-- correct
SELECT
	OrderID,
	OrderDate,
	ProductID,
	SUM(Sales) TotalSales
FROM Sales.Orders
GROUP BY 
	OrderID,
	OrderDate,
	ProductID
-- But in this case, the "Find the total sales for each product" is destroyed
	
	
-- so, thats because this we need window functions
-- group by limits: cant do aggregations and provide details at same time
	
	
-- Window functions:
SELECT
	OrderID,
	OrderDate,
	ProductID,
	SUM(Sales) OVER(PARTITION BY ProductID) TotalSalesByProducts
FROM Sales.Orders
	
	
-- TASK: Find the total sales across all orders additionally provide details such order id and order date
SELECT
	OrderDate,
	OrderID,
	SUM(Sales) OVER () AS TotalSalesByOrderID
FROM Sales.Orders

	
-- TASK: Find the total sales for each product, additionally provide details such order id and order date
SELECT
	OrderDate,
	OrderID,
	Sales,
	ProductID,
	SUM(Sales) OVER (PARTITION BY ProductID) AS TotalSalesByProductID
FROM Sales.Orders



-- Multiple aggregations in multiple levels

-- TASK: Find the total sales across all orders,
-- Find the total sales for each product, 
-- additionally provide details such order id and order date
SELECT
	OrderDate,
	OrderID,
	Sales,
	ProductID,
	SUM(Sales) OVER () AS TotalSales,
	SUM(Sales) OVER (PARTITION BY ProductID) AS TotalSalesByProductID
FROM Sales.Orders


-- TASK: Find the total sales for each combination of product and order status
SELECT
	OrderDate,
	OrderID,
	Sales,
	ProductID,
	OrderStatus,
	SUM(Sales) OVER () AS TotalSales,
	SUM(Sales) OVER (PARTITION BY ProductID) AS TotalSalesByProductID,
	SUM(Sales) OVER (PARTITION BY ProductID, OrderStatus) AS SalesByProductsAndStatus
FROM Sales.Orders


-- OrderBY


-- TASK: Rank each order based on their sales from highest to lowest,
-- additionally provide details such Order ID, order date
SELECT 
	OrderID,
	OrderDate,
	Sales,
	RANK() OVER (ORDER BY Sales DESC) RankSales
FROM Sales.Orders

	
-- FRAMES
-- ROWS / RANGE
-- CURRENT ROW / N PRECEDING / UNBOUNDED PRECEDING
-- CURRENT ROW / N FOLLOWING / UNBOUNDED FOLLOWING

SELECT
	OrderID,
	OrderDate,
	OrderStatus,
	Sales,
	SUM(Sales) OVER (PARTITION BY OrderStatus ORDER BY OrderDate
	ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) TotalSales
FROM Sales.Orders
	
-- Default frame:
SELECT
	OrderID,
	OrderDate,
	OrderStatus,
	Sales,
	SUM(Sales) OVER (PARTITION BY OrderStatus ORDER BY OrderDate) TotalSales
FROM Sales.Orders

SELECT
	OrderID,
	OrderDate,
	OrderStatus,
	Sales,
	SUM(Sales) OVER (PARTITION BY OrderStatus ORDER BY OrderDate
	ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) TotalSales
FROM Sales.Orders

SELECT
	OrderID,
	OrderDate,
	OrderStatus,
	Sales,
	SUM(Sales) OVER (PARTITION BY OrderStatus ORDER BY OrderDate
	ROWS  UNBOUNDED PRECEDING CURRENT ROW) TotalSales
FROM Sales.Orders
	

-- tests
SELECT
	OrderID,
	OrderDate,
	OrderStatus,
	Sales,
	SUM(Sales) OVER (PARTITION BY OrderStatus ORDER BY OrderDate
	ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) TotalSales
FROM Sales.Orders

-- tests
SELECT
	OrderID,
	OrderDate,
	OrderStatus,
	Sales,
	SUM(Sales) OVER (PARTITION BY OrderStatus ORDER BY OrderDate
	ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) TotalSales
FROM Sales.Orders

--tests (the same)
SELECT
	OrderID,
	OrderDate,
	OrderStatus,
	Sales,
	SUM(Sales) OVER (PARTITION BY OrderStatus ORDER BY OrderDate
	ROWS 2 PRECEDING) TotalSales
FROM Sales.Orders
	

-- RULES
-- 1 - Window fucntions can be used only in SELECT and ORDER BY clause

SELECT
	OrderID,
	OrderDate,
	OrderStatus,
	Sales,
	SUM(Sales) OVER (PARTITION BY OrderStatus) TotalSales
FROM Sales.Orders
ORDER BY SUM(Sales) OVER (PARTITION BY OrderStatus) DESC
	
-- 2 - NESTING window fuctions is NOT ALLOWED!

SELECT
	OrderID,
	OrderDate,
	OrderStatus,
	Sales,
	SUM(SUM(Sales) OVER (PARTITION BY OrderStatus)) OVER (PARTITION BY OrderStatus) TotalSales
FROM Sales.Orders

-- "SQL Error [4109] [S0001]: Windowed functions cannot be used in the context of another windowed function or aggregate."

--3 - SQL EXECUTE window functions AFTER 'WHERE' clause

-- TASK: Find the total sales for each order status, only for two products 101 and 102
SELECT
	OrderID,
	OrderDate,
	OrderStatus,
	ProductID,
	Sales,
	SUM(Sales) OVER (PARTITION BY OrderStatus) TotalSales
FROM Sales.Orders
WHERE ProductID IN (101, 102)
	
-- 4 - Window functions can be used with GROUP BY in the same query, ONLY if the SAME COLUMNS are used

--TASK: Rank customers based on their total sales
SELECT
	CustomerID,
	SUM(Sales) TotalSales
FROM Sales.Orders
GROUP BY CustomerID 

SELECT
	CustomerID,
	SUM(Sales) TotalSales,
	RANK() OVER(ORDER BY SUM(Sales) DESC) RankCustomers
FROM Sales.Orders
GROUP BY CustomerID 
	
	












	


