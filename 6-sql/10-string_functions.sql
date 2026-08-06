-- SQL FUNCTIONS

-- SINGLE ROWS FUNCTIONS
/* 
		String
		Numeric
		Date & Time
		NULL 
*/

-- STRING FUNCTIONS
/*
	Manipulation
	Calculation
	String extract
*/

-- MANIPULATION
-- CONCAT: Combines multiple strings into one

-- TASK: Concatenate first name and country into one column
SELECT
	first_name,
	country,
	CONCAT(first_name, ' ' , country) AS name_country
FROM customers


-- UPPER: converts all caracters to uperrcase
-- LOWER: converts all caracters to lowercase

-- TASK: convert the first name to lowercase and the same first name to uppercase
SELECT
	first_name,
	LOWER(first_name) AS first_name_low,
	UPPER(first_name) AS first_name_up
FROM customers

-- TRIM: Removes leading and trailing spaces

-- TASK: Find customers whose first name contains leading or trailing spaces
SELECT
	first_name,
	LEN(first_name) len_name,
	LEN(TRIM(first_name)) AS len_trim_name, 
	LEN(first_name) - LEN(TRIM(first_name)) AS flag
FROM
	customers
WHERE LEN(first_name) != LEN(TRIM(first_name))
-- WHERE first_name != TRIM(first_name)


-- REPLACE: Replaces specific character with a nwe character

-- EX: Removes dashes (-) from a phone number

SELECT
	'123-456-7890' AS phone,
	REPLACE('123-456-7890', '-', '') AS clean_phone
	
-- Repalce file exence from txt to csv
SELECT 
	'report.txt' AS old_file,
	REPLACE('report.txt', '.txt', '.csv') AS new_filename


-- CALCULATION
-- LEN: counts how many characters
	
-- TASK: Calculate the lenght of each customers first name
SELECT
	first_name,
	LEN(first_name) AS first_name_size
FROM customers


-- STRING EXTRACT
-- LEFT: Extract specific number of characters from the start
-- RIGHT: Extract specific number of characters from the END


-- TASK: Retrieve the first and last two characters of each first name
SELECT
	first_name,
	LEFT(TRIM(first_name), 2) AS two_first_char,
	RIGHT(TRIM(first_name), 2) AS two_last_char
FROM customers


-- SUBSTRING: Extracts a part of string at a specified position

-- TASK: Retrieve a list of customers first names removing the first character
SELECT 
	first_name,
	SUBSTRING(TRIM(first_name), 2, LEN(first_name)) AS uncomplete_name
FROM customers

