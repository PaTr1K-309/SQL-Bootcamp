SELECT person.name
    FROM person_order
        INNER JOIN person ON person_order.person_id = person.id
        INNER JOIN menu ON person_order.menu_id = menu.id
            WHERE menu.pizza_name IN ('pepperoni pizza', 'mushroom pizza')
                AND person.gender = 'male'
                    AND person.address IN ('Moscow', 'Samara')
ORDER BY name DESC