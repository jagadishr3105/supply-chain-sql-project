SELECT COUNT(*) FROM supply_chain_orders;


SELECT product_name, SUM(profit) AS total_profits
FROM supply_chain_orders
GROUP BY product_name
ORDER BY total_profits DESC
LIMIT 5;


SELECT product_name, SUM(quantity) AS product_quantity
FROM supply_chain_orders
GROUP BY product_name
ORDER BY product_quantity DESC
LIMIT 10;


SELECT product_name, SUM(quantity) AS product_quantity
FROM supply_chain_orders
GROUP BY product_name
ORDER BY product_quantity ASC
LIMIT 10;


SELECT product_name, segment, SUM(quantity) AS total_quantity
FROM supply_chain_orders
GROUP BY product_name, segment
ORDER BY total_quantity DESC;

SELECT DATE_FORMAT(order_date, '%Y-%m') AS months, SUM(quantity)
FROM supply_chain_orders
GROUP BY months
ORDER BY months ASC;

SELECT delivery_status, SUM(quantity) AS quan
FROM supply_chain_orders
GROUP BY delivery_status
ORDER BY quan;


SELECT delivery_status, COUNT(*) AS total_orders
FROM supply_chain_orders
GROUP BY delivery_status
ORDER BY total_orders;


SELECT product_name, SUM(profit) AS profits
FROM supply_chain_orders
GROUP BY product_name
ORDER BY profits DESC;

SELECT product_name, SUM(sales) AS total_sales, SUM(profit) AS profits
FROM supply_chain_orders
GROUP BY product_name
ORDER BY profits DESC;


SELECT region, SUM(sales) AS total_sales, SUM(profit) AS total_profits
FROM supply_chain_orders
GROUP BY region
ORDER BY total_profits DESC;

SELECT warehouse, product_category, segment, 
       SUM(sales) AS total_sales, 
       SUM(profit) AS total_profits
FROM supply_chain_orders
GROUP BY warehouse, product_category, segment
ORDER BY total_profits DESC;


SELECT warehouse, 
       COUNT(order_id) AS total_orders, 
       SUM(quantity) AS total_units_shipped, 
       SUM(sales) AS total_sales, 
       SUM(profit) AS total_profit
FROM supply_chain_orders
GROUP BY warehouse
ORDER BY total_profit DESC;

SELECT warehouse, 
       AVG(DATEDIFF(ship_date, order_date)) AS avg_leadtime
FROM supply_chain_orders
GROUP BY warehouse
ORDER BY avg_leadtime DESC;



SELECT warehouse,
       COUNT(*) AS total_orders,
       COUNT(CASE WHEN delivery_status = 'On Time' THEN 1 END) AS on_time_orders,
       COUNT(CASE WHEN delivery_status = 'On Time' THEN 1 END) * 100.0 / COUNT(*) AS on_time_rate
FROM supply_chain_orders
GROUP BY warehouse
ORDER BY on_time_rate DESC;


SELECT 
    warehouse,
    COUNT(*) AS total_orders,
    SUM(quantity) AS total_units_shipped,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    AVG(DATEDIFF(ship_date, order_date)) AS avg_lead_time,
    COUNT(CASE WHEN delivery_status = 'On Time' THEN 1 END) * 100.0 / COUNT(*) AS on_time_rate
FROM supply_chain_orders
GROUP BY warehouse
ORDER BY total_profit DESC;

CREATE TABLE region_avg_profit (
    region VARCHAR(50),
    avg_profit DECIMAL(10,2)
);

INSERT INTO region_avg_profit (region, avg_profit) VALUES 
('East', 100.00),
('West', 90.00),
('South', 80.00),
('Central', 110.00);


SELECT sc.order_id, sc.region, sc.quantity, sc.profit, rap.avg_profit
FROM supply_chain_orders AS sc
LEFT JOIN region_avg_profit AS rap
  ON sc.region = rap.region
WHERE sc.profit > rap.avg_profit
  AND sc.quantity >= 5
ORDER BY sc.profit DESC;


SELECT sc.order_id, sc.region, sc.profit, rap.avg_profit
FROM supply_chain_orders AS sc
LEFT JOIN region_avg_profit AS rap
  ON sc.region = rap.region
WHERE sc.profit < rap.avg_profit;


SELECT sc.order_id, sc.region, sc.profit, rap.avg_profit
FROM supply_chain_orders AS sc
INNER JOIN region_avg_profit AS rap
  ON sc.region = rap.region;

SELECT rap.region, sc.order_id, sc.profit
FROM supply_chain_orders AS sc
RIGHT JOIN region_avg_profit AS rap
  ON sc.region = rap.region
WHERE sc.order_id IS NULL;


SELECT
  order_id,
  region,
  profit,
  AVG(profit) OVER (PARTITION BY region) AS regional_avg_profit
