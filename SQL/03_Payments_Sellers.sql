-- =================
-- PAYMENT & SELLERS
-- =================

-- 1. Which payment methods are the most popular and what percentage of payments do they represent? 
WITH payment_counts AS
(
    SELECT
        payment_type,
        COUNT(*) AS number_of_payments
    FROM olist_order_payments_dataset
    GROUP BY payment_type
)
SELECT
    payment_type,
    number_of_payments,
    CAST(
        number_of_payments * 100.0 / SUM(number_of_payments) OVER() AS DECIMAL(10,2)) AS payments_percentage
FROM payment_counts
ORDER BY number_of_payments DESC;

-- 2. Which states have the most sellers and generate the highest revenue?
WITH seller_sales AS
(
    SELECT 
        s.seller_state,
        COUNT(DISTINCT s.seller_id) AS number_of_sellers,
        CAST(SUM(o.price) AS DECIMAL(10,2)) AS revenue
    FROM olist_sellers_dataset s
    LEFT JOIN olist_order_items_dataset o
        ON s.seller_id = o.seller_id
    GROUP BY s.seller_state
)
SELECT
    seller_state,
    number_of_sellers,
    revenue,
    DENSE_RANK() OVER(ORDER BY number_of_sellers DESC) AS sellers_rank,
    DENSE_RANK() OVER(ORDER BY revenue DESC) AS revenue_rank
FROM seller_sales
ORDER BY revenue_rank;
