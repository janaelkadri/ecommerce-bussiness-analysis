# ecommerce-bussiness-analysis
End-to-end Business Analyst project: SQL + Power BI + DAX + storytelling using the E-commerce dataset.

---

## 📚 Dataset
This project uses the **Olist Brazilian E-Commerce Dataset** (public and shareable).

Dataset link: https://www.kaggle.com/datasets/olistbr/olist-dataset

---

## 📅 Project Progress Tracking
This project follows a structured 90-day plan combining:

- Technical skill growth  
- Business analytics methodology  
- Hands-on project deliverables

Daily updates will appear in this repository.

---

## 🧭 Project Goals
- Build a complete BA portfolio-ready project  
- Show mastery of SQL, Power BI, and DAX  
- Demonstrate real business thinking  
- Present insights clearly and persuasively  
- Impress hiring managers & recruiters

---

## 🛠️ How to reproduce (quick)
1. Download CSVs into `data/raw/`  
2. Run SQL scripts in `/sql/` to build cleaned tables & metrics  
3. Open `.pbix` files in `/powerbi/` to view dashboards  
4. See `/reports/` for executive summaries and deliverables

(Full reproduction steps in `README` will be added later.)

---

## 📎 Notes
- Do not commit any private or PII files.  
- Large Power BI files (.pbix) can be hosted via OneDrive/Google Drive and linked here if file size is an issue.

## 📅 Daily Progress

### 🗓️ Day 1 — Project Initialization
**Completed:**
- Created full repository structure (`data/`, `data/raw/`, `sql/`, `reports/`, `powerbi/`, `scripts/`)
- Added `.gitkeep` files to enable folder versioning
- Uploaded essential Olist datasets for analysis:
  - `olist_orders_dataset.csv`
  - `olist_order_items_dataset.csv`
  - `olist_order_payments_dataset.csv`
  - `olist_customers_dataset.csv`
  - `olist_products_dataset.csv`
  - `olist_order_reviews_dataset.csv`
- Skipped the large geolocation file (not needed for KPIs, RFM, cohort, or business analysis)
- Added `.gitignore` to maintain a clean repository
- Built the foundation of the README with project overview, structure, goals, and dataset info

**Skills practiced:**
- Repository organization
- Version control fundamentals
- Data documentation
- Project setup best practices

### 📅 Day 2 — Exploratory Data Analysis Setup
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

--I performed quick exploratory data analysis (EDA) and calculated the first core KPIs for the Olist dataset. These metrics provide early business insights into revenue, customer behavior, and order performance. The KPIs include:

1. **Total Revenue** – Total sales value from all orders  
2. **Total Orders** – Count of distinct orders in the dataset  
3. **Average Order Value (AOV)** – Average revenue per order  
4. **Number of Unique Customers** – Unique customers who placed orders  
5. **Revenue by Order Status** – Revenue breakdown by order status (delivered, canceled, shipped, etc.)
6. **GMV (Revenue + Freight):** R$ 15,843,553.24
7. **Items Sold:** 112,650 – Count of total product_items in the dataset  
8. **Sellers:** 3,095 – Count of distinct sellers in the dataset  
9. **Products:** 32,951 – Count of distinct products in the dataset  

### 🔍 Interpretation
- The marketplace is **large and healthy**, with strong order volume suitable for deeper analysis.
- AOV of **R$ 137.75** suggests customers typically purchase lower-ticket items.
- Over **32k products** and **3k sellers** indicate a highly fragmented long-tail marketplace.
- GMV of **R$ 15.8M** reflects solid gross merchandise flow across the platform.

### **SQL Queries**
The queries are saved in [`day2_kpis.sql`](./day2_kpis.sql) and can be run directly on the dataset. Each query includes comments explaining its purpose and logic.
