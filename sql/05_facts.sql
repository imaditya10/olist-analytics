
-- FACT LAYER

-- Purpose:
-- Create fact tables representing business events.
-- These tables link dimensions to measurable metrics.


-- ---------------------
-- ORDERS FACT
-- Grain: one row per order
-- ---------------------
CREATE TABLE fact_orders AS
SELECT
    o.order_id,
    o.customer_id,
    o.order_status,
    o.order_purchase_ts,
    o.order_approved_ts,
    o.order_carrier_ts,
    o.order_delivered_ts,
    o.estimated_delivery_date
FROM stg_orders o;


-- ---------------------
-- ORDER ITEMS FACT
-- Grain: one row per order item
-- ---------------------
CREATE TABLE fact_order_items AS
SELECT
    oi.order_id,
    oi.order_item_id,
    oi.product_id,
    oi.seller_id,
    oi.shipping_limit_ts,
    oi.price,
    oi.freight_value
FROM stg_order_items oi;


-- ---------------------
-- PAYMENTS FACT
-- Grain: one row per payment record
-- ---------------------
CREATE TABLE fact_payments AS
SELECT
    p.order_id,
    p.payment_sequential,
    p.payment_type,
    p.payment_installments,
    p.payment_value
FROM stg_payments p;
