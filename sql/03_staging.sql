
-- STAGING LAYER
-- 
-- Purpose:
-- Clean and standardize raw Olist datasets.
-- One staging table per raw table.
-- No joins, aggregations, or business logic.



-- ---------------------
-- CUSTOMERS
-- ---------------------
CREATE TABLE stg_customers AS
SELECT
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix AS zip_code_prefix,
    customer_city,
    customer_state
FROM raw_customers;


-- ---------------------
-- ORDERS
-- ---------------------
CREATE TABLE stg_orders AS
SELECT
    order_id,
    customer_id,
    order_status,
    CAST(order_purchase_timestamp AS TIMESTAMP) AS order_purchase_ts,
    CAST(order_approved_at AS TIMESTAMP) AS order_approved_ts,
    CAST(order_delivered_carrier_date AS TIMESTAMP) AS order_carrier_ts,
    CAST(order_delivered_customer_date AS TIMESTAMP) AS order_delivered_ts,
    CAST(order_estimated_delivery_date AS DATE) AS estimated_delivery_date
FROM raw_orders;


-- ---------------------
-- ORDER ITEMS
-- ---------------------
CREATE TABLE stg_order_items AS
SELECT
    order_id,
    order_item_id,
    product_id,
    seller_id,
    CAST(shipping_limit_date AS TIMESTAMP) AS shipping_limit_ts,
    price,
    freight_value
FROM raw_order_items;


-- ---------------------
-- PAYMENTS
-- ---------------------
CREATE TABLE stg_payments AS
SELECT
    order_id,
    payment_sequential,
    payment_type,
    payment_installments,
    payment_value
FROM raw_order_payments;


-- ---------------------
-- REVIEWS
-- ---------------------
CREATE TABLE stg_reviews AS
SELECT
    review_id,
    order_id,
    review_score,
    review_comment_title,
    review_comment_message,
    CAST(review_creation_date AS TIMESTAMP) AS review_creation_ts,
    CAST(review_answer_timestamp AS TIMESTAMP) AS review_answer_ts
FROM raw_order reviews;


-- ---------------------
-- PRODUCTS
-- ---------------------
CREATE TABLE stg_products AS
SELECT
    product_id,
    product_category_name,
    product_name_lenght AS product_name_length,
    product_description_lenght AS product_description_length,
    product_photos_qty,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
FROM raw_products;


-- ---------------------
-- SELLERS
-- ---------------------
CREATE TABLE stg_sellers AS
SELECT
    seller_id,
    seller_zip_code_prefix AS zip_code_prefix,
    seller_city,
    seller_state
FROM raw_sellers;


-- ---------------------
-- GEOLOCATION
-- ---------------------
CREATE TABLE stg_geolocation AS
SELECT
    geolocation_zip_code_prefix AS zip_code_prefix,
    geolocation_lat,
    geolocation_lng,
    geolocation_city,
    geolocation_state
FROM raw_geolocation;


-- ---------------------
-- PRODUCT CATEGORY TRANSLATION
-- ---------------------
CREATE TABLE stg_category_translation AS
SELECT
    product_category_name,
    product_category_name_english
FROM raw_product_category_translation;









