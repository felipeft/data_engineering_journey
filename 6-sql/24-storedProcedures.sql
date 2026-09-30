-- Stored Procedures

-- Basic

-- Step 1: Write a Query
-- For US Customers find the total number of customers and the average score

SELECT
	COUNT(*) TotalCustomers,
	AVG(Score) AvgScore
FROM Sales.Customers
WHERE Country = 'USA'

-- lets put this in a txt renamed by WeeklyQuery.sql...
-- You can run this all the weeks and it will be very boring and problematic...


-- Step 2: Turning the query into a stored procedure
CREATE PROCEDURE GetCustomerSummary AS
BEGIN
SELECT
	COUNT(*) TotalCustomers,
	AVG(Score) AvgScore
FROM Sales.Customers
WHERE Country = 'USA'
END

-- Step 3: Execute the stored procedure

EXEC GetCustomerSummary



-- Parameters


-- imagine instead US we need to report the customers from Germany...
CREATE PROCEDURE GetCustomerSummaryGermany AS
BEGIN
SELECT
	COUNT(*) TotalCustomers,
	AVG(Score) AvgScore
FROM Sales.Customers
WHERE Country = 'Germany'
END

EXEC GetCustomerSummaryGermany

-- but this is wrong and dumb
-- Avoid repetition
-- If you notice repeated code in your project, it's a sign that your code can be improved
ALTER PROCEDURE GetCustomerSummary @Country NVARCHAR(50) AS
BEGIN
SELECT
	COUNT(*) TotalCustomers,
	AVG(Score) AvgScore
FROM Sales.Customers
WHERE Country = @Country
END

EXEC GetCustomerSummary @Country = 'Germany'

-- Drop that shit
DROP PROCEDURE GetCustomerSummaryGermany

-- Multiple Statements
-- tASK: Find the total Nr. of Orders and total sales
ALTER PROCEDURE GetCustomerSummary @Country NVARCHAR(50) AS
BEGIN
SELECT
	COUNT(*) TotalCustomers,
	AVG(Score) AvgScore
FROM Sales.Customers
WHERE Country = @Country;

SELECT
	COUNT(OrderID) TotalOrders,
	SUM(Sales) TotalSales
FROM Sales.Orders o
JOIN Sales.Customers c
ON c.CustomerID = o.CustomerID
WHERE c.Country = @Country;

END

EXEC GetCustomerSummary @Country = 'Germany'
-- In this case, we have two results


-- VARIABLES
-- Placeholders used to store values to be used later in the procedure
-- vs.
-- PARAMETERS - pass values into a stored procedure or return values back to the caller
-- EX:

-- Total Customers from germany: 2
-- Average score from germany: 425

ALTER PROCEDURE GetCustomerSummary @Country NVARCHAR(50) = 'USA' AS
BEGIN
	
DECLARE @TotalCustomers	INT, @AvgScore FLOAT;

	
SELECT
	@TotalCustomers = COUNT(*),
	@AvgScore = AVG(Score)
FROM Sales.Customers
WHERE Country = @Country;

PRINT 'Total Customers from ' + @Country + ':' + CAST(@TotalCustomers AS NVARCHAR);
PRINT 'Average score from ' + @Country + ':' + CAST(@AvgScore AS NVARCHAR);

SELECT
	COUNT(OrderID) TotalOrders,
	SUM(Sales) TotalSales
FROM Sales.Orders o
JOIN Sales.Customers c
ON c.CustomerID = o.CustomerID
WHERE c.Country = @Country;

END

EXEC GetCustomerSummary @Country = 'Germany'


-- CONTROL FLOW (IF/ELSE)

-- Imagine we need to handling nulls
-- handle nulls before aggregating to ensure accurate results
ALTER PROCEDURE GetCustomerSummary @Country NVARCHAR(50) = 'USA' AS
BEGIN
	
DECLARE @TotalCustomers	INT, @AvgScore FLOAT;
-- Prepare and cleanup data

-- Condition is check if there are any nulls in scores

IF EXISTS (SELECT 1 FROM Sales.Customers WHERE Score IS NULL AND Country = @Country)
BEGIN
	PRINT('Updating NULL Scores to 0');
	UPDATE Sales.Customers
	SET Score = 0
	WHERE Score IS NULL AND Country = @Country;
END

ELSE
BEGIN
	PRINT('No NULL Scores Found')
END;

	
SELECT
	@TotalCustomers = COUNT(*),
	@AvgScore = AVG(Score)
FROM Sales.Customers
WHERE Country = @Country;

PRINT 'Total Customers from ' + @Country + ':' + CAST(@TotalCustomers AS NVARCHAR);
PRINT 'Average score from ' + @Country + ':' + CAST(@AvgScore AS NVARCHAR);

SELECT
	COUNT(OrderID) TotalOrders,
	SUM(Sales) TotalSales
FROM Sales.Orders o
JOIN Sales.Customers c
ON c.CustomerID = o.CustomerID
WHERE c.Country = @Country;

END

EXEC GetCustomerSummary @Country = 'USA'



-- Error handling
ALTER PROCEDURE GetCustomerSummary @Country NVARCHAR(50) = 'USA' 
AS
BEGIN
DECLARE @TotalCustomers	INT, @AvgScore FLOAT;

