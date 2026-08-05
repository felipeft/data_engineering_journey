-- MULTIPLE TABLES

-- INNER JOIN and LEFT JOIN


/* TASK: Using SalesDB, Retrieve a list of all orders, along with the related customer, product, 
   and employee details. For each order, display:
   - Order ID
   - Customer's name
   - Product name
   - Sales amount
   - Product price
   - Salesperson's name */

SELECT
	o.OrderID,
	c.FirstName AS CustomersName,
	p.Product AS ProductName,
	o.Sales AS SalesAmount,
	p.Price AS ProductPrice,
	e.FirstName AS SalesPersonsname
FROM sales.Orders AS o
LEFT JOIN sales.Customers AS  c
ON o.customerID = c.CustomerID 
LEFT JOIN sales.Products AS p
ON o.ProductID = p.ProductID 
LEFT JOIN sales.Employees AS e
ON o.SalesPersonID = e.EmployeeID 



--TESTS
SELECT
o.SalesPersonID 
FROM sales.Orders as o;

SELECT * FROM sales.Employees;

SELECT * FROM sales.Customers;

SELECT * FROM sales.Products;

