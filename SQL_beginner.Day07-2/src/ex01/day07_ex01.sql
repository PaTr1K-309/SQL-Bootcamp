SELECT p.name, count(*) AS "count_of_visits"
    FROM person_visits
        INNER JOIN person p ON person_visits.person_id = p.id
        GROUP BY p.name
        ORDER BY 2 DESC, 1 ASC
    limit 4;