FROM supply_chain_orders;

SELECT *
FROM (
  SELECT
    order_id,
    region,
    profit,
    AVG(profit) OVER (PARTITION BY region) AS regional_avg_profit
  FROM supply_chain_orders
) AS sub
WHERE profit < regional_avg_profit;



SELECT
  region,
  product_name,
  SUM(profit) AS total_profit,
  ROW_NUMBER() OVER (
    PARTITION BY region
    ORDER BY SUM(profit) DESC
  ) AS profit_rank
FROM supply_chain_orders
GROUP BY region, product_name;


SELECT
  region,
  product_name,
  SUM(profit) AS total_profit,
  RANK() OVER (
    PARTITION BY region
    ORDER BY SUM(profit) DESC
  ) AS profit_rank
FROM supply_chain_orders
GROUP BY region, product_name;

SELECT *
FROM (
  SELECT
    region,
    product_name,
    SUM(profit) AS total_profit,
    RANK() OVER (
      PARTITION BY region
      ORDER BY SUM(profit) DESC
    ) AS profit_rank
  FROM supply_chain_orders
  GROUP BY region, product_name
) AS ranked
WHERE profit_rank <= 3
ORDER BY region, profit_rank;

SELECT *
FROM (
  SELECT
    region,
    product_name,
    SUM(profit) AS total_profit,
    ROW_NUMBER() OVER (
      PARTITION BY region
      ORDER BY SUM(profit) DESC
    ) AS profit_rank
  FROM supply_chain_orders
  GROUP BY region, product_name
) AS ranked
WHERE profit_rank <= 3
ORDER BY region, profit_rank;


SELECT
  DATE_FORMAT(order_date, '%Y-%m') AS order_month,
  SUM(sales) AS monthly_sales,
  SUM(SUM(sales)) OVER (ORDER BY DATE_FORMAT(order_date, '%Y-%m')) AS running_sales
FROM supply_chain_orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY order_month;

SELECT
  product_category,
  DATE_FORMAT(order_date, '%Y-%m') AS order_month,
  SUM(sales) AS monthly_sales,
  SUM(SUM(sales)) OVER (
    PARTITION BY product_category
    ORDER BY DATE_FORMAT(order_date, '%Y-%m')
  ) AS running_sales
FROM supply_chain_orders
GROUP BY product_category, DATE_FORMAT(order_date, '%Y-%m')
ORDER BY product_category, order_month;


SELECT
  DATE_FORMAT(order_date, '%Y-%m') AS order_month,
  SUM(sales) AS monthly_sales,
  LAG(SUM(sales)) OVER (
    ORDER BY DATE_FORMAT(order_date, '%Y-%m')
  ) AS previous_month_sales,
  SUM(sales) - LAG(SUM(sales)) OVER (
    ORDER BY DATE_FORMAT(order_date, '%Y-%m')
  ) AS sales_change
FROM supply_chain_orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY order_month;

SELECT
  DATE_FORMAT(order_date, '%Y-%m') AS order_month,
  SUM(sales) AS monthly_sales,
  LEAD(SUM(sales)) OVER (
    ORDER BY DATE_FORMAT(order_date, '%Y-%m')
  ) AS next_month_sales,
  LEAD(SUM(sales)) OVER (
    ORDER BY DATE_FORMAT(order_date, '%Y-%m')
  ) - SUM(sales) AS projected_change
FROM supply_chain_orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY order_month;


WITH regional_avg_profit AS (
  SELECT
    region,
    AVG(profit) AS avg_profit
  FROM supply_chain_orders
  GROUP BY region
)
SELECT
  sc.order_id,
  sc.region,
  sc.profit,
  rap.avg_profit
FROM supply_chain_orders AS sc
JOIN regional_avg_profit AS rap
  ON sc.region = rap.region
WHERE sc.profit < rap.avg_profit;




SELECT 'Top Category' AS source, product_category, total_sales
FROM (
    SELECT product_category, SUM(sales) AS total_sales
    FROM supply_chain_orders
    GROUP BY product_category
    ORDER BY total_sales DESC
    LIMIT 3
) AS top_categories

UNION 

SELECT 'Bottom Category' AS source, product_category, total_sales
FROM (
    SELECT product_category, SUM(sales) AS total_sales
    FROM supply_chain_orders
    GROUP BY product_category
    ORDER BY total_sales ASC
    LIMIT 3
) AS bottom_categories;


SELECT
  order_id,
  profit,
  CASE
    WHEN profit >= 100 THEN 'High Profit'
    WHEN profit BETWEEN 0 AND 99.99 THEN 'Moderate Profit'
    ELSE 'Loss'
  END AS profit_category
FROM supply_chain_orders;
