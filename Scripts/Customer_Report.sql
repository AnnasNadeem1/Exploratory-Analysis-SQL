CREATE VIEW gold.report_customers AS 
--BASE QUERY--
WITH base_query as(
SELECT f.order_number,
f.product_key,
f.order_date,
f.sales_amount,
f.quantity,
c.customer_key,
c.customer_number,
CONCAT(c.first_name,' ',c.last_name) as customer_name,
DATEDIFF(year,c.birthdate,GETDATE()) as age 
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key=f.customer_key
WHERE order_date IS NOT NULL
)	,
-- Customer - Aggregation --
customer_aggregation AS(
SELECT customer_key,
customer_number,
customer_name,
age,
COUNT(DISTINCT order_number) as total_orders,
SUM(sales_amount) as total_sales,
SUM(quantity) as total_quantity,
COUNT(product_key) as total_products,
MAX(order_date) as last_order_date,
DATEDIFF(month,MIN(order_date),MAX(order_date)) as lifespan
FROM base_query
GROUP BY 
customer_key,
customer_name,
customer_number,
age
)
SELECT customer_key,
customer_name,
customer_number,
age,
CASE
WHEN age<20 THEN 'Under 20'
WHEN age BETWEEN 20 and 29 THEN '20-29'
WHEN age BETWEEN 30 and 39 THEN '30-39'
WHEN age BETWEEN 40 and 49 THEN '40-49'
ELSE '50 and above'
END as age_group,
CASE
WHEN total_sales>5000 AND lifespan>=12 THEN 'VIP'
WHEN total_sales<=5000 AND lifespan>=12 THEN 'Regular'
ELSE 'New'
END AS customer_segment,
last_order_date,
DATEDIFF(month,last_order_date,GETDATE()) as recency,
total_orders,
total_sales,
total_quantity,
total_products,
lifespan,
-- Compute Average Order Value AVO --
 CASE WHEN total_sales= 0 THEN 0
ELSE total_sales / total_orders	
END as avg_order_value,
-- Average monthly spend --
 CASE WHEN lifespan= 0 THEN total_sales
 ELSE total_sales/lifespan
 END as avg_monthly_spend

from customer_aggregation