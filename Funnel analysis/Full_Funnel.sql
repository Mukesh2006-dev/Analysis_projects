
SELECT * FROM users;
SELECT * FROM events;


--  Total Users in Time Period
SELECT COUNT(DISTINCT user_id) AS total_users
FROM events
WHERE event_timestamp BETWEEN '2024-01-01' AND '2025-01-31';


--  Full Funnel Drop-off Counts
WITH conversion_rate AS (
    SELECT
        user_id,
        MAX(CASE WHEN event_name = 'homepage' THEN 1 ELSE 0 END) AS visited_homepage,
        MAX(CASE WHEN event_name = 'product_view' THEN 1 ELSE 0 END) AS viewed_product,
        MAX(CASE WHEN event_name = 'add_to_cart' THEN 1 ELSE 0 END) AS added_to_cart,
        MAX(CASE WHEN event_name = 'checkout' THEN 1 ELSE 0 END) AS checked_out,
        MAX(CASE WHEN event_name = 'purchase' THEN 1 ELSE 0 END) AS purchased
    FROM events
    GROUP BY user_id
)
SELECT
    COUNT(*) AS total_users,
    SUM(visited_homepage) AS homepage_visits,
    SUM(viewed_product) AS product_views,
    SUM(added_to_cart) AS add_to_cart,
    SUM(checked_out) AS checkout,
    SUM(purchased) AS purchases,
    SUM(visited_homepage) - SUM(viewed_product) AS drop_off_homepage_to_product,
    SUM(viewed_product) - SUM(added_to_cart) AS drop_off_product_to_cart,
    SUM(added_to_cart) - SUM(checked_out) AS drop_off_cart_to_checkout,
    SUM(checked_out) - SUM(purchased) AS drop_off_checkout_to_purchase
FROM conversion_rate;


--  Users Who Completed Full Funnel
SELECT COUNT(*) AS funnel_users
FROM (
    SELECT user_id
    FROM events
    WHERE event_name IN ('homepage','product_view','add_to_cart','checkout','purchase')
    GROUP BY user_id
    HAVING COUNT(DISTINCT event_name) = 5
) AS completed_funnel;


--  Overall Conversion Rate
SELECT
    COUNT(DISTINCT CASE WHEN event_name = 'purchase' THEN user_id END) AS purchasers,
    COUNT(DISTINCT user_id) AS total_users,
    ROUND(
        COUNT(DISTINCT CASE WHEN event_name = 'purchase' THEN user_id END) * 100.0 /
        COUNT(DISTINCT user_id),
        2
    ) AS conversion_rate_percent
FROM events;


--  Device-wise Funnel
WITH user_device_flags AS (
    SELECT
        e.user_id,
        u.device_type,
        MAX(CASE WHEN e.event_name = 'product_view' THEN 1 ELSE 0 END) AS viewed,
        MAX(CASE WHEN e.event_name = 'add_to_cart' THEN 1 ELSE 0 END) AS added,
        MAX(CASE WHEN e.event_name = 'purchase' THEN 1 ELSE 0 END) AS purchased
    FROM events e
    JOIN users u ON e.user_id = u.user_id
    GROUP BY e.user_id, u.device_type
)
SELECT
    device_type,
    COUNT(*) AS total_users,
    COUNT(*) FILTER (WHERE viewed = 1) AS users_viewed,
    COUNT(*) FILTER (WHERE added = 1) AS users_added_to_cart,
    COUNT(*) FILTER (WHERE purchased = 1) AS users_purchased
FROM user_device_flags
GROUP BY device_type
ORDER BY device_type;


--  Drop-off Analysis by Device
WITH dropoff_device_flags AS (
    SELECT
        e.user_id,
        u.device_type,
        MAX(CASE WHEN e.event_name = 'product_view' THEN 1 ELSE 0 END) AS viewed,
        MAX(CASE WHEN e.event_name = 'add_to_cart' THEN 1 ELSE 0 END) AS added,
        MAX(CASE WHEN e.event_name = 'purchase' THEN 1 ELSE 0 END) AS purchased
    FROM events e
    JOIN users u ON e.user_id = u.user_id
    GROUP BY e.user_id, u.device_type
)
SELECT
    device_type,
    SUM(viewed) AS total_views,
    SUM(added) AS total_added,
    SUM(purchased) AS total_bought,
    SUM(CASE WHEN viewed = 1 AND added = 0 THEN 1 ELSE 0 END) AS drop_view_to_add,
    SUM(CASE WHEN added = 1 AND purchased = 0 THEN 1 ELSE 0 END) AS drop_add_to_purchase
