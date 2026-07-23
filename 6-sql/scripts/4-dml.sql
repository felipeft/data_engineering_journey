-- DML
-- INSERT, UPDATE, DELETE

/* #1 Method: Manual INSERT using VALUES */
-- Insert new records into the customers table
INSERT INTO customers (id, first_name, country, score)
VALUES 
    (6, 'Anna', 'USA', NULL),
    (7, 'Sam', NULL, 100)

-- Incorrect column order 
INSERT INTO customers (id, first_name, country, score)
VALUES 
    (8, 'Max', 'USA', NULL)
    
-- Incorrect data type in values
INSERT INTO customers (id, first_name, country, score)
VALUES 
	('Max', 9, 'Max', NULL)

-- Insert a new record with full column values
INSERT INTO customers (id, first_name, country, score)
VALUES (8, 'Max', 'USA', 368)

-- Insert a new record without specifying column names (not recommended)
INSERT INTO customers 
VALUES 
    (9, 'Andreas', 'Germany', NULL)
    
-- Insert a record with only id and first_name (other columns will be NULL or default values)
INSERT INTO customers (id, first_name)
VALUES 
    (10, 'Sahra')
    
    
SELECT *
FROM customers 


/* #2 Method: Manual INSERT using SELECT */

-- copy data from 'customers' table into 'persons'

-- create again
CREATE TABLE persons (
	id INT NOT NULL,
	person_name VARCHAR(50) NOT NULL,
	birth_date DATE,
	phone VARCHAR(15) NOT NULL,
	CONSTRAINT pk_persons PRIMARY KEY (id)		-- necessary to link with another tables
)


-- do the task

SELECT * FROM customers

-- is the same to make a copy to customers for persons

SELECT 
	id,
	first_name,			-- person name
	NULL,				-- birth date
	'Unknown'			-- phone
FROM customers

-- insert

INSERT INTO persons (id, person_name, birth_date, phone)
SELECT 
	id,
	first_name,			-- person name
	NULL,				-- birth date
	'Unknown'			-- phone
FROM customers


SELECT * FROM persons 



-- UPDATE
-- when we needs to change only a value inside a row
-- always uses WHERE for this 


-- task: change the score of customer with ID 6 to 0
SELECT * FROM customers

--UPDATE customers
--	SET score = 0


-- !!!! DONT RUN THIS
-- the famous update without WHERE
-- ITS will be change all the values 


UPDATE customers
SET score = 0
WHERE id = 6


-- an best practice for this:

SELECT *
FROM customers
WHERE id = 6



-- task: change the score of customer with ID 10 to 0 and update the country to 'UK'


SELECT *
FROM customers
WHERE id = 10


UPDATE customers
SET score = 0,
	country = 'UK'
WHERE id = 10


-- essential task: update all customers with a NULL score by setting their score to 0

SELECT *
FROM customers
WHERE score IS NULL


UPDATE customers
SET score = 0
WHERE score IS NULL


-- DELETE
-- same practices uses in update

-- task: delete all customers with an ID greater than 5

-- best practice
SELECT *
FROM customers
WHERE id > 5



-- lesgo!

DELETE FROM customers
WHERE id > 5



-- task: delete all data from the persons table

--DELETE TABLE persons
-- this command when using in a big table, can be demands more computing power

-- so, for delete all data from the table, we can use TRUNCATE



SELECT * from persons

TRUNCATE TABLE persons
