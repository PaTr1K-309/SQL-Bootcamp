-- fnc_usr_balance_by_currency()
-- fnc_total_balance_by_usr_id();

-- fnc_usr_balance_by_currency()
create or replace FUNCTION fnc_usr_balance_by_currency()
returnS table (
  user_id bigint,
    money numeric,
    type INTEGER,
    currency_id INTEGER
) AS $$
bEGIN
  return query
  select b.user_id, SUM(b.money), b.type, b.currency_id 
    from balance b
  group by b.user_id, b.type, b.currency_id;
END
$$ LANGUAGE plpgsql;

-- fnc_total_balance_by_usr_id();
create or replace function fnc_total_balance_by_usr_id()
RETURNS TABLE (
  user_id BIGINT,
    money NUMERIC,
    type INTEGER,
    currency_name VARCHAR,
    last_rate_to_usd NUMERIC,
    total_volume_in_usd NUMERIC
) AS $$
BEGIN
  return QUERy
      select bbc.user_id, bbc.money, bbc.type, COALESCE(last_rate_to_usd.name, 'not defined'), COALESCE(last_rate_to_usd.rate_to_usd, 1), 
          (bbc.money * COALESCE(last_rate_to_usd.rate_to_usd, 1)) AS total_volume_in_usd
    from fnc_usr_balance_by_currency() AS bbc
    FULL join 
    (SELECT DISTINCT on (name) 
    id, name, cr.rate_to_usd
    from currency cr
    order by name, updated DESC) AS last_rate_to_usd
    ON last_rate_to_usd.id = bbc.currency_id;
END
$$ language plpgsql;

select
  COALESCE(u.name, 'not defined') as name, 
  COALESCE(u.lastname, 'not defined') AS lastname, 
  tb.type, 
  tb.money as volume, 
  tb.currency_name, 
  tb.last_rate_to_usd, 
  tb.total_volume_in_usd
from "user" u
full join fnc_total_balance_by_usr_id() tb on u.id = tb.user_id
ORDER by u.name DESC NULLS LAST, u.lastname ASC NULLS FIRST, tb.type ASC;
