-- Dimension exploration


-- Explore all countries our customers come from
SELECT DISTINCT country FROM gold.dim_customers

-- Explore all the categories "The major Divisions"
SELECT DISTINCT category, subcategory, product_name FROM gold.dim_products

