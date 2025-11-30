
GRANT ALL PRIVILEGES ON shopping_db.* TO 'user_name'@'localhost';
GRANT ALL PRIVILEGES ON shopping_db.* TO 'user_name'@'%';

USE shopping_db;
SELECT * FROM customer_shopping_behavior
LIMIT 10;
 -- 1. Revenue by Gender
SELECT
    gender,
    SUM(purchase_amount) AS revenue
FROM customer_shopping_behavior
GROUP BY gender;

-- 2. High-Spending Discount Users

SELECT 
    customer_id,
    purchase_amount
FROM customer_shopping_behavior
WHERE discount_applied = 'Yes'
  AND purchase_amount > (
        SELECT AVG(purchase_amount)
        FROM customer_shopping_behavior
  );
  
  -- 3. Top 5 products with highest average review rating
  SELECT
    item_purchased,
    AVG(review_rating) AS average_review_rating
FROM customer_shopping_behavior
GROUP BY item_purchased
ORDER BY average_review_rating DESC
LIMIT 5;

-- 4. Shipping type comparison (standard vs express vs others)

SELECT
    shipping_type,
    AVG(purchase_amount) AS avg_purchase_amount
FROM customer_shopping_behavior
GROUP BY shipping_type
ORDER BY avg_purchase_amount DESC;

-- 5 Subscribers vs Non-Subscribers
SELECT
    subscription_status,
    COUNT(*) AS total_customers,
    AVG(purchase_amount) AS avg_purchase_amount,
    SUM(purchase_amount) AS total_revenue
FROM customer_shopping_behavior
GROUP BY subscription_status
ORDER BY total_revenue DESC;

-- 6. Discount-dependent products
SELECT
    item_purchased,
    COUNT(*) AS discount_purchase_count
FROM customer_shopping_behavior
WHERE discount_applied = 'Yes'
GROUP BY item_purchased
ORDER BY discount_purchase_count DESC
LIMIT 5;

-- 7) Customer segmentation (New / Returning / Loyal)
SELECT
    CASE
        WHEN total_purchases = 1 THEN 'New'
        WHEN total_purchases BETWEEN 2 AND 4 THEN 'Returning'
        ELSE 'Loyal'
    END AS customer_segment,
    COUNT(*) AS number_of_customers
FROM (
    SELECT
        customer_id,
        COUNT(*) AS total_purchases
    FROM customer_shopping_behavior
    GROUP BY customer_id
) AS customer_stats
GROUP BY customer_segment
ORDER BY number_of_customers DESC;

-- 8. Top 3 most purchased products per category
SELECT
    category,
    item_purchased,
    total_orders
FROM (
    SELECT
        category,
        item_purchased,
        COUNT(*) AS total_orders,
        ROW_NUMBER() OVER (
            PARTITION BY category
            ORDER BY COUNT(*) DESC
        ) AS item_rank
    FROM customer_shopping_behavior
    GROUP BY category, item_purchased
) AS ranked
WHERE item_rank <= 3
ORDER BY category, item_rank;

-- 9. Repeat buyers (>5 purchases) grouped by subscription status
SELECT 
    subscription_status,
    COUNT(*) AS repeat_buyers
FROM customer_shopping_behavior
WHERE previous_purchases > 5
GROUP BY subscription_status;

-- 10. Revenue by Age Group
SELECT 
    age_group,
    SUM(purchase_amount) AS total_revenue
FROM customer_shopping_behavior
GROUP BY age_group
ORDER BY total_revenue DESC;