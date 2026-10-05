-- SQL INDEXES
-- Data structure provides quick acess to data,
-- optimizing the speed of your queries

-- CLustered vs. non-clustered

-- copy
SELECT *
INTO Sales.DBCustomers
FROM Sales.Customers

-- But DBCustomers dont have any indexes like Sales.Customers

-- Create it:
CREATE CLUSTERED INDEX idx_DBCustomers_CustomerID
ON Sales.DBCustomers (CustomerID)

-- RULE: Only One Clustered index can be created per table
CREATE CLUSTERED INDEX idx_DBCustomers_CustomerID
ON Sales.DBCustomers (FirstName)

-- SQL Error [1913] [S0001]: The operation failed because an index or statistics with name 'idx_DBCustomers_CustomerID' already exists on table 'Sales.DBCustomers'.

-- so:
DROP INDEX idx_DBCustomers_CustomerID ON Sales.DbCustomers

-- then:
CREATE CLUSTERED INDEX idx_DBCustomers_CustomerID
ON Sales.DBCustomers (FirstName)

-- test:
SELECT *
FROM Sales.DBCustomers
WHERE FirstName = 'Kevin'

-- this will be more slowly because dont have a indexes
SELECT *
FROM Sales.DBCustomers
WHERE LastName = 'Goldberg'


-- so we can
CREATE NONCLUSTERED INDEX idx_DBCustomers_LastName
ON Sales.DBCustomers (LastName)

DROP INDEX idx_DBCustomers_LastName ON Sales.DbCustomers

SELECT *
FROM Sales.DBCustomers
WHERE LastName = 'Goldberg'




-- ROWSTORE vs . COLUMNSTORE

CREATE CLUSTERED COLUMNSTORE INDEX idx_DBCustomers_CS
ON Sales.DBCustomers

DROP INDEX [idx_DBCustomers_CustomerID] ON Sales.DBCustomers

CREATE NONCLUSTERED COLUMNSTORE INDEX idx_DBCustomers_CS
ON Sales.DBCustomers (FirstName)



-- UNIQUE INDEX
SELECT * FROM Sales.Products

CREATE UNIQUE NONCLUSTERED INDEX idx_Products_Category
ON Sales.Products (Category)


-- UNIQUE INDEX
SELECT * 
FROM Sales.Customers
WHERE Country = 'USA'


CREATE NONCLUSTERED INDEX idx_Customers_Country
ON Sales.Customers (Country)
WHERE Country = 'USA'


-- if we executed:
SELECT * 
FROM Sales.Customers
WHERE Country = 'Germany'
-- More slowly


-- INDEX MANAGEMENT

-- Monitor Index usage
-- #1 List all indexes on a specific table

sp_helpindex 'Sales.DBCustomers'

-- #2 Monitoring Index usage

SELECT * FROM sys.indexes

SELECT 
	tbl.name AS IndexName,
	idx.type_desc AS IndexType,
	idx.is_primary_key AS IsPrimaryKey,
	idx.is_unique AS IsUnique,
	idx.is_disabled AS IsDisabled
FROM sys.indexes idx
JOIN sys.tables tbl
ON idx.object_id = tbl.object_id 
ORDER BY tbl.name, idx.name


-- Monitor missing indexes
SELECT
	fs.SalesOrderNumber,
	dp.EnglishProductName,
	dp.Color
FROM FactInternetSales fs
INNER JOIN DimProduct dp
ON fs.ProductKey = dp.ProductKey
WHERE dp.Color = 'Black'
AND fs.OrderDateKey BETWEEN 2020229 AND 20101231

SELECT * FROM sys.dm_db_missing_index_details


-- Monitor Duplicate Indexes
SELECT  
	tbl.name AS TableName,
	col.name AS IndexColumn,
	idx.name AS IndexName,
	idx.type_desc AS IndexType,
	COUNT(*) OVER (PARTITION BY  tbl.name , col.name ) ColumnCount
FROM sys.indexes idx
JOIN sys.tables tbl ON idx.object_id = tbl.object_id
JOIN sys.index_columns ic ON idx.object_id = ic.object_id AND idx.index_id = ic.index_id
JOIN sys.columns col ON ic.object_id = col.object_id AND ic.column_id = col.column_id
ORDER BY ColumnCount DESC


-- update Statistics
SELECT 
    SCHEMA_NAME(t.schema_id) AS SchemaName,
    t.name AS TableName,
    s.name AS StatisticName,
    sp.last_updated AS LastUpdate,
    DATEDIFF(day, sp.last_updated, GETDATE()) AS LastUpdateDay,
    sp.rows AS 'Rows',
    sp.modification_counter AS ModificationsSinceLastUpdate
FROM sys.stats AS s
JOIN sys.tables AS t
    ON s.object_id = t.object_id
CROSS APPLY sys.dm_db_stats_properties(s.object_id, s.stats_id) AS sp
ORDER BY sp.modification_counter DESC;

-- Update statistics for a specific automatically created system statistic
UPDATE STATISTICS Sales.DBCustomers _WA_Sys_00000001_6EF57B66;
GO

-- Update all statistics for the Sales.DBCustomers table
UPDATE STATISTICS Sales.DBCustomers;
GO

-- Update statistics for all tables in the database
EXEC sp_updatestats;
GO


-- Fragmentations
-- Retrieve index fragmentation statistics for the current database
SELECT 
    tbl.name AS TableName,
    idx.name AS IndexName,
    s.avg_fragmentation_in_percent,
    s.page_count
FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, 'LIMITED') AS s
INNER JOIN sys.tables tbl 
    ON s.object_id = tbl.object_id
INNER JOIN sys.indexes AS idx 
    ON idx.object_id = s.object_id
    AND idx.index_id = s.index_id
ORDER BY s.avg_fragmentation_in_percent DESC;

-- Reorganize the index (lightweight defragmentation)
ALTER INDEX idx_Customers_CS_Country 
ON Sales.Customers REORGANIZE;
GO

-- Rebuild the index (full rebuild, more resource-intensive)
ALTER INDEX idx_Customers_Country 
ON Sales.Customers REBUILD;
GO








