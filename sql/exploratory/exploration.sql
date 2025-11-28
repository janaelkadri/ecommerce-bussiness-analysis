-- Check rows in each table
SELECT 'orders' AS table, COUNT(*) FROM olist_orders_dataset
UNION ALL
SELECT 'order_items', COUNT(*) FROM olist_order_items_dataset
UNION ALL
SELECT 'products', COUNT(*) FROM olist_products_dataset
UNION ALL
SELECT 'customers', COUNT(*) FROM olist_customers_dataset
UNION ALL
SELECT 'sellers', COUNT(*) FROM olist_sellers_dataset
UNION ALL
SELECT 'payments', COUNT(*) FROM olist_order_payments_dataset
UNION ALL
SELECT 'reviews', COUNT(*) FROM olist_order_reviews_dataset
UNION ALL
SELECT 'geolocation', COUNT(*) FROM olist_geolocation_dataset;

-- Preview first 5 rows from core tables
SELECT * FROM olist_orders_dataset LIMIT 5;
SELECT * FROM olist_customers_dataset LIMIT 5;
SELECT * FROM olist_order_items_dataset LIMIT 5;
SELECT * FROM olist_products_dataset LIMIT 5;

-- Validate order purchase timestamp range
SELECT
    MIN(order_purchase_timestamp) AS min_purchase_date,
    MAX(order_purchase_timestamp) AS max_purchase_date
FROM olist_orders_dataset;

-- Check missing values for key timestamp columns
SELECT
    SUM(CASE WHEN order_approved_at IS NULL THEN 1 END) AS missing_approved,
    SUM(CASE WHEN order_delivered_carrier_date IS NULL THEN 1 END) AS missing_carrier_date,
    SUM(CASE WHEN order_delivered_customer_date IS NULL THEN 1 END) AS missing_delivery_date,
    SUM(CASE WHEN order_estimated_delivery_date IS NULL THEN 1 END) AS missing_estimated_delivery
FROM olist_orders_dataset;

-- Top 10 best-selling products
SELECT
    product_id,
    COUNT(*) AS items_sold
FROM olist_order_items_dataset
GROUP BY product_id
ORDER BY items_sold DESC
LIMIT 10;

-- Top 10 best-selling product categories
SELECT
    p.product_category_name,
    COUNT(*) AS items_sold
FROM olist_order_items_dataset i
JOIN olist_products_dataset p USING (product_id)
GROUP BY p.product_category_name
ORDER BY items_sold DESC
LIMIT 10;

-- Average review score
SELECT
    AVG(review_score) AS avg_review_score
FROM olist_order_reviews_dataset;

-- Average delivery delay (actual - estimated)
SELECT
    AVG(
        DATE(order_delivered_customer_date) -
        DATE(order_estimated_delivery_date)
    ) AS avg_delivery_delay_days
FROM olist_orders_dataset
WHERE order_delivered_customer_date IS NOT NULL
  AND order_estimated_delivery_date IS NOT NULL;

-- Top 10 highest-revenue orders
SELECT
    order_id,
    SUM(price + freight_value) AS order_revenue
FROM olist_order_items_dataset
GROUP BY order_id
ORDER BY order_revenue DESC
LIMIT 10;

/*************************************************************
Exploratory Metrics / KPIs
Author: Jana El Kadri
Date: 2025-11-28
Description: First 5 key performance indicators (KPIs) for 
NovaMart / Olist dataset. Queries written in SQL style.
**************************************************************/

/* 1️⃣ Total Revenue
   Sum of all order items' prices
*/
SELECT SUM(price) AS Total_Revenue
FROM order_items;


/* 2️⃣ Total Orders
   Count of distinct orders in the dataset
*/
SELECT COUNT(DISTINCT order_id) AS Total_Orders
FROM orders;


/* 3️⃣ Average Order Value (AOV)
   Average of total order value per order
*/
SELECT AVG(order_total) AS AOV
FROM (
    SELECT order_id, SUM(price) AS order_total
    FROM order_items
    GROUP BY order_id
) AS t;


/* 4️⃣ Number of Unique Customers
   Count of distinct customers who made orders
*/
SELECT COUNT(DISTINCT customer_id) AS Unique_Customers
FROM orders;


/* 5️⃣ Revenue by Order Status
   Sum of revenue grouped by order_status
*/
SELECT o.order_status, SUM(ot.order_total) AS revenue
FROM orders o
LEFT JOIN (
    SELECT order_id, SUM(price) AS order_total
    FROM order_items
    GROUP BY order_id
) ot
ON o.order_id = ot.order_id
GROUP BY o.order_status
ORDER BY revenue DESC;

