-- ===============
-- ORDERS/DELIVERY
-- ===============

-- 1. How does the number of orders change over time?
SELECT 
    FORMAT(order_purchase_timestamp, 'yyyy-MM') AS year_month, 
    COUNT(order_id) AS number_of_orders
FROM olist_orders_dataset
GROUP BY FORMAT(order_purchase_timestamp, 'yyyy-MM')
ORDER BY year_month;

-- 2. What is the average delivery time?
SELECT 
    CAST(
        AVG(
            CAST(
                DATEDIFF(
                    DAY,
                    order_delivered_carrier_date,
                    order_delivered_customer_date
                ) AS DECIMAL(10,2)
            )
        ) AS DECIMAL(10,2)
    ) AS average_delivery_days
FROM olist_orders_dataset
WHERE order_delivered_carrier_date IS NOT NULL 
    AND order_delivered_customer_date IS NOT NULL;

-- 3. How often are orders delivered after the estimated delivery date?
SELECT 
    COUNT(*) AS late_orders,
    CAST(
        COUNT(*) * 100.0 / (
            SELECT COUNT(*)
            FROM olist_orders_dataset
            WHERE order_delivered_customer_date IS NOT NULL
        )
        AS DECIMAL(10,2)
    ) AS late_orders_percentage
FROM olist_orders_dataset
WHERE order_delivered_customer_date > order_estimated_delivery_date;

-- 4. Does delivery delay affect customer review scores?
WITH delivery_status AS
(
    SELECT
        order_id,
        CASE
            WHEN order_delivered_customer_date > order_estimated_delivery_date
                THEN 'Late'
            ELSE 'On time'
        END AS delivery_status
    FROM olist_orders_dataset
    WHERE order_delivered_customer_date IS NOT NULL
      AND order_estimated_delivery_date IS NOT NULL
)
SELECT
    d.delivery_status,
    COUNT(r.review_score) AS number_of_reviews,
    CAST(AVG(r.review_score) AS DECIMAL(10,2)) AS average_review
FROM delivery_status d
    JOIN olist_order_reviews_dataset r
        ON d.order_id = r.order_id
GROUP BY d.delivery_status
ORDER BY average_review DESC;
