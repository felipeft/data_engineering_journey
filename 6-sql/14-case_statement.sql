-- CASE STATEMENT

-- USES CASES
-- #1: Data Categorization

-- TASK: Generate a report showing the total sales for each category:
--- High: Sales over 50
--	   - Medium: Sales between 20 and 50
--	   - Low: Sales 20 or less
--   The results are sorted from highest to lowest total sales.

SELECT
	Category,
	SUM(Sales) AS TotalSales
FROM(
	SELECT 
	OrderID,
	Sales,
	CASE
		WHEN Sales > 50 THEN 'High'
		WHEN Sales > 20 THEN 'Medium'
		Else 'low'
	END Category
FROM Sales.Orders
)t
GROUP BY Category
ORDER BY TotalSales DESC


-- #2: Mapping values
-- Transform the values from one to another
-- translate techcnical values to readble information like 1 -> ative; 0 -> inactive

-- TASK: Retrieve employee details with gender displayed as full text
SELECT
	e.EmployeeID,
	e.FirstName + ' ' + e.LastName AS FullName,
	CASE
		WHEN e.Gender = 'M' THEN 'Male'
		ELSE 'Female'
	END GenderFull
FROM Sales.Employees e 


-- TASK:  Retrieve customer details with abbreviated country codes 

SELECT
    CustomerID,
    FirstName,
    LastName,
    Country,
    CASE 
        WHEN Country = 'Germany' THEN 'DE'
        WHEN Country = 'USA'     THEN 'US'
        ELSE 'n/a'
    END AS CountryAbbr
FROM Sales.Customers;
-- but this is the full form

-- we can write this query in quick form:
SELECT
    CustomerID,
    FirstName,
    LastName,
    Country,
    CASE Country
        WHEN 'Germany' THEN 'DE'
        WHEN 'USA'     THEN 'US'
        ELSE 'n/a'
    END AS CountryAbbr
FROM Sales.Customers;



-- #3: Handling NULLS
-- replace NULLS with a specific value


-- TASK: Find the average scores of customers and treat NULLS as 0
SELECT
	AVG(Score) AS AverageOfScores
FROM(
	SELECT 
		c.CustomerID,
		CASE 
			WHEN c.Score IS NULL THEN '0'
			else c.Score
		END Score
	FROM Sales.Customers c 
)t

-- #4: Conditional Aggregation
-- Apply aggregate functions only on subsets of data that fulfill certain conditions

-- TASK: Count how many times each customer has made an order with sales greater than 30
SELECT
	o.CustomerID,
	SUM(CASE
		WHEN o.Sales > 30 THEN 1
		ELSE 0
	END) totalOrdersHighSales,
	COUNT(*) TotalOrders
FROM Sales.Orders o 
GROUP BY o.CustomerID













