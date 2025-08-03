
WITH cateogry_sales AS(
SELECT category,SUM(sales_amount) total_sales
FROM
gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key =p.product_key
GROUP BY category 
)
SELECT category,total_sales,
SUM(total_sales) OVER () as overall_sales,
CONCAT(ROUND((CAST(total_sales AS FLOAT) /SUM(total_sales) OVER())*100,2),'%') as percentage_of_total
FROM cateogry_sales
ORDER BY total_sales DESC