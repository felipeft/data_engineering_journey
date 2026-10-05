-- TRIGGERS
-- Special stored procedures that automatically runs in response to a specific event on a table or view

CREATE TABLE Sales.EmployeeLogs (
	LogID INT IDENTITY (1,1) PRIMARY KEY,
	EmployeeID INT,
	LogMessage VARCHAR (255),
	LogDate DATE
)

-- Create triggner on employees table
CREATE TRIGGER trg_AfterInsertEmployee ON Sales.Employees
AFTER INSERT
AS
BEGIN
	INSERT INTO Sales.EmployeeLogs (EmployeeID, LogMessage, LogDate)
	SELECT
		EmployeeID,
		'New Employee Added = ' + CAST(EmployeeID AS VARCHAR),		-- LogMessage
		GETDATE()													-- LogDate
	FROM INSERTED			-- Virtual table thats holds a copy of rows that are being inserted into the target table
END

-- Now, Insert new Data into employees


SELECT * FROM Sales.Employees

INSERT INTO Sales.Employees
VALUES
(6, 'Maria', 'Doe', 'HR', '1988-01-12', 'F', 80000, 3)

SELECT * FROM Sales.EmployeeLogs








