-- SELECT с квантором
select *
from excursion
where opening_date > (select opening_date from excursion where id = 5);

-- DELETE с корелированным подзапросом в where - удаляет экскурсию с максимальным id экскурсии, которая связана со стэнтами.
DELETE FROM excursion
WHERE id = (select max(id) from
			(select id from stand_to_excursion where stand_to_excursion.excursion_id = excursion.id) as ids);

-- Оконная функция - выводит лексикографически отсортированную по адрессу таблицу, позволяет увидеть, у каких посетителей один адрес
SELECT id, name, phone_number, adress,
rank() over(order by adress)
FROM visitor;
