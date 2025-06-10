# Supply Chain SQL Analytics Project

This project uses advanced SQL techniques to analyze supply chain order data and extract meaningful business insights. The dataset simulates a real-world e-commerce environment, containing information about orders, profits, delivery timelines, and product categories.

---

## Dataset

- **File:** `supply_chain_orders.csv`
- **Records:** E-commerce orders with fields such as `order_date`, `product_name`, `region`, `sales`, `profit`, `quantity`, `warehouse`, `delivery_status`, and more.


---

##  Tools & Technologies

- **SQL (MySQL Workbench)**
- **GitHub** (project repository)
- **Excel / CSV** (for data ingestion)

---

##  Key SQL Concepts Practiced

- `GROUP BY`, `ORDER BY`, `LIMIT`, `WHERE`
- Aggregate functions: `SUM()`, `AVG()`, `COUNT()`
- Filtering: `CASE`, `BETWEEN`, `IN`, `LIKE`
- Joins: `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`
- Subqueries & Common Table Expressions (CTEs)
- Window functions: `ROW_NUMBER()`, `RANK()`, `LAG()`, `LEAD()`
- Date formatting: `DATE_FORMAT()`, `DATEDIFF()`
- Derived columns & custom metrics

---

##  Key Analyses Performed

| Analysis Type | Description |
|---------------|-------------|
|Warehouse Performance | Total orders, sales, and on-time delivery rate per warehouse |
|Regional Profitability | Profit vs. average regional profit using joins and window functions |
|  Product Rankings | Top/Bottom products by quantity, sales, and profit |
|  Lead Time | Average time between order and shipping per warehouse |
| Tiering | Classified orders by profit tiers (High, Moderate, Loss) using `CASE` |


## Business Questions Solved

1. **Which products and segments drive the highest profit and sales?**
2. **Which warehouses are most efficient in terms of shipping volume and on-time delivery rate?**
3. **What is the average lead time from order to shipment per warehouse?**
4. **Region-wise analysis:** profitability and performance
5. **Top vs Bottom performing product categories**
6. **Running monthly sales trends**
7. **Identify underperforming orders below regional average profit**
8. **Rank top 3 profitable products in each region**
9. **Forecast next month's sales using `LEAD()` window function**
10. **Categorize orders based on profit levels using `CASE`**

---

##File Structure

| File Name              | Description                                      |
|------------------------|--------------------------------------------------|
| `schema.sql`           | Table structure, database creation, setup code  |
| `analysis_queries.sql` | All business analysis queries, joins, and KPIs  |
| `supply_chain_orders.csv` | Raw dataset used for this project            |
| `README.md`            | Project overview and documentation              |

---

## Connect With Me

If you find this project insightful or want to collaborate:

- [LinkedIn](https://www.linkedin.com/in/jagadish-ravulapalli/)  
- Feel free to reach out with suggestions or feedback!

---

> *This project is part of my portfolio for applying to roles such as Supply Chain Analyst. Thank you for checking it out!*

