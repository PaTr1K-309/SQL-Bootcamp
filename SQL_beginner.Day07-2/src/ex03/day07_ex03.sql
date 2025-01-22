SELECT
    pizzeria.name,
    SUM(COALESCE(visit_count, 0)) + SUM(COALESCE(order_count, 0)) AS total_count
FROM
    pizzeria
LEFT JOIN
    (SELECT pizzeria_id, COUNT(*) AS visit_count
     FROM person_visits
     GROUP BY pizzeria_id) visits
ON pizzeria.id = visits.pizzeria_id
LEFT JOIN
    (SELECT pizzeria_id, COUNT(*) AS order_count
     FROM person_order
     INNER JOIN menu ON menu.id = person_order.menu_id
     GROUP BY pizzeria_id) orders
ON pizzeria.id = orders.pizzeria_id
GROUP BY pizzeria.name
ORDER BY total_count DESC, pizzeria.name;
