SELECT female.name
    FROM 
        (SELECT * FROM person WHERE gender = 'female' AND age > '25') AS female
ORDER BY name ASC;