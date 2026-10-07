-- SQL Partitions
-- Divides big table into smaller partitions
-- while still being treated on a single logical table

-- #1 Create a Partition Function
CREATE PARTITION FUNCTION PartitionByYear (DATE)
AS RANGE LEFT FOR VALUES ('2023-12-31', '2024-12-31', '2025-12-31')


-- Query to lists all existing partition function
SELECT 
	name,
	function_id,
	type,
	type_desc,
	boundary_value_on_right
FROM sys.partition_functions

-- #2 Create Filegroups
ALTER DATABASE SalesDB ADD FILEGROUP FG_2023;
ALTER DATABASE SalesDB ADD FILEGROUP FG_2024;
ALTER DATABASE SalesDB ADD FILEGROUP FG_2025;
ALTER DATABASE SalesDB ADD FILEGROUP FG_2026;


-- Remove
ALTER DATABASE SalesDB REMOVE FILEGROUP FG_2023;

-- Query lists all existing filegroups
SELECT *
FROM sys.filegroups 
WHERE type = 'FG'


-- #3 Create data files
-- Add .ndf files to each filegroup
ALTER DATABASE SalesDB ADD FILE
(
	NAME = P_2023,		-- Logical name
	FILENAME = '/var/opt/mssql/data/p_2023.mdf'
) TO FILEGROUP FG_2023;

ALTER DATABASE SalesDB ADD FILE
(
	NAME = P_2024,		-- Logical name
	FILENAME = '/var/opt/mssql/data/p_2024.mdf'
) TO FILEGROUP FG_2024;

ALTER DATABASE SalesDB ADD FILE
(
	NAME = P_2025,		-- Logical name
	FILENAME = '/var/opt/mssql/data/p_2025.mdf'
) TO FILEGROUP FG_2025;

ALTER DATABASE SalesDB ADD FILE
(
	NAME = P_2026,		-- Logical name
	FILENAME = '/var/opt/mssql/data/p_2026.mdf'
) TO FILEGROUP FG_2026;

-- See the directory 
SELECT 
    DB_NAME(database_id) AS [Nome do Banco],
    name AS [Nome Lógico do Arquivo],
    physical_name AS [Caminho Físico]
FROM 
    sys.master_files;


-- #4 Create partition scheme
CREATE PARTITION SCHEME SchemePartitionByYear
AS PARTITION PartitionByYear
TO (FG_2023, FG_2024, FG_2025, FG_2026)

-- 3 boundaries, 4 partitions and 4 filegroups

-- Query lists all partition scheme
SELECT
	ps.name AS PartitionSchemeName,
	pf.name AS PartitionFunctionName,
	ds.destination_id AS PartitionNumber,
	fg.name AS FilegroupName
FROM sys.partition_schemes ps
JOIN sys.partition_functions pf ON ps.function_id = pf.function_id
JOIN sys.destination_data_spaces ds ON ps.data_space_id = ds.partition_scheme_id 
JOIN sys.filegroups fg ON ds.data_space_id = fg.data_space_id



-- #5 Create partitioned table
CREATE TABLE Sales.Orders_Partitioned
( 
	OrderID INT,
	OrderDate DATE,
	Sales INT
) ON SchemePartitionByYear (OrderDate)

-- #6 Insert data into the partitioned table
INSERT INTO Sales.Orders_Partitioned VALUES (1, '2023-05-15', 100);
INSERT INTO Sales.Orders_Partitioned VALUES (2, '2024-07-20', 50);
INSERT INTO Sales.Orders_Partitioned VALUES (3, '2025-12-31', 20);
INSERT INTO Sales.Orders_Partitioned VALUES (4, '2026-01-01', 100);
SELECT * FROM Sales.Orders_Partitioned

-- check for each insert
SELECT 
    p.partition_number AS PartitionNumber,
    f.name AS PartitionFilegroup, 
    p.rows AS NumberOfRows 
FROM sys.partitions p
JOIN sys.destination_data_spaces dds ON p.partition_number = dds.destination_id
JOIN sys.filegroups f ON dds.data_space_id = f.data_space_id
WHERE OBJECT_NAME(p.object_id) = 'Orders_Partitioned';



