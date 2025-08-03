#  SQL Data Exploration Project

This project showcases advanced SQL techniques used to perform a complete data exploration pipeline on sales, customer, and product datasets. It mimics real-world data analyst workflows and aligns with industry best practices for structured, efficient, and insightful SQL-based reporting.

---

## 📦 Dataset Overview

The project uses three core datasets in a star schema structure:

### `gold.fact_sales`
Sales transactions data with:
- `order_number`, `order_date`, `sales_amount`, `quantity`
- `customer_key`, `product_key`
- `unit_price`, `shipping_date`

### `gold.dim_customers`
Customer information including:
- `customer_key`, `customer_number`
- `first_name`, `last_name`, `gender`, `birthdate`
- `marital_status`

### `gold.dim_products`
Product metadata such as:
- `product_key`, `product_name`
- `category`, `subcategory`
- `cost`, `maintenance_required`

---

## 🔍 Exploratory Modules

### 1. 📈 Changes Over Time
Tracked monthly trends in:
- Total sales
- Number of customers
- Quantity sold

### 2. 💰 Cost Segmentation
Segmented products by their cost into:
- Below 100
- 100–500
- 500–1000
- Above 1000

### 3. 📊 Cumulative Aggregations
- Running total sales and average price (year-over-year)
- Used `SUM OVER` and `AVG OVER`

### 4. 👥 Customer Segmentation
Grouped customers into:
- `VIP`: Spend > 5000 and lifespan ≥ 12 months  
- `Regular`: Spend ≤ 5000 and lifespan ≥ 12 months  
- `New`: Others  
Also calculated:
- Recency
- Total orders
- Average Order Value (AOV)
- Average Monthly Spend

### 5.  Part-to-Whole Analysis
- Category-wise contribution to total sales  
- Expressed as a percentage of overall revenue

### 6.  Performance Analysis
For each product-year combination:
- Compared yearly sales to the average sales
- Measured YoY changes using `LAG()`
- Classified performance as `Above`, `Below`, or `Avg`

---

##  Final Reports

###  `gold.report_customers`
View that consolidates:
- Customer demographics (age, segment)
- KPIs (recency, lifespan, AOV, avg monthly spend)

###  `gold.report_products`
Product-level report with:
- Sales and order metrics
- Performance segment (High-Performer, Mid-Range, Low-Performer)
- Recency, lifespan, AOR, and monthly revenue

---

## SQL Features Used

- Common Table Expressions (`WITH`)
- Aggregate Functions: `SUM`, `COUNT`, `AVG`, `MAX`, `DATEDIFF`
- Window Functions: `SUM() OVER`, `LAG()`, `AVG() OVER`
- Conditional Logic: `CASE` statements
- Joins (fact-dim relationship)
- Views (`CREATE VIEW`) for modular outputs

---

## 🚀 How to Use

1. Load the three CSV datasets into your SQL environment as:
   - `gold.fact_sales`
   - `gold.dim_customers`
   - `gold.dim_products`

2. Run the queries (available in `Scripts`) in sequence:
   - Exploratory modules
   - Customer and product reports

3. Query the final views:
   - `SELECT * FROM gold.report_customers;`
   - `SELECT * FROM gold.report_products;`

---

##  Future Enhancements

- Integrate this SQL pipeline into a BI tool like Power BI or Looker
- Automate monthly data refreshes
- Add predictive churn or lifetime value models
- Deploy customer and product dashboards

---

##  Author

**Muhammad Annas**  
[devwithannas.hashnode.dev](https://devwithannas.hashnode.dev)

---



---


