-- Purpose:
--   Validate correctness of data loaded into raw tables.
--   Focus on row counts, key distinctness, and identifying
--   unexpected duplicates for core fact tables.


-- RAW ORDERS
SELECT COUNT(*) AS total_rows FROM raw_orders;
SELECT COUNT(DISTINCT order_id) AS distinct_orders FROM raw_orders;
-- order_id is unique (COUNT(*) = COUNT(DISTINCT order_id))


-- RAW CUSTOMERS
SELECT COUNT(*) AS total_rows FROM raw_customers;
SELECT COUNT(DISTINCT customer_id) AS distinct_customers FROM raw_customers;
-- customer_id is unique (COUNT(*) = COUNT(DISTINCT customer_id))



-- RAW ORDER ITEMS
SELECT COUNT(*) AS total_rows FROM raw_order_items;

SELECT COUNT(*) AS distinct_order_items
FROM (
    SELECT DISTINCT order_id, order_item_id
    FROM raw_order_items
) t;
-- raw_order_items represents line items within an order, so uniqueness is defined by the combination of order_id and order_item_id, not by either column alone.
--uniqueness confirmed



-- RAW ORDER PAYMENTS
SELECT COUNT(*) AS total_rows FROM raw_order_payments;

SELECT COUNT(*) AS distinct_payment_rows
FROM (
    SELECT DISTINCT order_id, payment_sequential
    FROM raw_order_payments
) t;
--uniqueness confirmed


-- SUPPORTING TABLES

-- PRODUCTS
SELECT COUNT(*) AS total_rows FROM raw_products;
SELECT COUNT(DISTINCT product_id) AS distinct_products FROM raw_products;

-- SELLERS
SELECT COUNT(*) AS total_rows FROM raw_sellers;
SELECT COUNT(DISTINCT seller_id) AS distinct_sellers FROM raw_sellers;

-- REVIEWS
SELECT COUNT(*) AS total_rows FROM raw_order_reviews;
SELECT COUNT(DISTINCT review_id) AS distinct_reviews FROM raw_order_reviews;
-- orders with multiple reviews
SELECT order_id, COUNT(*)
FROM raw_order_reviews
GROUP BY order_id
HAVING COUNT(*) > 1;
--the reviews are not distinct as some order_ids have multiple reviews 



-- GEOLOCATION (duplicates expected)
SELECT COUNT(*) AS total_rows FROM raw_geolocation;

-- CATEGORY TRANSLATION
SELECT COUNT(*) AS total_rows FROM raw_product_category_translation;
