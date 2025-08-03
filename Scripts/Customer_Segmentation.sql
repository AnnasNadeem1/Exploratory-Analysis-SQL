WITH customer_spending AS (
SELECT 
c.customer_key,
SUM(f.sales_amount) as total_spend,
MAX(order_date) first_order,
MIN(order_date) last_order,
DATEDIFF(month,MIN(order_date),MAX(order_date)) as lifespan
from gold.fact_sales f

LEFT JOIN gold.dim_customers c
ON f.customer_key=c.customer_key
GROUP BY c.customer_key 
)
SELECT customer_segment,
COUNT(customer_key) as total_customers
FROM (
SELECT customer_key,
total_spend,
lifespan,
CASE WHEN total_spend>5000 AND lifespan>=12 THEN 'VIP'
WHEN total_spend<=5000 AND lifespan>=12 THEN 'Regular'
ELSE 'New'
END customer_segment
FROM customer_spending
) t
 GROUP BY customer_segment
 ORDER BY total_customers DESC
