insert into currency values (100, 'EUR', 0.85, '2022-01-01 13:29'); 
insert into currency values (100, 'EUR', 0.79, '2022-01-08 13:29');

SELECT 
    COALESCE(u.name, 'not defined') AS name,
    COALESCE(u.lastname, 'not defined') AS lastname,
    COALESCE(c1.name, c2.name) AS currency_name,
    COALESCE(b.money, 0) * COALESCE(c1.rate_to_usd, c2.rate_to_usd) AS currency_in_usd
FROM "user" u
FULL OUTER JOIN
	balance b ON u.id = b.user_id
LEFT JOIN LATERAL
	(SELECT rate_to_usd, name, updated, id
     FROM currency
     WHERE currency.updated <= b.updated
           AND currency.id = b.currency_id
     ORDER BY currency.updated DESC
     LIMIT 1) c1 ON true
LEFT JOIN LATERAL
	(SELECT currency.rate_to_usd, name, updated
     FROM currency
     WHERE currency.updated > b.updated
           AND currency.id = b.currency_id
     ORDER BY currency.updated
     LIMIT 1) c2 ON true
WHERE COALESCE(c1.name, c2.name) IS NOT NULL
ORDER BY name DESC, lastname, currency_name;