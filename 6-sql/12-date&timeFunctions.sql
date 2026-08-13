-- DATE & TIME FUNCTIONS

SELECT
	OrderID,
	OrderDate,
	ShipDate,
	CreationTime
FROM Sales.Orders

-- HARDCODED DATE
SELECT
	OrderID,
	CreationTime,
	'2025-08-20' Hardcoded 		-- Static value
FROM Sales.Orders

-- GETDATE: Returns the current date and time at the moment when the query is executed
SELECT
	OrderID,
	CreationTime,
	'2025-08-20' Hardcoded,
	GETDATE() Today
FROM Sales.Orders


-- FUNCTIONS

-- PART EXTRACTION


-- DAY: returns the day from a date
-- MONTH: Returns the month from a date
-- YEAR: Returns the year from a date
SELECT
	OrderID,
	CreationTime,
	DAY(CreationTime) OnlyDay,
	MONTH(CreationTime) OnlyMonth,
	YEAR(CreationTime) OnlyYear
FROM Sales.Orders


-- DATEPART: Returns a specific part of a date as a number
SELECT
	OrderID,
	CreationTime,
	DATEPART(year, CreationTime) Year_dp,
	DATEPART(mm, CreationTime) Month_dp,
	DATEPART(dd, CreationTime) Day_dp,
	DATEPART(hh, CreationTime) Hour_dp,
	DATEPART(quarter, CreationTime) Quarter_dp,
	DATEPART(week, CreationTime) Weekday_dp,
	DAY(CreationTime) OnlyDay,
	MONTH(CreationTime) OnlyMonth,
	YEAR(CreationTime) OnlyYear
FROM Sales.Orders


-- DATENAME: Returns the name of a specific part of a date
SELECT
	OrderID,
	CreationTime,
	DATENAME(month, CreationTime) Month_name,
	DATENAME(weekday, CreationTime) Day_name,
	DATENAME(year, CreationTime) Year_name
FROM Sales.Orders


-- DATETRUNC: Trucantes the date to the specific part 
SELECT
	OrderID,
	CreationTime,
	DATETRUNC(hour, CreationTime) Hour_trunc,
	DATETRUNC(day, CreationTime) Day_trunc,
	DATETRUNC(mm, CreationTime) Month_trunc			-- Changes to day 1
FROM Sales.Orders


-- EOMONTH: Returns the last day of the month

SELECT 
	OrderID,
	CreationTime,
	EOMONTH(CreationTime) EndOfMonth,
	CAST(DATETRUNC(month, CreationTime) AS DATE) SatrtOfMonth
FROM Sales.Orders



-- DATA AGGREGATIONS

-- TASK: How many orders were placed each year?
SELECT 
	YEAR(OrderDate),
	COUNT(*)
FROM Sales.Orders
GROUP BY YEAR(OrderDate)

-- TASK: How many orders were placed each Month?
SELECT 
	MONTH(OrderDate),
	COUNT(*)
FROM Sales.Orders
GROUP BY MONTH(OrderDate)

-- TASK: Show all orders that were placed during the month of february
SELECT *
FROM Sales.Orders
WHERE MONTH(OrderDate) = 2 

-- BEST PRACTICE: Filtering Data using an integer is faster than using a String








-- FUNCTIONS

-- FORMAT & CASTING

-- FORMATING: Changing the format of a value from one to another
-- Changing how to data looks


-- CASTING: Changing the data type from one to another


-- FORMAT: Formats a date or time value
SELECT 
	CreationTime,
	FORMAT(CreationTime, 'MM-dd-yyyy') USA_format,
	FORMAT(CreationTime, 'dd-MM-yyyy') EURO_format,
	FORMAT(CreationTime, 'dd') dd,
	FORMAT(CreationTime, 'ddd') ddd,
	FORMAT(CreationTime, 'dddd') dddd,
	FORMAT(CreationTime, 'MM') MM,
	FORMAT(CreationTime, 'MMM') MMM,
	FORMAT(CreationTime, 'MMMM') MMMM
FROM Sales.Orders

