select order_date,total_sales,
SUM(total_sales) OVER ( ORDER BY order_date) as running_total_sales,
AVG(avg_price) OVER ( ORDER BY order_date) as running_avg_price

FROM
(select
DATETRUNC(YEAR,order_date) as order_date,
SUM(sales_amount) as total_sales,
AVG(price) as avg_price
from gold.fact_sales
where order_date IS NOT NULL
group by DATETRUNC(YEAR,order_date)
) as sub