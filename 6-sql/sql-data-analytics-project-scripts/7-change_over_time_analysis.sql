-- Change over time analysis

SELECT	
	order_date AS order_day,					-- granularity is a day
	SUM(sales_amount) as total_sales 
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY order_date 
ORDER BY order_date

-- to year now
SELECT	
	YEAR(order_date) AS order_year,					-- granularity is a year
	SUM(sales_amount) as total_sales,
	COUNT(DISTINCT customer_key) as total_customers,
	SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date) 
ORDER BY YEAR(order_date)

-- to month now (seasonality)
SELECT	
	MONTH(order_date) AS order_month,					-- granularity is a month
	SUM(sales_amount) as total_sales,
	COUNT(DISTINCT customer_key) as total_customers,
	SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY MONTH(order_date)
ORDER BY MONTH(order_date)
-- in december we have more sales, more customers and more quantity of sales of course...


-- partition by year and months
SELECT	
	YEAR(order_date) AS order_year,					-- granularity is a year
	MONTH(order_date) AS order_month,					-- granularity is a month
	SUM(sales_amount) as total_sales,
	COUNT(DISTINCT customer_key) as total_customers,
	SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY YEAR(order_date), MONTH(order_date)

-- so, we can truncate these two columns
SELECT
    DATETRUNC(month, order_date) AS order_date,
    SUM(sales_amount)            AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity)                AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(month, order_date)
ORDER BY DATETRUNC(month, order_date)


-- Using format to dates
SELECT
    FORMAT(order_date, 'yyyy-MMM') AS order_date,
    SUM(sales_amount)              AS total_sales,
    COUNT(DISTINCT customer_key)   AS total_customers,
    SUM(quantity)                  AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY FORMAT(order_date, 'yyyy-MMM')
ORDER BY FORMAT(order_date, 'yyyy-MMM')

-- trunc is more representative 

