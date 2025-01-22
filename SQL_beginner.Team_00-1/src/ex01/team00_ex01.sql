WITH RECURSIVE trips AS (
    SELECT point1 AS start_city,
           point1 || ',' || point2 AS tour,
           point2 AS current_city,
           cost AS total_cost,
           ARRAY[point1, point2] AS cities_visited
    FROM routes
    WHERE point1 = 'a'
  
    UNION ALL

    SELECT t.start_city,
           t.tour || ',' || r.point2 AS tour,
           r.point2 AS current_city,
           t.total_cost + r.cost AS total_cost,
           t.cities_visited || r.point2 AS cities_visited
    FROM trips t
    JOIN routes r ON t.current_city = r.point1
    WHERE r.point2 <> ALL(t.cities_visited) AND ARRAY_LENGTH(t.cities_visited, 1) < 4
),
all_tours AS (
    SELECT 
        t.total_cost + r.cost AS total_cost,
        CASE
            WHEN r.point2 = t.start_city THEN '{' || t.tour || ',' || r.point2 || '}'
            ELSE t.tour || ',' || r.point2 || ',' || t.start_city
        END AS tour
    FROM trips t
    JOIN routes r ON t.current_city = r.point1 AND r.point2 = t.start_city
    WHERE ARRAY_LENGTH(t.cities_visited, 1) = 4
)
SELECT total_cost, tour
FROM all_tours
WHERE total_cost = (SELECT MIN(total_cost) FROM all_tours) 
OR total_cost = (SELECT MAX(total_cost) FROM all_tours) 
ORDER BY total_cost, tour;
