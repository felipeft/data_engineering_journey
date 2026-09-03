-- Window Aggregate

-- COUNT()
--Counts the number of values in a column, regardless of their data types
-- COUNT(*) = COUNT(1)

-- TASK: Find the total number of orders
SELECT 
	COUNT(*) TotalOrders
FROM Sales.Orders

-- TASK: Find the total number of orders
-- Additionally provide details such order id & order date
SELECT 
	OrderID,
	OrderDate,
	COUNT(*) OVER() TotalOrders -- OVER = window 
FROM Sales.Orders

-- TASK: Find the total number of orders,
-- Find the total number of Orders for each customers
-- Additionally provide details such order id & order date
SELECT 
	OrderID,
	OrderDate,
	CustomerID,
	COUNT(*) OVER() TotalOrders,
	COUNT(*) OVER(PARTITION BY CustomerID) OrdersByCustomers
FROM Sales.Orders

-- Find the total number of customers,
-- additionally provide all customers details

SELECT 
	*, 
	COUNT(*) OVER() TotalCustomers
FROM Sales.Customers

-- Find the total number of customers,
-- Find the total number of scores for the customers
SELECT 
	*, 
	COUNT(*) OVER() TotalCustomers,
	COUNT(Score) OVER() totalNrScores
FROM Sales.Customers


-- Find the total number of customers,
-- Find the total number of scores for the customers
-- additionally provide all customers details
SELECT 
	*, 
	COUNT(*) OVER() TotalCustomers,
	COUNT(Score) OVER() totalNrScores,
	COUNT(Country) OVER() TotalNrCountries -- correct
FROM Sales.Customers

-- Data quality issue: dupliates leads to inaccuracies in analysis
-- COUNT() can be used to identify duplicates

-- TASK: Check wheter the tables 'orders' contains any duplicate rows
SELECT
	OrderID,
	COUNT(*) OVER (PARTITION BY OrderID) CheckPK
FROM Sales.Orders

-- TASK: Check wheter the tables 'ordersArchive' contains any duplicate rows
SELECT
	*
FROM(
	SELECT
		OrderID,
		COUNT(*) OVER (PARTITION BY OrderID) CheckPK
	FROM Sales.OrdersArchive
)t WHERE CheckPK > 1


-- SUM()
-- Returns the sum of values within a window

-- TASK: Find the total sales across all orders
-- and the total sales for each product
-- additionally provide details such order ID, order date
SELECT
	OrderID,
	OrderDate,
	SUM(Sales) OVER() TotalOfSales,
	ProductID,
	SUM(Sales) OVER(PARTITION BY ProductID) totalSalesForProduct
FROM Sales.Orders



-- COMPARISON USE CASES

-- TASK: find the percentage contribution of each product's sales to the total sales
SELECT
	OrderID,
	ProductID,
	Sales,
	SUM(Sales) OVER() TotalSales,
	ROUND(CAST(Sales AS Float) / SUM(Sales) OVER() * 100, 2) AS PercentageOfTotal
FROM Sales.Orders



-- AVG()
-- Returns the average of values within a window

-- TASK: Find the average sales across all orders
-- and find the average sales for each product
-- additionally provide details such order ID, order date


SELECT
	OrderID,
	OrderDate,
	Sales,
	AVG(Sales) OVER() AverageSales,
	ProductID,
	AVG(Sales) OVER(PARTITION BY ProductID) AVGPerProduct
FROM Sales.Orders

-- TASK: Find the average scores of customers
-- additionally provide details such CustomerID and LastName
SELECT 
	CustomerID,
	LastName,
	Score,
	AVG(Score) OVER() AVGScoreNoZero,
	AVG(COALESCE(Score, 0)) OVER() AVGScoresWithoutNULL
FROM Sales.Customers

-- TASK: Find all orders where sales are higher than the average sales across all orders
SELECT
*
FROM(
	SELECT 
		OrderID,
		ProductID,
		Sales,
		AVG(Sales) OVER() AvgSales
	FROM Sales.Orders
)t WHERE Sales > AvgSales



-- MIN / MAX
-- Returns the lowest / higher value within a window

-- TASK: Find the highest & lowest sales across all orders
-- and the highest & lowest sales for each product.
-- additionally, provide details such as order id and order date
SELECT
	OrderID,
	OrderDate,
	Sales,
	MAX(Sales) OVER() HighestSale,
	MIN(Sales) OVER() LowestSale,
	ProductID,
	MAX(Sales) OVER(PARTITION BY ProductID) HighestSalebyProduct,
	MIN(Sales) OVER(PARTITION BY ProductID) LowestSaleByProduct
FROM Sales.Orders


-- TASK: Show the employees who have the highest salaries
SELECT 
*
FROM(
	SELECT
		*, 
		MAX(Salary) OVER() HighestSalary
	FROM Sales.Employees
)t
WHERE Salary = t.HighestSalary


-- TASK: Calculate the deviation of each sale from both the minimum and maximum sales amounts
SELECT
	OrderID,
	OrderDate,
	Sales,
	MAX(Sales) OVER() HighestSale,
	MIN(Sales) OVER() LowestSale,
	Sales - MIN(Sales) OVER() DeviationFromMin,
	Max(Sales) OVER() - Sales DeviationFromMax
FROM Sales.Orders




-- Running total / Rolling total
-- RUNNING: Aggregate all values from the begining up to the current point WITHOUT DROPPING off older data
-- ROLLING: Aggregate all values within a fixed time window as new dta is added, the oldest data point will be dropped


-- TASK: Calculate moving average of sales for each product over time
SELECT
	OrderID,
	OrderDate,
	Sales,
	ProductID,
	AVG(Sales) OVER (PARTITION BY ProductID) AvgByProduct,
	AVG(Sales) OVER (PARTITION BY ProductID ORDER BY OrderDate) MovingAvg
FROM Sales.Orders

-- TASK: Calculate moving average of sales for each product over time
-- Including only the next order
SELECT
	OrderID,
	OrderDate,
	Sales,
	ProductID,
	AVG(Sales) OVER (PARTITION BY ProductID) AvgByProduct,
	AVG(Sales) OVER (PARTITION BY ProductID ORDER BY OrderDate) MovingAvg,
	AVG(Sales) OVER (PARTITION BY ProductID ORDER BY OrderDate ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) RollingAvg
FROM Sales.Orders























