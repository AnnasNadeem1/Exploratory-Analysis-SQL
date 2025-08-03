WITH yearly_product_sales AS(
SELECT YEAR(f.order_date) as order_year,
p.product_name,SUM(f.sales_amount) as current_sales

from gold.fact_sales f
LEFT JOIN 
gold.dim_products p
ON f.product_key=p.product_key
WHERE f.order_date IS NOT NULL
GROUP BY YEAR(f.order_date),
p.product_name
)
SELECT order_year,product_name,current_sales,
AVG(current_sales) OVER (PARTITION BY product_name) as avg_sales,
current_sales - AVG(current_sales) OVER (PARTITION BY product_name) as diff_avg,
CASE 
WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name)>0 THEN 'Above Average'
WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name)<0 THEN 'Below Average'
ELSE 'Avg'
END ,
-- year over year analysis --
LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year)  as py_sales,
current_sales-LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) as diff_py,
CASE 
WHEN current_sales -LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year)>0 THEN 'Increase'
WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year)<0 THEN 'Decrease'
ELSE 'No Change'
END
FROM yearly_product_sales
