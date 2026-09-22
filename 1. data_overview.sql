-- Для начала познакомимся поближе с основной таблицей purchases
-- Посчитаем общее количество заказов и уникальных пользователей
SELECT COUNT(order_id) AS order_cnt,
COUNT(DISTINCT user_id) AS user_cnt
FROM purchases;
-- Посмотрим на временной диапазон данных
SELECT MIN(created_dt_msk)::date AS min_date,
MAX(created_dt_msk)::date AS max_date
FROM purchases;
-- Как распределены заказы по возрастным категориям
SELECT age_limit,
COUNT(order_id) AS order_cnt 
FROM purchases
GROUP BY 1
ORDER BY 2 DESC;
-- На каких устройствах чаще делаются заказы
SELECT device_type_canonical,
COUNT(order_id) AS order_cnt
FROM purchases
GROUP BY 1
ORDER BY 2 DESC;
-- В какой валюте делаются заказы
SELECT currency_code,
COUNT(order_id) AS order_cnt
FROM purchases
GROUP BY 1
ORDER BY 2 DESC;
-- Проверим выручку на основные показатели
SELECT MIN(revenue) AS min_revenue,
MAX(revenue) AS max_revenue,
ROUND(AVG(revenue)::integer,4) AS avg_revenue,
ROUND(STDDEV(revenue)::integer,4) AS std_revenue
FROM afisha.purchases;
-- Проверим как распределены заказы по билетным операторам
SELECT service_name,
COUNT(order_id) AS order_cnt
FROM afisha.purchases
GROUP BY 1
ORDER BY 2 DESC;

-- Также рассмотрим таблицы с информацией о событиях (events), городах (cities), площадках (venues) и регионах (regions).
-- Узнаем как отличается количество уникальных мероприятий от присвоенных идентификаторов
SELECT COUNT(DISTINCT event_id) AS event_cnt,
COUNT(DISTINCT event_name_code) AS event_code_cnt
FROM afisha.events;
-- Количество представленных городов
SELECT COUNT(DISTINCT city_id)
FROM afisha.city;
-- Количество регионов
SELECT COUNT(DISTINCT region_id)
FROM afisha.regions;

/*
Итак, после знакомства с данными выделим несколько важных особенностей:
- Зафиксированы высокие значения, которые могут повлиять на статистический анализ выручки с заказа.
- Выручка представлена в российских рублях и казахстанских тенге, что необходимо учитывать при расчётах и построении дашборда.
- Некоторые категории, такие как платформы, устройства и типы событий, содержат мало уникальных значений, а другие, как города, 
наоборот, представлены большим количеством значений.
- Среди платформ видны как лидеры, так и наименования с несколькими строками в базе. Такой дисбаланс следует учитывать
при сравнительном анализе данных.
*/




