-- NULL FUNCTIONS

-- IS NULL: Replace 'NULL' with a specified value

-- COALESCE: Return the first non-null value from a list

-- USES: Data agreggation, In some cases, values like 0 can be calculates with AVG() functions and returns a wrong
-- result


-- TASK: Find the average scores of the customers

SELECT *
FROM Sales.Customers

SELECT 
	CustomerID,
	Score,
	AVG(Score) OVER () Average_scores,
	AVG(COALESCE(Score, 0)) OVER() AvgScores2	-- if exists a value 'NULL', it will be changed to 0
FROM Sales.Customers

-- USES: Mathematical Operations
-- Handle the NULL before doing mathematical operations

-- example (very critical problem to analysis)
-- NULL + 5 = NULL
-- NULL + 'b' = NULL


-- TASK: Display the full name of customers in a single field by merging their first and last names
-- and add 10 bonus points to each customers score
SELECT 
	CustomerID,
	FirstName,
	LastName,
	Score,
	ISNULL(FirstName, '') + ' ' + ISNULL(LastName, '') Full_name,
	ISNULL(Score, 0) + 10 ScoreWBonus
FROM Sales.Customers


-- USES - Sort Data
-- TASK: Sort the customers from lowest to highest scores, with nulls appearing last
SELECT
	CustomerID,
	ISNULL(Score, 0) as Score 
FROM Sales.Customers
ORDER BY Score



-- NULL FUNCTIONS

-- NULLIF: Compares two expressions returns
-- NULL, if they are equal
-- first value if they are not equal

-- TASK: Find the sales price for each order by dividing the sales by the quantity
SELECT 
	OrderID,
	Sales,
	Quantity,
	Sales / NULLIF(Quantity,0) as Price
FROM Sales.Orders





-- NULL FUNCTIONS

-- IS NOT NULL: Returns TRUE if the value IS NOT NULL, otherwise it returns FALSE

-- TASK: Identify the customers who have no scores
SELECT
	CustomerId,
	Score
FROM Sales.customers
WHERE Score IS NULL

-- TASK: List all customers who have scores
SELECT
	CustomerId,
	Score
FROM Sales.customers
WHERE Score IS NOT NULL

-- USE CASE: ANTI JOIN

-- TASK: List all details for customers who have not placed any orders
SELECT
	c.*,
	o.OrderID
FROM Sales.customers as c
LEFT JOIN Sales.Orders as o
ON c.CustomerID = o.CustomerID 
WHERE o.CustomerID IS NULL

SELECT *
FROM Sales.orders


-- Diference between blank space, NULL and empty string

WITH Orders AS (
    SELECT 1 AS Id, 'A' AS Category UNION
    SELECT 2, NULL UNION
    SELECT 3, '' UNION
    SELECT 4, '  '
)
SELECT
	*,
	DATALENGTH(Category) Categorylen

FROM Orders


-- Data policies
-- #1 - only use NULLS and EMPTY STRINGS, but avoid BLANK SPACES
-- #2 - only use NULLS and, avoid using EMPTY STRINGS and BLANK SPACES
		-- CASE: Optimize storage and perfomance
-- #3 - Use the Default Value 'unknown' and avoid using NULLS, EMPTY STRINGS and BLANK SPACES
		-- CASE: Best to using it in reporting to improve readiblity and reduce confusion
WITH Orders AS (
    SELECT 1 AS Id, 'A' AS Category UNION
    SELECT 2, NULL UNION
    SELECT 3, '' UNION
    SELECT 4, '  '
)
SELECT
	*,
	DATALENGTH(Category) Categorylen,
	DATALENGTH(TRIM(Category)) policy1,
	NULLIF(TRIM(Category), '') policy2,
	COALESCE(NULLIF(TRIM(Category), ''), 'unknown') AS Policy3

FROM Orders










