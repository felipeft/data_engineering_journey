# SQL

Esta pasta reúne meus estudos de SQL como parte da minha jornada em Engenharia de Dados.

## Observação

Os estudos desta etapa são baseados no curso de SQL disponibilizado pelo canal **Data With Baraa** no YouTube.  
[SQL Full Course for Beginners (30 Hours) – From Zero to Hero](https://youtu.be/SSKVgrwhzus?si=E8VBka-i672vL8rZ)

Alguns scripts presentes nesta pasta (como os scripts de criação dos bancos de dados utilizados nas aulas) foram fornecidos pelo autor do curso e estão sendo utilizados exclusivamente para fins de estudo e prática.

O estudo é realizado mesclando conhecimento teórico com tasks práticas sobre o assunto estudado. Além de revisão sistemática, anotações, comentários nos códigos e etc.

## Progresso

### Dia 1
- Configuração do ambiente (SQL SERVER com Docker e DBeaver).
- Estudo introdutório de DQL.
- Prática com as cláusulas:
  - `SELECT`
  - `FROM`
  - `WHERE`
  - `ORDER BY`


### Dia 2
- Continuação de DQL praticando com as cláusulas:
  - `GROUP BY`
  - `HAVING`
  - `DISTINCT`
  - `TOP`

- Estudo de DQL (CREATE, ALTER, DROP)

- ESTUDO DE DML (INSERT, UPDATE, DELETE )
  - Nunca faça update sem WHERE ou muito menos DELETE/TRUNCATE...


### Dia 3
- Estudo de Filtering Data estudando a fundo cada Where operations
  - `Comparison ops`
  - `Logical ops`
  - `Range ops`
  - `Membership ops`
  - `Search ops`

- Introdução também ao estudo de Combining Data entendendo a diferença entre SET OPERATORS e JOINS
- Estudo completo das Joins Mais básicas e quando devem ser utilizadas (Recombine, enrichement or check existence):
  - `NO JOINS`
  - `INNER JOIN`
  - `LEFT JOIN`
  - `RIGHT JOIN`
  - `FULL JOIN`


## Dia 4

- Estudo de advanced Joins:
  - `LEFT ANTI JOIN`
  - `RIGHT ANTI JOIN`
  - `FULL ANTI JOIN`
  - `CROSS JOIN`

- Decision Tree para saber quando escolher um tipo de JOIN 
- Conceitos e desafio de Multiple Tables com diversas JOINS

## Dia 5

- Estudo de Set Operators
  - `UNION`
  - `UNION ALL`
  - `EXCEPT`
  - `INTERSECT`

- Aprendizado de casos de usos para UNION (combine information) e EXCEPT (Delta detection and Data completness check), além da utilização de boas práticas.

## Dia 6

- Estudo de Funções SQL
- Conhecendo todas as functions
- Divisão entre single-row functions e multi-rows functions

- Estudo de dois grupos de funções single-row:
  - String functions:
    - Manipulation
      - `CONCAT`
      - `UPPER`
      - `LOWER`
      - `TRIM`
      - `REPLACE`
    
    - Calculation
      - `LEN`

    - String extract
      - `LEFT`
      - `RIGHT`
      - `SUBSTRING`

  - Numeric functions:
    - `ROUND`
    - `ABS`

## Dia 7

- Continuação dos estudos de funções single-row
- Estudo completo e detalhado de Date & Time Functions
- Dividas em:
  - PART EXTRACTION
    - `DAY`
    - `MONTH`
    - `YEAR`
    - `DATEPART`
    - `DATENAME`
    - `DATETRUNC`
    - `EOMONTH`
  
  - FORMAT & CASTING
    - `FORMAT`
    - `CONVERT`
    - `CAST`

  - CALCULATIONS
    - `DATEADD`
    - `DATEDIFF`
  
  - VALIDATION
    - `ISDATE`

## Dia 8

- Estudo completo das NULL Functions
- Divididas entre:
  - REPLACE VALUES:
    - `ISNULL`
    - `COALESCE`
    - `NULLIF`

  - BOOLEAN:
    - `ISNULL`
    - `IS NOT NULL`

- NULLS sao carateres especiais que significam 'missing value"
- Utilizar NUlls pode otimizar armazenamento e perfomance
- Diferença entre NULL, EMPTY STRING e BLANK SPACE
- Estudo de 3 Data policies:
  - #1: Only use NULLS and EMPTY STRINGS, but avoid BLANK SPACES
  - #2: Only use NULLS and, avoid using EMPTY STRINGS and BLANK SPACES  
		- `CASE: Optimize storage and perfomance` 
  - #3: Use the Default Value 'unknown' and avoid using NULLS, EMPTY STRINGS and BLANK SPACES  
		- `CASE: Best to using it in reporting to improve readiblity and reduce confusion`


## Dia 9

- Estudo do uso de CASE STATEMENT
- Estudo de 4 casos de usos para case statement:
  - Categorizing Data
  - Mapping Values
  - handling nulls
  - conditional aggregations

## Dia 10

- Estudo de aggregate functions:
  - `COUNT(*)`
  - `SUM()`
  - `AVG()`
  - `MAX()`
  - `MIN()`

## Dia 11

- Estudo básico de Window Functions
- Diferença entre GROUP BY e Window functions e porque ela é mais completa para análises de dados com maior granularidade
- Estudo da sintaxe
  - `Window Func OVER(PARTITION BY ... ORDER BY ... ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)`
- Sintaxe completa da clasula FRAME
  - `ROWS` / `RANGE`
  - `CURRENT ROW` / `N PRECEDING` / `UNBOUNDED PRECEDING`
  - `CURRENT ROW` / `N FOLLOWING` / `UNBOUNDED FOLLOWING`

- Estudo de 4 regras para window functions

## Dia 12

- Estudo das Aggregate Functions de Window functions
  - `COUNT(*)`
  - `SUM(expr)`
  - `AVG(expr)`
  - `MAX(expr)`
  - `MIN(expr)` 

- Comparison cases com `COUNT()`
- Diferença entre Running Total e Rolling total

## Dia 13

- Estudo das Rank Functions de Window Functions
  - Dois tipos:
    - Integer-based-ranking:
      - `ROW_NUMBER()`
      - `RANK()`
      - `DENSE_RANK()`
      - `NTILE()`
    - Percentage-base-ranking:
      - `CUME_DIST()`
      - `PERCENT_RANK()`
  
- Casos de usos também para cada função ou grupos

## Dia 14

- Estudo das Value Window Functions
  - `LEAD()`
  - `LAG()`
  - `FIRST_VALUE()`
  - `LAST_VALUE()`

- Dois Casos de usos particulares para as funções `LEAD()` e `LAG()`:
  - Time series analysis
  - Customer retention analysis  

## Dia 15

- Estudo de tecnicas avançadas de SQL
  - Subquery
  - CTE (Common table expression)
  - Views
  - Temp Tables
  - CTAS (Create table as select)

- Inicio do estudo de subqueries
  - Divisão em 3 categorias:
    1. Dependacy
    2. Result Type
    3. Location | clauses

- Estudo completo da categoria de result type, diferença entre:
  - Scalar subquery
  - Row subquery
  - Table subquery

- Estudo de metade das subqueries de location | clauses
  - `FROM`
  - `SELECT`
  - `JOIN CLAUSE`

## Dia 16

- Continuação dos estudos de Subqueries
 - Estudo de WHERE Clause que pode ser dividida entre:
  - Comparison Operators
    - `=`
    - `!=`
    - `<`
    - `>`
    - `<=`
    - `>=`
  - Logical Operators 
    - `IN`
    - `ANY`; `ALL`
    - `EXISTS`

  - Estudo também da diferença entre as dependências:
    - Non-correlated subquery
    - Correlated subquery
  - Essênciais para o estudo do operator `EXISTS`

## Dia 17

- Estudo completo da técnica de CTE (Common table expression)
- Entendimento dos conceitos básicos
- Diferença entre subquerie
- Tipos de CTEs:
  - Non-recursive CTE
    - Standalone CTE / Multiple Standalone CTE
    - Nested CTE
  - Recursive CTE

- Casos de usos e regras gerais para CTEs

## Dia 18

- Estudo completo da técnica de Views VIEWS
- Funcionamento, Sintaxe e casos de usos:
  - 1. Central query logic
  - 2. Hide complexity
  - 3. Data security
  - 4. Flexibility & Dynamic
  - 5. Multiple languages
  - 6. Virtual data marts in DWH

  # Dia 19

  - Estudo completo de CTAS (Create table as Select)
    - Divisão dos tipos de tabelas:
      - Permanent tables
        - CREATE/INSERT
        - CTAS
      -  Temporary tables

  - Sintaxe das CTAS
  - Casos de usos para cada um dos tipos

# Dia 20

- Estudo das técnicas de Stored Procedure
  - Conceitos
  - Comparação com scripts em python
  - Sintaxe
    - Parameters
    - Multiple statements
    - Variables
    - Cotrol Flow (IF/ELSE)
    - Error handling (Try/Catch)
    - Styling (organização e identação de código)

# Dia 21

- Estudo dá última técnica avançada de SQL: Triggers
- Inico do estudo de Otimizações de perfomance
- Estudo de Indexes
  - Structure
    - Clustered index
    - Non Clustered index
  - Storage
    - Rowstore index
    - Columnstore index
  - Functions
    - Unique index
    - Filtered index

## Dia 22
  - Continuação do estudo de indexes
  - Estudo completo dos indexes de:
  Storage
    - Rowstore index
    - Columnstore index
  - Functions
    - Unique index
    - Filtered index
  - Index management techiniques


# Dia 23
  - Estudo de execution Plan 
  - Conceito de SQL Hints
  - Indexing strategy 
    - Avoid over index
    - #1 Initial indexing strategy
    - #2 Usage patterns indexing
    - #3 Scenario-Based indexing
    - #4 Monitoring & maintenance

# Dia 24

- Estudo das técnicas de partition tables
- Porque usar
- Como construir partitions
  - Partition Functions
  - Filegroups
  - Datafiles
  - Schemes
  - Create partition table
  - insert data into the partitioned table

# Dia 25

- Dicas de perfomance
- 30x perfomance Tips:
  - TIP 1: Select Only what you need
  - TIP 2: Avoid unnecessary DISTINCT & ORDER BY
  - TIP 3: For exploration purpose, Limit rows
  - TIP 4: Create nonclustered index on frequently used columns in WHERE clause
  - TIP 5: Avoid applying functions to columns in WHERE clauses
  - TIP 6: Avoid leading wildcards as they prevent index usage
  - TIP 7: Use IN instead of Multiple OR
  - TIP 8: Understand The Speed of Joins & Use INNER JOIN when possible
  - TIP 9: Use Explicit Join (ANSI Join) Instead of Implicit Join (non-ANSI Join)
  - TIP 10: Make sure to Index the columns used in the ON clause
  - TIP 11: Filter Before Joining (Big Tables)
  - TIP 12: Aggregate Before Joining (Big Tables)
  - TIP 13: Use Union Instead of OR in Joins
  - TIP 14: Check for Nested Loops and Use SQL HINTS
  - TIP 15: Use UNION ALL instead of using UNION | duplicates are acceptable
  - TIP 16: Use UNION ALL + Distinct instead of using UNION | duplicates are not acceptable
  - TIP 17: Use Columnstore Index for Aggregations on Large Table
  - TIP 18: Pre-Aggregate Data and store it in new Table for Reporting
  - TIP 19: JOIN vs EXISTS vs IN (Avoid using IN)
  - TIP 20: Avoid Redundant Logic in Your Query
  - TIP 21: Avoid VARCHAR Data Type If Possible
  - TIP 22: Avoid Using MAX or Overly Large Lengths
  - TIP 23: Use NOT NULL If possible 
  - TIP 24: Make sure all tables have a CLUSTERED PRIMARY KEY
  - TIP 25: Creeate Nonclustered Index on Foreign Key if they are frequently used
  - TIP 26: Avoid Over Indexing, as it can slow down insert, update, and delete operations
  - TIP 27: Regularly review and drop unused indexes to save space and improve write performance
  - TIP 28: Update table statistics weekly to ensure the query optimizer has the most up-to-date information
  - TIP 29: Reorganize and rebuild fragmented indexes weekly to maintain query performance.
  - TIP 30: For large tables (e.g., fact tables), partition the data and then apply a columnstore index for best performance results

# Dia 26

- Estudo de técnicas de utilização de IA como auxilio no desenvolvimento SQL
- Uso do copilot ou github
- SQL AI prompts:
    1. Solve an SQL Task
    2. Improve the Readability
    3. Optimize the Performance Query
    4. Optimize Execution Plan
    5. Debugging
    6. Explain the Result
    7. Styling & Formatting
    8. Documentations & Comments
    9. Improve Database DDL
    10. Generate Test Dataset
    11. Create SQL Course
    12. Understand SQL Concept
    13. Comparing SQL Concepts
    14. SQL Questions with Options
    15. Prepare for a SQL Interview
    16. Prepare for a SQL Exam