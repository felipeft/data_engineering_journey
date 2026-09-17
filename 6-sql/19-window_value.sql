-- Value Window Functions

-- LEAD()
-- Access a value from the next rom within a window


-- LAG()
-- Access a value from the previous rom within a window


-- USES CASES:
-- time series analysis 
-- (the process of analyzing the data to understand patterns, trends and behaviors over time)

-- Month-over-month Analysis (MoM)
-- Analyze short-term trends and discover patterns in seasonality

-- Year-over-Year (YoY)
-- Analyze the overall growth or decline of the bussiness's perfomance over time


-- TASK: Analyze the month-over-month (MoM) perfomance by finding the percentage change in sales between
-- the current and previous month
SELECT 
	*,
	t.CurrentMonthSales - t.PreviousMonthSales AS MoM_Change,
	ROUND(CAST((t.CurrentMonthSales - t.PreviousMonthSales) AS FLOAT) / t.PreviousMonthSales * 100, 1) AS MoM_Perc
FROM(
	SELECT
		MONTH(OrderDate) OrderMonth, 
		SUM(Sales) CurrentMonthSales,
		LAG(SUM(Sales)) OVER(ORDER BY MONTH(OrderDate)) PreviousMonthSales
	FROM Sales.Orders
	GROUP BY
		MONTH(OrderDate)
)t


-- USES CASES:
-- Customer Retention Analysis:
-- measure customers behavior and loyalty to help bussinesses build strong relationships with customers

-- TASK: Analyze customers loyalty, rank customers based on the average days between their orders
SELECT
	CustomerID,
	AVG(t.DaysUntilNextOrder) AvgDays,
	RANK() OVER (ORDER BY COALESCE(AVG(t.DaysUntilNextOrder), 99999)) RankAvg
FROM(
	SELECT
		OrderID,
		CustomerID,
		OrderDate CurrentOrder,
		LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate) NextOrder,
		DATEDIFF(day, OrderDate, LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate)) DaysUntilNextOrder
	FROM Sales.Orders
)t 
GROUP BY CustomerID 


-- FIRST_VALUE()
-- Access a value from the first row within a window

-- LAST_VALUE()
-- Access a value from the last row within a window


-- TASK: Find the lowest and highest sales for each product

SELECT
	OrderID,
	ProductID,
	Sales,
	FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales) LowestSales,
	LAST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) HighestSales,
	FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales DESC) HighestSales2, -- the same result of last_value
	MIN(Sales) OVER (PARTITION BY ProductID) LowestSales2,
	MAX(Sales) OVER (PARTITION BY ProductID) HighestSales3
FROM Sales.Orders

-- At the same task, find the difference in sales between the current and the lowest values
SELECT
	OrderID,
	ProductID,
	Sales,
	FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales) LowestSales,
	LAST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) HighestSales,
	Sales - FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales) AS SalesDifference
FROM Sales.Orders














