--Знакомство с данными таблицы purchases
SELECT COUNT(order_id) AS order_cnt,
COUNT(DISTINCT user_id) AS user_cnt
FROM purchases;

SELECT MIN(created_dt_msk)::date AS min_date,
MAX(created_dt_msk)::date AS max_date
FROM purchases;

SELECT age_limit,
COUNT(order_id) AS order_cnt 
FROM purchases
GROUP BY 1
ORDER BY 2 DESC;

SELECT device_type_canonical,
COUNT(order_id) AS order_cnt
FROM purchases
GROUP BY 1
ORDER BY 2 DESC;

SELECT currency_code,
COUNT(order_id) AS order_cnt
FROM purchases
GROUP BY 1
ORDER BY 2 DESC;

SELECT MIN(revenue) AS min_revenue,
MAX(revenue) AS max_revenue,
ROUND(AVG(revenue)::integer,4) AS avg_revenue,
ROUND(STDDEV(revenue)::integer,4) AS std_revenue
FROM afisha.purchases;
