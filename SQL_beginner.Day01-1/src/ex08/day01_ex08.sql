SELECT order_date,
(SELECT CONCAT(temp_peson.name, ' (age: ', temp_peson.age, ')'))
AS person_information
FROM person_order
NATURAL JOIN
(SELECT id AS person_id, name, age
FROM person) AS temp_peson
ORDER BY  order_date, name