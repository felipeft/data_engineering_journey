-- Starting DDl
-- Data Definition Language
-- CREATE, ALTER, DROP

-- Task: Create a new table called 'persons' 
-- with collums: id, person_name, birth_date, phone


CREATE TABLE persons (
	id INT NOT NULL,
	person_name VARCHAR(50) NOT NULL,
	birth_date DATE,
	phone VARCHAR(15) NOT NULL,
	CONSTRAINT pk_persons PRIMARY KEY (id)		-- necessary to link with another tables
)


SELECT *
FROM persons




-- ALTER
-- task: add a new column called email to the person table

ALTER TABLE persons
	ADD email varchar(50) NOT NULL
	

-- task: remove the column phone from the person table
	

ALTER TABLE persons
DROP COLUMN phone


-- DROP
-- task: delete the table 'persons' from the database

DROP TABLE persons



