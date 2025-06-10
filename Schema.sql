CREATE DATABASE supply_chain_db;
USE supply_chain_db;
CREATE TABLE supply_chain_orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id VARCHAR(20),
    order_date DATE,
    ship_date DATE,
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    region VARCHAR(50),
    product_category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name VARCHAR(100),
    sales DECIMAL(10,2),
    quantity INT,
    discount DECIMAL(4,2),
    profit DECIMAL(10,2),
    shipping_cost DECIMAL(10,2),
    delivery_status VARCHAR(20),
    warehouse VARCHAR(50)
);