FROM dropoff_device_flags
GROUP BY device_type
ORDER BY device_type;


--  Retention / Monthly Conversion Rate
SELECT
    DATE_TRUNC('month', event_timestamp) AS month,
    ROUND(
        COUNT(DISTINCT CASE WHEN event_name='purchase' THEN user_id END) * 100.0 /
        COUNT(DISTINCT user_id),
        2
    ) AS conversion_rate
FROM events
GROUP BY month
ORDER BY month;


--  First-time vs Repeat Buyers
WITH ranked_purchases AS (
    SELECT
        user_id,
        ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY event_timestamp) AS purchase_rank
    FROM events
    WHERE event_name = 'purchase'
)
SELECT
    COUNT(DISTINCT CASE WHEN purchase_rank = 1 THEN user_id END) AS first_time_buyers,
    COUNT(DISTINCT CASE WHEN purchase_rank = 2 THEN user_id END) AS repeat_buyers
FROM ranked_purchases;


--  Conversion Rate by Device
WITH user_device_flags AS (
    SELECT
        u.user_id,
        u.device_type,
        MAX(CASE WHEN e.event_name = 'purchase' THEN 1 ELSE 0 END) AS purchased
    FROM users u
    LEFT JOIN events e ON u.user_id = e.user_id
    GROUP BY u.user_id, u.device_type
)
SELECT
    device_type,
    COUNT(user_id) AS total_users,
    SUM(purchased) AS total_purchasers,
    ROUND(100.0 * SUM(purchased) / NULLIF(COUNT(user_id),0), 2) AS conversion_rate_percent
FROM user_device_flags
GROUP BY device_type
ORDER BY conversion_rate_percent DESC;


--  Total Purchases & Repeat Purchase Rate
WITH user_purchase_counts AS (
    SELECT user_id, COUNT(*) AS purchase_count
    FROM events
    WHERE event_name = 'purchase'
    GROUP BY user_id
)
SELECT
    SUM(purchase_count) AS total_purchases,
    COUNT(DISTINCT user_id) AS total_buyers,
    COUNT(DISTINCT CASE WHEN purchase_count > 1 THEN user_id END) AS repeat_buyers,
    ROUND(
        COUNT(DISTINCT CASE WHEN purchase_count > 1 THEN user_id END) * 100.0 /
        COUNT(DISTINCT user_id),
        2
    ) AS repeat_purchase_rate_percent
FROM user_purchase_counts;


--  Purchase Timing Cohorts
WITH user_cohort AS (
    SELECT
        f.user_id,
        MIN(f.event_timestamp::date) AS first_event_date,
        MIN(p.event_timestamp::date) AS first_purchase_date
    FROM events f
    LEFT JOIN events p ON f.user_id = p.user_id AND p.event_name = 'purchase'
    GROUP BY f.user_id
)
SELECT
    COUNT(CASE WHEN first_purchase_date - first_event_date BETWEEN 1 AND 3 THEN 1 END) AS users_1_3_days_purchase,
    COUNT(CASE WHEN first_purchase_date - first_event_date BETWEEN 4 AND 7 THEN 1 END) AS users_4_7_days_purchase,
    COUNT(user_id) AS total_users,
    COUNT(CASE WHEN first_purchase_date IS NOT NULL THEN 1 END) AS total_purchased_users
FROM user_cohort;


--  Country-wise Conversion Rate
WITH user_flags AS (
    SELECT
        e.user_id,
        u.country,
        MAX(CASE WHEN e.event_name = 'purchase' THEN 1 ELSE 0 END) AS purchased
    FROM events e
    JOIN users u ON e.user_id = u.user_id
    GROUP BY e.user_id, u.country
)
SELECT
    country,
    COUNT(user_id) AS total_users,
    SUM(purchased) AS total_purchasers,
    ROUND(100.0 * SUM(purchased) / NULLIF(COUNT(user_id), 0), 2) AS conversion_rate_pct
FROM user_flags
GROUP BY country
ORDER BY conversion_rate_pct DESC;


--  Conversion Rate by Source
SELECT
    u.source,
    COUNT(DISTINCT CASE WHEN e.event_name = 'purchase' THEN e.user_id END) * 1.0 /
    NULLIF(COUNT(DISTINCT e.user_id), 0) AS conversion_rate
FROM users u
JOIN events e ON u.user_id = e.user_id
GROUP BY u.source
ORDER BY conversion_rate DESC;