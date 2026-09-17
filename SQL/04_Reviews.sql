-- ================
-- REVIEWS ANALYSIS
-- ================

-- 1. What is the overall average review score and how are ratings distributed?

-- Overall average review score

SELECT 
    AVG(review_score) AS average_review
FROM olist_order_reviews_dataset;

-- Distribution of review scores

SELECT 
    review_score, 
    COUNT(*) AS number_of_reviews, 
    CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() AS DECIMAL(10,2)) AS percentage_of_reviews
FROM olist_order_reviews_dataset
GROUP BY review_score
ORDER BY percentage_of_reviews DESC;

-- 2. Which products have the highest average rating?
SELECT 
    i.product_id, 
    COUNT(r.review_score) AS number_of_reviews, 
    AVG(r.review_score) AS average_review
FROM olist_order_reviews_dataset r
    LEFT JOIN olist_order_items_dataset i
        ON r.order_id = i.order_id
GROUP BY i.product_id
HAVING COUNT(r.review_score) >= 10
ORDER BY average_review DESC;

-- 3. Which customers leave reviews most frequently?
SELECT 
    c.customer_unique_id, 
    COUNT(*) AS number_of_reviews
FROM olist_order_reviews_dataset r
    LEFT JOIN olist_orders_dataset o
        ON r.order_id = o.order_id
    LEFT JOIN olist_customers_dataset c
        ON o.customer_id = c.customer_id
GROUP BY c.customer_unique_id
HAVING COUNT(*) >= 2
ORDER BY number_of_reviews DESC;
