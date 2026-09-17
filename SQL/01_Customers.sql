-- ==================
-- CUSTOMERS ANALYSIS
-- ==================

-- 1. Which cities and states have the most unique customers?
SELECT 
	COUNT(DISTINCT(customer_unique_id)) AS number_of_customers, 
	customer_city, 
	customer_state
FROM olist_customers_dataset
GROUP BY customer_city, customer_state
ORDER BY number_of_customers DESC;

-- 2. Which customers spend the most? What products do they buy most often?
SELECT 
	TOP 10 c.customer_unique_id, 
	SUM(i.price) AS total_spent
FROM olist_customers_dataset c
	JOIN olist_orders_dataset o
		ON c.customer_id = o.customer_id
	JOIN olist_order_items_dataset i
		ON o.order_id = i.order_id
GROUP BY c.customer_unique_id
ORDER BY total_spent DESC;

WITH top_customers AS
(
SELECT 
	TOP 10 c.customer_unique_id, 
	SUM(i.price) AS total_spent
FROM olist_customers_dataset c
	JOIN olist_orders_dataset o
		ON c.customer_id = o.customer_id
	JOIN olist_order_items_dataset i
		ON o.order_id = i.order_id
GROUP BY c.customer_unique_id
ORDER BY total_spent DESC
)
SELECT 
	tc.customer_unique_id, i.product_id, 
	COUNT(*) AS times_purchased
FROM top_customers tc
	JOIN olist_customers_dataset c
		ON tc.customer_unique_id = c.customer_unique_id
	JOIN olist_orders_dataset o
		ON c.customer_id = o.customer_id
	JOIN olist_order_items_dataset i
		ON o.order_id = i.order_id
GROUP BY tc.customer_unique_id, i.product_id
ORDER BY tc.customer_unique_id, times_purchased DESC;
