-- SET operators
-- UNION

-- The same number of columns and data types in each queries (rules 2 and 3)

SELECT
	c.FirstName,
	c.LastName 
FROM sales.Customers as c

UNION

SELECT
	e.FirstName,
	e.LastName 
FROM sales.Employees as e;

-- The opossite...
-- Error
SELECT
	c.CustomerID,
	c.LastName 
FROM sales.Customers as c

UNION

SELECT
	e.FirstName,
	e.LastName 
FROM sales.Employees as e;


-- the same datatypes...
SELECT
	c.CustomerID,
	c.LastName 
FROM sales.Customers as c

UNION

SELECT
	e.EmployeeID ,
	e.LastName 
FROM sales.Employees as e;

-- More errors...
SELECT
	c.LastName, 
	c.CustomerID
FROM sales.Customers as c

UNION

SELECT
	e.EmployeeID,
	e.LastName
FROM sales.Employees as e;


-- 5 Rule, the name from first query
SELECT
	c.FirstName as FN,
	c.LastName 
FROM sales.Customers as c

UNION

SELECT
	e.FirstName,
	e.LastName as lastename
FROM sales.Employees as e;

-- Correct
SELECT
	c.FirstName as FN,
	c.LastName as LN
FROM sales.Customers as c

UNION

SELECT
	e.FirstName,
	e.LastName
FROM sales.Employees as e;


-- 6 rule: Mapping correct columns
-- Bad example:
SELECT
	c.FirstName,
	c.LastName
FROM sales.Customers as c

UNION

SELECT
	e.LastName,
	e.FirstName
FROM sales.Employees as e;
-- it works, but it is wrong and causes a big confusing



-- Explain this rules...
-- SET OPERATORS

-- UNION: Returns all distinct rows from both queries | removes duplicate rows from the result


-- TASK: Combine the data from employees and customers into one table
SELECT
	e.FirstName,
	e.LastName 
FROM sales.Employees as e

UNION

SELECT
	c.FirstName,
	c.LastName 
FROM sales.customers as c;

-- in example, mary is not duplicate in this SET



-- UNION ALL: Returns all rows from both queries, including duplicates
-- Generaly faster than union

-- TASK: Combine the data from employees and customers into one table, including duplicates


SELECT
	e.FirstName,
	e.LastName 
FROM sales.Employees as e

UNION ALL

SELECT
	c.FirstName,
	c.LastName 
FROM sales.customers as c;


-- EXCEPT Returns all distinct rows from the first query
-- that are not found in the second query

-- TASK: Find employees who are not customers at the same time
SELECT
	e.FirstName,
	e.LastName 
FROM sales.Employees as e

EXCEPT

SELECT
	c.FirstName,
	c.LastName 
FROM sales.customers as c;

-- the order of queries affect the result
SELECT
	c.FirstName,
	c.LastName 
FROM sales.customers as c

EXCEPT

SELECT
	e.FirstName,
	e.LastName 
FROM sales.Employees as e;



-- INTERSECT: Returns only the rows that are common in both queries
-- Remove duplicates

-- TASK: Find employees, who are also customers.
SELECT
	e.FirstName,
	e.LastName 
FROM sales.Employees as e

INTERSECT

SELECT
	c.FirstName,
	c.LastName 
FROM sales.customers as c;




-- UNION CASES
-- COMBINE INFORMATION: Combine similar information before analyzing the data

-- TASK: Orders are Stored in separate tables (Orders and OrdersArchive).
-- Combine all orders data into one report without duplicates.
SELECT * FROM sales.Orders
UNION
SELECT * FROM sales.OrdersArchive;


-- BEST PRACTICE: never use an asterisk * to combine tables; list needed columns instead
SELECT 
	OrderID, ProductID, CustomerID, SalesPersonID, OrderDate, ShipDate, OrderStatus, ShipAddress, BillAddress, Quantity, Sales, CreationTime
FROM sales.Orders
UNION
SELECT
	OrderID, ProductID, CustomerID, SalesPersonID, OrderDate, ShipDate, OrderStatus, ShipAddress, BillAddress, Quantity, Sales, CreationTime
FROM sales.OrdersArchive;

-- Copy by command: right click on table, click "generate SQL", then "SELECT"


-- To know the source of each data:
SELECT 
	'Orders' as SourceTable,
	OrderID, ProductID, CustomerID, SalesPersonID, OrderDate, ShipDate, OrderStatus, ShipAddress, BillAddress, Quantity, Sales, CreationTime
FROM sales.Orders
UNION
SELECT
	'OrdersArchive' as SourceTable,
	OrderID, ProductID, CustomerID, SalesPersonID, OrderDate, ShipDate, OrderStatus, ShipAddress, BillAddress, Quantity, Sales, CreationTime
FROM sales.OrdersArchive
ORDER BY OrderID;

