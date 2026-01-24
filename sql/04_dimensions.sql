
-- DIMENSION LAYER

-- Purpose:
-- Create descriptive dimension tables from staging data.
-- These tables support star-schema-based analytics.



-- ---------------------
-- CUSTOMER DIMENSION
-- ---------------------
CREATE TABLE dim_customers AS
SELECT
    customer_id,
    customer_unique_id,
    zip_code_prefix,
    customer_city,
    customer_state
FROM stg_customers;


-- ---------------------
-- SELLER DIMENSION
-- ---------------------
CREATE TABLE dim_sellers AS
SELECT
    seller_id,
    zip_code_prefix,
    seller_city,
    seller_state
FROM stg_sellers;


-- ---------------------
-- PRODUCT DIMENSION
-- ---------------------
CREATE TABLE dim_products AS
SELECT
    p.product_id,
    p.product_category_name,
    ct.product_category_name_english AS product_category_english,
    p.product_name_length,
    p.product_description_length,
    p.product_photos_qty,
    p.product_weight_g,
    p.product_length_cm,
    p.product_height_cm,
    p.product_width_cm
FROM stg_products p
LEFT JOIN stg_category_translation ct
    ON p.product_category_name = ct.product_category_name;


-- ---------------------
-- GEOLOCATION DIMENSION
-- ---------------------
CREATE TABLE dim_geolocation AS
SELECT DISTINCT
    zip_code_prefix,
    geolocation_city,
    geolocation_state
FROM stg_geolocation;

