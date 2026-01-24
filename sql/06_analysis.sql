
-- BUSINESS ANALYSIS

-- Purpose:
-- Generate business insights from fact and dimension tables.



-- ---------------------
-- 1. TOTAL ORDERS & CUSTOMERS
-- ---------------------
SELECT
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT o.customer_id) AS total_customers
FROM fact_orders o;


-- ---------------------
-- 2. MONTHLY ORDER TREND
-- ---------------------
SELECT
    DATE_TRUNC('month', o.order_purchase_ts) AS order_month,
    COUNT(*) AS total_orders
FROM fact_orders o
GROUP BY 1
ORDER BY 1;


-- ---------------------
-- 3. TOTAL REVENUE
-- ---------------------
SELECT
    SUM(p.payment_value) AS total_revenue
FROM fact_payments p;


-- ---------------------
-- 4. MONTHLY REVENUE TREND
-- ---------------------
SELECT
    DATE_TRUNC('month', o.order_purchase_ts) AS revenue_month,
    SUM(p.payment_value) AS monthly_revenue
FROM fact_orders o
JOIN fact_payments p
    ON o.order_id = p.order_id
GROUP BY 1
ORDER BY 1;


-- ---------------------
-- 5. TOP 10 PRODUCTS BY REVENUE
-- ---------------------
SELECT
    dp.product_category_english,
    SUM(oi.price) AS total_revenue
FROM fact_order_items oi
JOIN dim_products dp
    ON oi.product_id = dp.product_id
GROUP BY 1
ORDER BY total_revenue DESC
LIMIT 10;


-- ---------------------
-- 6. TOP 10 SELLERS BY REVENUE
-- ---------------------
SELECT
    ds.seller_id,
    SUM(oi.price) AS total_revenue
FROM fact_order_items oi
JOIN dim_sellers ds
    ON oi.seller_id = ds.seller_id
GROUP BY 1
ORDER BY total_revenue DESC
LIMIT 10;


-- ---------------------
-- 7. AVERAGE ORDER VALUE (AOV)
-- ---------------------
SELECT
    ROUND(SUM(p.payment_value) / COUNT(DISTINCT p.order_id), 2) AS avg_order_value
FROM fact_payments p;


-- ---------------------
-- 8. DELIVERY PERFORMANCE (ON-TIME VS LATE)
-- ---------------------
SELECT
    CASE
        WHEN o.order_delivered_ts <= o.estimated_delivery_date
        THEN 'On Time'
        ELSE 'Late'
    END AS delivery_status,
    COUNT(*) AS total_orders
FROM fact_orders o
WHERE o.order_delivered_ts IS NOT NULL
GROUP BY 1;


-- ---------------------
-- 9. REPEAT CUSTOMER ORDER DISTRIBUTION (REAL CUSTOMERS)
-- ---------------------

-- ---------------------
-- 9A. REPEAT CUSTOMERS (REAL CUSTOMERS)
-- ---------------------
SELECT
    c.customer_unique_id,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM fact_orders o
JOIN dim_customers c
    ON o.customer_id = c.customer_id
GROUP BY c.customer_unique_id
HAVING COUNT(DISTINCT o.order_id) > 1
ORDER BY total_orders DESC;


-- ---------------------
-- 9B. CUSTOMER ORDER FREQUENCY DISTRIBUTION
-- ---------------------
SELECT
    total_orders,
    COUNT(*) AS customers
FROM (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS total_orders
    FROM fact_orders o
    JOIN dim_customers c
        ON o.customer_id = c.customer_id
    GROUP BY c.customer_unique_id
) t
GROUP BY total_orders
ORDER BY total_orders;



-- ---------------------
-- 10. AVERAGE REVIEW SCORE
-- ---------------------
SELECT
    ROUND(AVG(r.review_score), 2) AS avg_review_score
FROM stg_reviews r;