IF EXISTS (SELECT 1 FROM Sales.Customers WHERE Score IS NULL AND Country = @Country)
BEGIN
	PRINT('Updating NULL Scores to 0');
	UPDATE Sales.Customers
	SET Score = 0
	WHERE Score IS NULL AND Country = @Country;
END

ELSE
BEGIN
	PRINT('No NULL Scores Found')
END;

SELECT
	@TotalCustomers = COUNT(*),
	@AvgScore = AVG(Score)
FROM Sales.Customers
WHERE Country = @Country;

PRINT 'Total Customers from ' + @Country + ':' + CAST(@TotalCustomers AS NVARCHAR);
PRINT 'Average score from ' + @Country + ':' + CAST(@AvgScore AS NVARCHAR);

SELECT
	COUNT(OrderID) TotalOrders,
	SUM(Sales) TotalSales,
	1/0
FROM Sales.Orders o
JOIN Sales.Customers c
ON c.CustomerID = o.CustomerID
WHERE c.Country = @Country;

END

EXEC GetCustomerSummary;

-- error: SQL Error [8134] [S0001]: Divide by zero error encountered.
-- solving:
ALTER PROCEDURE GetCustomerSummary @Country NVARCHAR(50) = 'USA' 
AS
BEGIN
BEGIN TRY -- first step
DECLARE @TotalCustomers	INT, @AvgScore FLOAT;

IF EXISTS (SELECT 1 FROM Sales.Customers WHERE Score IS NULL AND Country = @Country)
BEGIN
	PRINT('Updating NULL Scores to 0');
	UPDATE Sales.Customers
	SET Score = 0
	WHERE Score IS NULL AND Country = @Country;
END

ELSE
BEGIN
	PRINT('No NULL Scores Found')
END;

SELECT
	@TotalCustomers = COUNT(*),
	@AvgScore = AVG(Score)
FROM Sales.Customers
WHERE Country = @Country;

PRINT 'Total Customers from ' + @Country + ':' + CAST(@TotalCustomers AS NVARCHAR);
PRINT 'Average score from ' + @Country + ':' + CAST(@AvgScore AS NVARCHAR);

SELECT
	COUNT(OrderID) TotalOrders,
	SUM(Sales) TotalSales,
	1/0
FROM Sales.Orders o
JOIN Sales.Customers c
ON c.CustomerID = o.CustomerID
WHERE c.Country = @Country;

END TRY
BEGIN CATCH
	PRINT('An Error ocurred.');
	PRINT('Error Message: ' + ERROR_MESSAGE());
	PRINT('Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR));
	PRINT('Error Line: ' + CAST(ERROR_LINE() AS NVARCHAR));
PRINT('Error procedure ' + ERROR_PROCEDURE());
END CATCH
END

EXEC GetCustomerSummary;





-- Styling
-- how organize an store procedure
-- TAB and Comments
ALTER PROCEDURE GetCustomerSummary @Country NVARCHAR(50) = 'USA' AS
    
BEGIN
    BEGIN TRY
        -- Declare Variables
        DECLARE @TotalCustomers INT, @AvgScore FLOAT;     

        /* --------------------------------------------------------------------------
           Prepare & Cleanup Data
        -------------------------------------------------------------------------- */

        IF EXISTS (SELECT 1 FROM Sales.Customers WHERE Score IS NULL AND Country = @Country)
        BEGIN
            PRINT('Updating NULL Scores to 0');
            UPDATE Sales.Customers
            SET Score = 0
            WHERE Score IS NULL AND Country = @Country;
        END
        ELSE
        BEGIN
            PRINT('No NULL Scores found');
        END;

        /* --------------------------------------------------------------------------
           Generating Reports
        -------------------------------------------------------------------------- */
        SELECT
            @TotalCustomers = COUNT(*),
            @AvgScore = AVG(Score)
        FROM Sales.Customers
        WHERE Country = @Country;

        PRINT('Total Customers from ' + @Country + ':' + CAST(@TotalCustomers AS NVARCHAR));
        PRINT('Average Score from ' + @Country + ':' + CAST(@AvgScore AS NVARCHAR));

        SELECT
            COUNT(OrderID) AS TotalOrders,
            SUM(Sales) AS TotalSales,
            1/0 AS FaultyCalculation  -- Intentional error for demonstration
        FROM Sales.Orders AS o
        JOIN Sales.Customers AS c
            ON c.CustomerID = o.CustomerID
        WHERE c.Country = @Country;
    END TRY
    BEGIN CATCH
        /* --------------------------------------------------------------------------
           Error Handling
        -------------------------------------------------------------------------- */
        PRINT('An error occurred.');
        PRINT('Error Message: ' + ERROR_MESSAGE());
        PRINT('Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR));
        PRINT('Error Severity: ' + CAST(ERROR_SEVERITY() AS NVARCHAR));
        PRINT('Error State: ' + CAST(ERROR_STATE() AS NVARCHAR));
        PRINT('Error Line: ' + CAST(ERROR_LINE() AS NVARCHAR));
        PRINT('Error Procedure: ' + ISNULL(ERROR_PROCEDURE(), 'N/A'));
    END CATCH;
END
GO

--Execute Stored Procedure
EXEC GetCustomerSummary @Country = 'Germany';
EXEC GetCustomerSummary @Country = 'USA';
EXEC GetCustomerSummary;















