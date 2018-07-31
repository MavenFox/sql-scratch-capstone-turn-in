/*TASK 1*/
SELECT *
FROM page_visits
LIMIT 10;

SELECT COUNT(DISTINCT utm_campaign) AS 'Number of Distinct Campaigns'
FROM page_visits;

SELECT COUNT (DISTINCT utm_source) AS 'Number of Distinct Sources'
FROM page_visits;

SELECT DISTINCT utm_campaign AS 'Campaigns', utm_source AS 'Sources'
FROM page_visits;

/*TASK 2*/
SELECT DISTINCT page_name AS 'Website Pages'
FROM page_visits;

/*TASK 3*/
WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT pv.utm_source AS 'Source', pv.utm_campaign AS 'Campaign', COUNT (*) AS 'Campaign First Touches'
FROM first_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp
GROUP BY pv.utm_campaign
ORDER BY COUNT(*);

/*TASK 4*/
WITH last_touch AS (SELECT user_id, 
  MAX(timestamp) as last_touch_at 
  FROM page_visits 
  GROUP BY user_id)
SELECT pv.utm_source AS 'Source', pv.utm_campaign AS 'Campaign', COUNT (*) AS 'Campaign Last Touches'
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
GROUP BY pv.utm_campaign
ORDER BY COUNT(*);

/*TASK 5*/
SELECT COUNT(*) AS 'Landing Page'
FROM page_visits
WHERE page_name = '1 - landing_page';

SELECT COUNT(*) AS 'Shopping Cart'
FROM page_visits
WHERE page_name = '2 - shopping_cart';

SELECT COUNT(*) AS 'Checkout'
FROM page_visits
WHERE page_name = '3 - checkout';

SELECT COUNT(*) AS 'Visitor Purchases'
FROM page_visits
WHERE page_name = '4 - purchase';

/*TASK 6*/
WITH last_touch AS (
  SELECT user_id,
         MAX(timestamp) AS last_touch_at
  FROM page_visits
  WHERE page_name = '4 - purchase'
  GROUP BY user_id)
SELECT pv.utm_source AS 'Source', pv.utm_campaign AS 'Campaign', COUNT (*) AS 'Purchases From Last Touches'
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
WHERE page_name = '4 - purchase'
GROUP BY pv.utm_campaign
ORDER BY COUNT (*);