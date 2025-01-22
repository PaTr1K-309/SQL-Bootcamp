SELECT person.name, COUNT(person_id) AS count_of_visits
    FROM person_visits
    INNER JOIN person ON person_visits.person_id = person.id
GROUP BY person.name
    HAVING COUNT(person) > 3;