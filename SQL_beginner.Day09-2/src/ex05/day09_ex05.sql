DROP FUNCTION IF EXISTS fnc_persons_female;
DROP FUNCTION IF EXISTS fnc_persons_male;

CREATE OR REPLACE FUNCTION fnc_persons(IN pgender varchar DEFAULT 'female')
RETURNS TABLE (
    id bigint,
    name varchar,
    age integer,
    gender varchar,
    address varchar
) AS $person_audit$
    (SELECT 
        person.id, person.name, person.age, person.gender, person.address
    FROM person
        WHERE person.gender = pgender);
$person_audit$ LANGUAGE sql;

SELECT * FROM fnc_persons(pgender := 'male');

SELECT * FROM fnc_persons();