-- Window Rank functions

-- ROW_NUMBER()
-- Assign a unique number to each row
-- it doesn't handle ties

-- TASK: Rank the orders based on theirs sales from highest to lowest

SELECT 
	OrderID,
	ProductID,
	Sales,
	ROW_NUMBER() OVER(ORDER BY SALES DESC) AS SalesRank_row
FROM Sales.Orders


-- RANK()
-- Assign a rank to each row
-- It handle ties

-- TASK: Rank the orders based on their sales from highest to lowest
SELECT 
	OrderID,
	ProductID,
	Sales,
	ROW_NUMBER() OVER(ORDER BY SALES DESC) AS SalesRank_row,
	RANK() OVER(ORDER BY Sales DESC) AS SalesRank_Rank
FROM Sales.Orders  


-- DENSE_RANK()
-- Assign a rank to each value
-- it handle ties
-- it doesn't leaves GAPS in rank

-- TASK: Rank the orders based on their sales from highest to lowest
SELECT 
	OrderID,
	ProductID,
	Sales,
	ROW_NUMBER() OVER(ORDER BY SALES DESC) AS SalesRank_row,
	RANK() OVER(ORDER BY Sales DESC) AS SalesRank_Rank,
	DENSE_RANK() OVER(ORDER BY Sales DESC) SalesRank_Dense
FROM Sales.Orders  


-- Use cases:
-- TOP-N analysis
-- analysis the top performers to do targeted marketing

-- TASK: Find the top highest sales for each product
SELECT
	OrderID,
	ProductID,
	Sales,
	ROW_NUMBER() OVER(PARTITION BY ProductID ORDER BY Sales DESC) RankByProduct
FROM Sales.Orders

-- we can use in subqueries
SELECT *
FROM  (
	SELECT
		OrderID,
		ProductID,
		Sales,
		ROW_NUMBER() OVER(PARTITION BY ProductID ORDER BY Sales DESC) RankByProduct
	FROM Sales.Orders
)t WHERE RankByProduct = 1


-- Use cases:
-- BOTTOM-N analysis
-- Help analysis the underperfomance to manage risks and to do optimizations

--TASK: Find the lowest 2 customers based on their total sales
SELECT *
FROM (
	SELECT
		CustomerID,
		SUM(Sales) TotalSales,
		ROW_NUMBER() OVER(ORDER BY SUM(Sales)) RankCustomers
	FROM Sales.Orders
	GROUP BY CustomerID
)t WHERE t.RankCustomers <= 2


-- Use cases:
-- Generated unique id


-- TASK: assign unique IDs to the rows of the 'Orders Archive' table
SELECT
	ROW_NUMBER() OVER(ORDER BY OrderID, OrderDate) UniqueID,
	*
FROM Sales.OrdersArchive 


-- Use Cases:
-- Identify duplicates
-- identify and remove duplicates rows to improve data quality

-- TASK: Identify duplicate rows in the table 'Orders Archive'
-- and return a clean result without any duplicates
SELECT * FROM(
	SELECT
		ROW_NUMBER() OVER(PARTITION BY OrderID ORDER BY CreationTime DESC) rn,
		*
	FROM Sales.OrdersArchive 
)t WHERE rn=1
-- the orderid was the same number, but the creation time is diferent, based on this that we rank 


-- NTILE()
-- Divides the rows into a specified number of approximately equal groups(buckets)
SELECT
	OrderID,
	Sales,
	NTILE(1) OVER (ORDER BY Sales DESC) OneBucket,
	NTILE(2) OVER (ORDER BY Sales DESC) TwoBuckets,
	NTILE(3) OVER (ORDER BY Sales DESC) ThreeBuckets,
	NTILE(4) OVER (ORDER BY Sales DESC) FourBuckets
FROM Sales.Orders 

-- Uses cases for NTILE:
-- Data Segmentation

-- TASK: Segment all orders into 3 categories, High, Medium and Low Sales
SELECT
*,
CASE WHEN threecategories = 1 THEN 'High'
	 WHEN threecategories = 2 THEN 'Medium'
	 WHEN threecategories = 3 THEN 'Low'
END SalesSegmentation
FROM(
	SELECT
		OrderID,
		Sales,
		NTILE(3) OVER(ORDER BY  Sales DESC) threecategories
	FROM Sales.Orders
)t


-- Uses cases for NTILE:
-- Equalizing Load (necessary in Data engineer)

-- TASK: In order to export the data, divide the orders into 2 groups
SELECT 
	NTILE(2) OVER(ORDER BY OrderID) Buckets, 
	*
FROM Sales.Orders



-- PERCENTAGE-BASED RANKING

-- CUME_DIST()
-- Cumulative distribution calculates the distribution of data points within a window

-- TASK: Find the products that fall within the highest 40% of the prices
SELECT 
	*,
	CONCAT(t.DistRank * 100, '%') DistRankPercentage
FROM (
	SELECT
		Product,
		Price,
		CUME_DIST() OVER(ORDER BY Price DESC) DistRank
	FROM Sales.Products
)t
WHERE t.DistRank <= 0.4


-- PERCENT_RANK()
-- Calculates the relative position of each row

-- The same task and the same result, but using PERCENT_RANK():
SELECT 
	*,
	CONCAT(t.DistRank * 100, '%') DistRankPercentage
FROM (
	SELECT
		Product,
		Price,
		PERCENT_RANK() OVER(ORDER BY Price DESC) DistRank
	FROM Sales.Products
)t
WHERE t.DistRank <= 0.4

















