WITH PepperoniOrders AS (
    SELECT person_id
        FROM person_order
            INNER JOIN menu ON person_order.menu_id = menu.id
    WHERE menu.pizza_name = 'pepperoni pizza'
),
CheeseOrders AS (
    SELECT person_id
        FROM person_order
            INNER JOIN menu ON person_order.menu_id = menu.id
        WHERE menu.pizza_name = 'cheese pizza'
)
SELECT DISTINCT p.name
    FROM person p
        INNER JOIN PepperoniOrders po ON p.id = po.person_id
        INNER JOIN CheeseOrders co ON p.id = co.person_id
    WHERE p.gender = 'female'
ORDER BY p.name;
