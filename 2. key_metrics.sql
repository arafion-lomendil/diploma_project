-- Получение общих данных - вычислим общие значения ключевых показателей сервиса за весь период
SELECT currency_code,
SUM(revenue) AS total_revenue,
COUNT(order_id) AS total_orders,
AVG(revenue) AS avg_revenue_per_order,
COUNT(DISTINCT user_id) AS total_users
FROM afisha.purchases
GROUP BY 1
ORDER BY 2 DESC;

-- Посмотрим на распределения выручки в разрезе устройств
SELECT device_type_canonical,
SUM(revenue) AS total_revenue,
COUNT(order_id) AS total_orders,
AVG(revenue) AS avg_revenue_per_order,
ROUND(SUM(revenue)::numeric / (SELECT 
  SUM(revenue)::numeric
  FROM afisha.purchases
  WHERE currency_code = 'rub'),3) AS revenue_share
FROM afisha.purchases
WHERE currency_code = 'rub'
GROUP BY 1
ORDER BY 5 DESC;

-- Изучим распределения выручки в разрезе типа мероприятий
SELECT event_type_main,
SUM(revenue) AS total_revenue,
COUNT(order_id) AS total_orders,
AVG(revenue) AS avg_revenue_per_order,
COUNT(DISTINCT event_name_code) AS total_event_name,
AVG(tickets_count) AS average_tickets,
(SUM(revenue)/SUM(tickets_count)) AS avg_ticket_revenue,
ROUND(SUM(revenue)::numeric / (SELECT 
  SUM(revenue)::numeric
  FROM afisha.purchases
  WHERE currency_code = 'rub'),3) AS revenue_share
FROM afisha.events
JOIN afisha.purchases USING(event_id)
WHERE currency_code = 'rub'
GROUP BY 1
ORDER BY 3 DESC;

-- Изучим динамику изменения ключевых метрик по неделям
SELECT DATE_TRUNC('week', created_dt_msk)::date AS week,
SUM(revenue) AS total_revenue,
COUNT(order_id) AS total_orders,
COUNT(DISTINCT user_id) AS total_users,
SUM(revenue)/COUNT(order_id) AS revenue_per_order
FROM afisha.purchases
WHERE currency_code='rub'
GROUP BY 1
ORDER BY 1;

-- Выведем топ-7 регионов по значению общей рублевой выручки
SELECT region_name,
SUM(revenue) AS total_revenue,
COUNT(order_id) AS total_orders,
COUNT(DISTINCT user_id) AS total_users,
SUM(tickets_count) AS total_tickets,
SUM(revenue)/SUM(tickets_count) AS one_ticket_cost
FROM afisha.regions
JOIN afisha.city USING(region_id)
JOIN afisha.events USING(city_id)
JOIN afisha.purchases USING(event_id)
WHERE currency_code='rub'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 7;

/* В жтом исследовании основным показателем, который определяет эффективность продукта, 
считается выручка с заказов билетов на мероприятия. При этом такие показатели, как количество заказов, 
средняя стоимость заказа и билета, а также среднее количество билетов в заказе могут использоваться как опережающие.
Теперь на основе полученныз данных необходимо спроектировать дашборд, отобразить динамику этих метрик, а также детализировать 
структуру выручки и найти наиболее прибыльные мероприятия.
*/
