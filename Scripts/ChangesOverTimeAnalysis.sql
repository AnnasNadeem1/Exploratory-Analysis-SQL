select datetrunc(month,order_date) as order_date,
sum(sales_amount) as total_sales,
count(distinct customer_key) as total_customers,
sum(quantity) as total_quantity
from gold.fact_sales
where order_date IS NOT NULL
group by datetrunc(month,order_date)
order by datetrunc(month,order_date);