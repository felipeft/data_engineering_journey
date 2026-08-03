-- Studies about FILERING DATA


-- Comparison operators

-- Retrieve all customers from germany

SELECT *
FROM customers
WHERE country = 'Germany' 		-- column (op) value


-- Retrieve all customers who are not from Germany

SELECT *
FROM customers
WHERE country <> 'Germany' 		-- column (op) value


-- Retrieve all customers with a score greater than 500



SELECT *
FROM customers
WHERE score > 500 		-- column (op) value


-- Retrieve all customers with a score of 500 or more


SELECT *
FROM customers
WHERE score >= 500 		-- column (op) value


-- Retrieve all customers with a score less than 500

SELECT *
FROM customers
WHERE score < 500 		-- column (op) value


-- Retrieve all customers with a score of 500 or less

SELECT *
FROM customers
WHERE score <= 500 		-- column (op) value




-- Logical operators

-- AND: all conditions must be true

-- Retrieve all customers who are from the USA AND have a score greater than 500

SELECT *
FROM customers
WHERE country = 'USA' AND score > 500


-- OR: At least one condition must be true

-- Retrieve all customers who are either from the USA OR have a score greater than 500


SELECT *
FROM customers
WHERE country = 'USA' OR score > 500


-- NOT: (reverse) excludes matching values (rows)

-- Retrieve all customers with a score NOT less than 500

SELECT *
FROM customers
WHERE NOT score < 500

-- SAME

SELECT *
FROM customers
WHERE score >= 500



-- RANGE OPERATORS

-- BETWEEN: Check if a value is within a range (specific range)


-- Retrieve all customers whose socre falls in the range between 100 and 500

SELECT *
FROM customers
WHERE score BETWEEN 100 AND 500

-- you also can use comparison ops, it is more understandable

SELECT *
FROM customers
WHERE score >= 100 AND score <= 500



-- MEMBERSHIP OPERATOR

-- IN: Check if a value exist in a list


-- Retrieve all customers from either germany or usa

SELECT *
FROM customers
WHERE country = 'Germany' OR country = 'USA'

-- More clear and shorter (like between)

SELECT *
FROM customers
WHERE country IN ('Germany', 'USA')

-- exploring NOT IN
SELECT *
FROM customers
WHERE country NOT IN ('Germany', 'USA')

-- second
SELECT *
FROM customers
WHERE country NOT IN ('UK')


-- SEARCH OPERATOR

-- LIKE: Search for a pattern in text
-- % anithing
-- % _ exact 1

-- Find all customers whose first name starts with 'M'


SELECT *
FROM customers
WHERE first_name LIKE 'M%'

-- Find all customers whose first name ends with 'n'

SELECT *
FROM customers
WHERE first_name LIKE '%n'


-- Find all customers whose first name contains 'r'

SELECT *
FROM customers
WHERE first_name LIKE '%r%'


-- Find all customers whose first name has 'r' in the 3rd position

-- Studies about FILERING DATA


-- Comparison operators

-- Retrieve all customers from germany

SELECT *
FROM customers
WHERE country = 'Germany' 		-- column (op) value


-- Retrieve all customers who are not from Germany

SELECT *
FROM customers
WHERE country <> 'Germany' 		-- column (op) value


-- Retrieve all customers with a score greater than 500



SELECT *
FROM customers
WHERE score > 500 		-- column (op) value


-- Retrieve all customers with a score of 500 or more


SELECT *
FROM customers
WHERE score >= 500 		-- column (op) value


-- Retrieve all customers with a score less than 500

SELECT *
FROM customers
WHERE score < 500 		-- column (op) value


-- Retrieve all customers with a score of 500 or less

SELECT *
FROM customers
WHERE score <= 500 		-- column (op) value




-- Logical operators

-- AND: all conditions must be true

-- Retrieve all customers who are from the USA AND have a score greater than 500

SELECT *
FROM customers
WHERE country = 'USA' AND score > 500


-- OR: At least one condition must be true

-- Retrieve all customers who are either from the USA OR have a score greater than 500


SELECT *
FROM customers
WHERE country = 'USA' OR score > 500


-- NOT: (reverse) excludes matching values (rows)

-- Retrieve all customers with a score NOT less than 500

SELECT *
FROM customers
WHERE NOT score < 500

-- SAME

SELECT *
FROM customers
WHERE score >= 500



-- RANGE OPERATORS

-- BETWEEN: Check if a value is within a range (specific range)


-- Retrieve all customers whose socre falls in the range between 100 and 500

SELECT *
FROM customers
WHERE score BETWEEN 100 AND 500

-- you also can use comparison ops, it is more understandable

SELECT *
FROM customers
WHERE score >= 100 AND score <= 500



-- MEMBERSHIP OPERATOR

-- IN: Check if a value exist in a list


-- Retrieve all customers from either germany or usa

SELECT *
FROM customers
WHERE country = 'Germany' OR country = 'USA'

-- More clear and shorter (like between)

SELECT *
FROM customers
WHERE country IN ('Germany', 'USA')

-- exploring NOT IN
SELECT *
FROM customers
WHERE country NOT IN ('Germany', 'USA')

-- second
SELECT *
FROM customers
WHERE country NOT IN ('UK')


-- SEARCH OPERATOR

-- LIKE: Search for a pattern in text
-- % anithing
-- % _ exact 1

-- Find all customers whose first name starts with 'M'


SELECT *
FROM customers
WHERE first_name LIKE 'M%'

-- Find all customers whose first name ends with 'n'

SELECT *
FROM customers
WHERE first_name LIKE '%n'


-- Find all customers whose first name contains 'r'

SELECT *
FROM customers
WHERE first_name LIKE '__r%'