-- TASK: Show CreationTime using the following format:
-- Day Wed Jan Q1 2025 12:34:36 PM
-- tip: "+"
SELECT 
	CreationTime,
	FORMAT(CreationTime, 'dd ddd MMM') +
	' Q' + DATENAME(quarter, CreationTime) + ' ' +
	FORMAT(CreationTime, 'yyyy hh:mm:s t') + 'M'
	
	
	AS Formating
FROM Sales.Orders

-- Formatting use case
-- Data Agreggation with FORMAT

SELECT
	FORMAT(OrderDate, 'MMM yy') OrderDate,
	COUNT(*)
FROM Sales.Orders
GROUP BY FORMAT(OrderDate, 'MMM yy') 



-- CONVERT: Converts a date or time value to a different data type & Formats the value
SELECT
	CONVERT(INT, '123') AS [STRING to INT Convert],
	CONVERT(DATE, '2025-08-20') AS [STRING to DATE Convert],
	CreationTime,
	CONVERT(DATE, CreationTime) AS [Datetime to DATE Convert]
FROM Sales.Orders


SELECT
	CreationTime,
	CONVERT(DATE, CreationTime) AS [Datetime to DATE Convert],
	CONVERT(VARCHAR, CreationTime, 32) AS [USA Std. Style:32],
	CONVERT(VARCHAR, CreationTime, 34) AS [EURO Std. Style:34]
FROM Sales.Orders


-- CAST: Converts a value to a specified datatype
SELECT
	CAST('123' AS INT) AS [String to INT],
	CAST(123 AS VARCHAR) AS [INT to String],
	CAST('2025-08-20' AS DATE) AS [String to Date],
	CAST('2025-08-20' AS DATETIME2) AS [String to Datetime],
	CreationTime,
	CAST(CreationTIme AS DATE) AS [Datetime to Date]
FROM Sales.Orders



-- FUNCTIONS

-- Date Calculations



-- DATEADD: Adds or subtracts a specific time interval to/from a date
SELECT 
	OrderID,
	OrderDate,
	DATEADD(day, -10, OrderDate) as TenDaysBefore,
	DATEADD(month, 3, OrderDate) as ThreeMonthsLater,
	DATEADD(year, 2,OrderDate) as TwoYearsLater
FROM Sales.Orders



-- DATEDIFF: Find the difference between two dates

-- TASK: Calculate the age of employees
SELECT
	EmployeeID,
	CONCAT(FirstName, ' ', LastName),
	BirthDate,
	DATEDIFF(year, BirthDate, GETDATE()) AS AgeOfEachEmployeer
FROM Sales.Employees 


-- TASK: Find the average shipping duration in days for each month

SELECT
	MONTH(OrderDate) as OrderDate,
	AVG(DATEDIFF(day, OrderDate, ShipDate)) AS avgShipToMonth
FROM Sales.Orders 
GROUP BY MONTH(OrderDate)


SELECT *
FROM Sales.Orders 

-- Time gap Analysis
-- TASK: Find the number of days between each order and previous order
SELECT
	OrderID,
	OrderDate CurrentOrderDate,
	LAG(OrderDate) OVER (ORDER BY OrderDate) PreviousOrderDate,
	DATEDIFF(day, LAG(OrderDate) OVER (ORDER BY OrderDate), OrderDate) NumberOfDays
FROM Sales.Orders


-- FUNCTIONS

-- Date Validation

-- ISDATE: check if a value is a date
-- returns 1 if the string is a valid date

SELECT 
	ISDATE('123') Datecheck1,
	ISDATE('2025-08-20') DateCheck2,	-- ISO format
	ISDATE('20-08-2025') DateCheck3,	-- sql does not understand this format
	ISDATE('2025') DateCheck4,
	ISDATE('08') DateCheck5


SELECT
	OrderDate,
	ISDATE(OrderDate),
	CASE WHEN ISDATE(OrderDate) = 1 THEN CAST (OrderDate AS DATE)
		ELSE '9999-01-01'	-- Dummy value
	END NewOrderDate
FROM
( 
	SELECT '2025-08-20' AS OrderDate UNION 
	SELECT '2025-08-21' UNION
	SELECT '2025-08-23' UNION
	SELECT '2025-08'
)t
-- WHERE ISDATE(OrderDate) = 0






