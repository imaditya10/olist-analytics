/*
Project: Olist E-commerce Analytics
Purpose:
This file defines the RAW database schema used for loading source CSV files
from the Olist Brazilian e-commerce dataset.

Design principles:
1. Raw tables mirror source CSVs exactly (1:1 mapping).
2. Column names and order match the original datasets to ensure safe ingestion.
3. Data types are chosen conservatively to avoid load failures.
4. Raw tables act as immutable sources for downstream cleaned and analytical tables.

Note:
All cleaning, type casting, and business logic will be applied in downstream
tables and queries, not in raw tables.
*/




-- RAW ORDERS
CREATE TABLE raw_orders (
    order_id TEXT,
    customer_id TEXT,
    order_status TEXT,
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP
);



-- RAW CUSTOMERS
CREATE TABLE raw_customers (
    customer_id TEXT,
    customer_unique_id TEXT,
    customer_zip_code_prefix TEXT,
    customer_city TEXT,
    customer_state TEXT
);


-- RAW ORDER ITEMS
CREATE TABLE raw_order_items (
    order_id TEXT,
    order_item_id INT,
    product_id TEXT,
    seller_id TEXT,
    shipping_limit_date TIMESTAMP,
    price NUMERIC,
    freight_value NUMERIC
);



-- RAW ORDER PAYMENTS
CREATE TABLE raw_order_payments (
    order_id TEXT,
    payment_sequential INT,
    payment_type TEXT,
    payment_installments INT,
    payment_value NUMERIC
);



-- RAW ORDER REVIEWS
CREATE TABLE raw_order_reviews (
    review_id TEXT,
    order_id TEXT,
    review_score INT,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP
);



-- RAW PRODUCTS
CREATE TABLE raw_products (
    product_id TEXT,
    product_category_name TEXT,
    product_name_lenght INT,
    product_description_lenght INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT
);



-- RAW SELLERS
CREATE TABLE raw_sellers (
    seller_id TEXT,
    seller_zip_code_prefix TEXT,
    seller_city TEXT,
    seller_state TEXT
);



-- RAW GEOLOCATION
CREATE TABLE raw_geolocation (
    geolocation_zip_code_prefix TEXT,
    geolocation_lat NUMERIC,
    geolocation_lng NUMERIC,
    geolocation_city TEXT,
    geolocation_state TEXT
);



-- PRODUCT CATEGORY TRANSLATION
CREATE TABLE raw_product_category_translation (
    product_category_name TEXT,
    product_category_name_english TEXT
);
