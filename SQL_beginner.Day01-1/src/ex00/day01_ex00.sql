SELECT ID AS object_id, pizza_name AS object_name
FROM menu
UNION
SELECT ID AS object_id, NAME AS object_name
FROM person
ORDER BY object_id, object_name