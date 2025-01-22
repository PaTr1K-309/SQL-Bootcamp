SELECT pizzeria.name
    FROM person_visits
        INNER JOIN person ON person.id = person_visits.person_id
        INNER JOIN pizzeria ON pizzeria.id  = person_visits.pizzeria_id
    WHERE person.name = 'Andrey'

EXCEPT

SELECT pizzeria.name
    FROM  person_order
        INNER JOIN person ON  person.id = person_order.person_id
        INNER JOIN menu ON menu.id = person_order.menu_id
        INNER JOIN pizzeria ON pizzeria.id = menu.pizzeria_id
    WHERE person.name = 'Andrey'

ORDER BY 1