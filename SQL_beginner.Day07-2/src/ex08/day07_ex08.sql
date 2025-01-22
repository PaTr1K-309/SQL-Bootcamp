SELECT
    person.address,
    pizzeria.name,
    COUNT(*) AS count_of_orders
    FROM person_order
        JOIN person ON person_order.person_id = person.id
        JOIN menu ON person_order.menu_id = menu.id
        JOIN pizzeria ON menu.pizzeria_id = pizzeria.id
    WHERE person.address IS NOT NULL
GROUP BY person.address, pizzeria.name
ORDER BY person.address, pizzeria.name;
