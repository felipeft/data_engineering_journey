-- Retrieve all Customer Data

SELECT *

FROM customers

-- Retrieve all orders Data

SELECT *

FROM orders

-- Select an especific colum (first_name and score by customers)

SELECT
	first_name,
	score
from customers

-- Where clausule. find scores higher than 500 only

SELECT *
FROM customers
where score > 500

-- Retrieve customers with a score is not equal to 0

SELECT *
FROM customers 
where score != 0

-- Retrieve customers from germany

SELECT *
FROM customers
WHERE country = 'Germany'


-- order by
-- ASC and DESC (lowest to highest or )


-- Retrieve all customers and sort the result by highest the score first
SELECT *
from customers
order by score desc

-- Retrieve all customers and sort the result by lowest the score first
SELECT *
from customers
order by score

-- the same:

SELECT *
from customers
order by score asc


-- Nested, aninhado (order by)
-- in the example, if we compares the score of the clients from usa, in this country we can view disorganized

-- Retrieve all customers and sort the result by the country and then by the highest score
SELECT *
from customers
order by
	country asc,
	score desc

