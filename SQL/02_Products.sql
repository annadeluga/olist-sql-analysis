-- ========
-- PRODUCTS
-- ========

-- 1. Which products sell the most?
SELECT 
    product_id, 
    COUNT(*) AS units_sold, 
    CAST(SUM(price) AS decimal(10,2)) AS revenue, 
    CAST(AVG(price) AS decimal(10,2)) AS average_price
FROM olist_order_items_dataset
GROUP BY product_id
ORDER BY units_sold DESC;

-- 2. Which product categories generate the highest revenue and what is their share of total revenue?
WITH category_sales AS
(
    SELECT 
        p.product_category_name, 
        COUNT(*) AS units_sold, 
        CAST(SUM(i.price) AS decimal(10,2))  AS revenue
    FROM olist_order_items_dataset i
        LEFT JOIN olist_products_dataset p
            ON i.product_id = p.product_id
    GROUP BY p.product_category_name
)
SELECT 
    product_category_name, 
    units_sold, 
    CAST(revenue AS decimal(10,2)) AS revenue, 
    CAST(revenue * 100 / SUM(revenue) OVER() AS decimal(10,2)) AS revenue_percentage
FROM top_products
ORDER BY revenue DESC;

-- 3. Does the number of product photos relate to sales? 
WITH product_sales AS
(
    SELECT
        p.product_id,
        p.product_photos_qty,
        COUNT(i.product_id) AS units_sold,
        SUM(i.price) AS revenue
    FROM olist_products_dataset p
    LEFT JOIN olist_order_items_dataset i
        ON p.product_id = i.product_id
    GROUP BY
        p.product_id,
        p.product_photos_qty
)
SELECT
    product_photos_qty,
    COUNT(product_id) AS number_of_products,
    AVG(units_sold) AS average_units_sold,
    CAST(AVG(revenue) AS DECIMAL(10,2)) AS average_revenue
FROM product_sales
GROUP BY product_photos_qty
ORDER BY product_photos_qty DESC;
