COMMENT ON TABLE person_discounts IS 'Информация о персональных скидках в зависимости от количества заказов';
COMMENT ON COLUMN person_discounts.id IS 'Уникальный идентификатор каждой записи в таблице';
COMMENT ON COLUMN person_discounts.person_id IS 'Уникальный идентификатор человека из списка заказов';
COMMENT ON COLUMN person_discounts.pizzeria_id IS 'Уникальный идентификатор пиццерии, в которой был сделан заказ';
COMMENT ON COLUMN person_discounts.discount IS 'Значение скидки, рассчитанной в соответствии с количеством заказов';
