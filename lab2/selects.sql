/* 1. Инструкция SELECT, использующая предикат сравнения */
SELECT *
FROM animals
WHERE weight > 100;

/* 2. Инструкция SELECT, использующая предикат BETWEEN */
SELECT *
FROM aviary
WHERE cleaning_stuff_size between 2 and 5;

/* 3. Инструкция SELECT, использующая предикат LIKE */
SELECT *
FROM animals
WHERE species LIKE '%i%';

/* 4. Инструкция SELECT, использующая предикат IN со вложенным подзапросом */
SELECT *
FROM aviary
WHERE pavilion IN (SELECT pavilion from aviary WHERE size > 4984);

/* 5. Инструкция SELECT, использующая предикат EXISTS со вложенным подзапросом */
SELECT *
FROM aviary
WHERE EXISTS
(SELECT * FROM aviary WHERE size < 500);

/* 6. Инструкция SELECT, использующая предикат сравнения с квантором */
SELECT cost
FROM items
WHERE WEIGHT > ALL(
                SELECT WEIGHT
                FROM items
                WHERE cost < 600
);

/* 7. Инструкция SELECT, использующая агрегатные функции в выражениях столбцов */
SELECT AVG(cost)
FROM items;

/* 8. Инструкция SELECT, использующая скалярные подзапросы в выражениях столбцов */
SELECT *
FROM items
WHERE cost > (SELECT AVG(cost) from items);

/* 9. Инструкция SELECT, использующая простое выражение CASE */
SELECT id,
     CASE outdoors
        WHEN TRUE THEN 'Outdoors' ELSE 'Inside'
        end as Location
FROM aviary;

/* 10. Инструкция SELECT, использующая поисковое выражение CASE */
SELECT id,
    CASE
        WHEN cost is NULL THEN 'Item not for sale'
        WHEN cost = 0 THEN 'Item is free'
        WHEN cost < 50 THEN 'Item costs less than 50'
        WHEN cost < 250 THEN 'Item costs less than 250'
        ELSE 'Item costs more than 250'
        end as price
FROM items;

/* 11. Создание новой временной локальной таблицы из результирующего набора данных инструкции SELECT */
SELECT id, cost, type
into #specification_table
FROM items;

/* 12. Инструкция SELECT, использующая вложенные коррелированные подзапросы в качестве производных таблиц в предложении FROM */
SELECT *
FROM (SELECT * from items where cost < 700) as cheap_items
WHERE type = 'medicine';

/* 13. Инстркуция SELECT, использующая вложенные подзапросы с уровнем вложенности 3 */
/* вид и возраст животного для которого есть свободное лекарство*/
SELECT animals.species, animals.age
from animals JOIN (
        SELECT items_to_animals.animal_id
        FROM items_to_animals join (
        	select items.id
        	from items
        	where type = 'medicine') as medicine_table
        	on items_to_animals.id = medicine_table.id
        WHERE items_to_animals.availability = TRUE
) as animals_with_items
on animals.id = animals_with_items.animal_id;

/* 14. Инстркуция SELECT, консолидирующая данные с помощью предложения GROUP BY, но без предложения HAVING */
SELECT species, avg(weight) as avg_weight, max(age) as max_age
FROM animals
GROUP BY species;

/* 15. Инстркуция SELECT, консолидирующая данные с помощью предложения GROUP BY и предложения HAVING */
/* виды предметов, стоимость которых выше средней */
SELECT type
FROM items
GROUP BY type
HAVING AVG(cost) > (SELECT AVG(cost) FROM items);

/* 16. Однострочная INSERT, выполняющая вставку в таблицу одной строки значений */
insert INTO items_to_animals (animal_id, item_id, availability)
VALUES (12, 13, TRUE);

/* 17. Многострочная инструкция INSERT, выполняющая вставку в таблицу результирующего набора данных вложенного подзапроса */
insert into animals (aviary_id, species, weight, height, endangered, age)
SELECT 10, 'unicorn', avg(animals.weight), avg(animals.height), true, max(animals.age)
from animals
WHERE species = 'horse';

/* 18. Простая инструкция UPDATE */
UPDATE items
SET cost = cost + cost * 0.1
WHERE cost is not null;

/* 19. Инструкция UPDATE со скалярным подзапросом в предложении SET */
UPDATE items
SET cost = cost + 0.1 * (
    SELECT AVG(cost)
    FROM items
    WHERE cost is not null
)
WHERE cost is not null;

/* 20. Простая инструкция DELETE */
DELETE FROM items_to_animals
WHERE id = 10;

/* 21. Инструкция DELETE со вложенным коррелированным подзапросом в предложении WHERE */
DELETE FROM items_to_animals
WHERE id in (SELECT id
            FROM items_to_animals
            WHERE availability = true and id between 15 and 20
);

/* 22. Инструкция SELECT, использующая простое обобщённое табличное выражение */
WITH TallAnimals (id, species, height, weight, age)
AS
(
    SELECT id, species, height, weight, age
    FROM animals
    WHERE height > (SELECT AVG(height)
    					    from animals)
)
SELECT *
FROM TallAnimals
WHERE age > 50;
/* 23. Инструкция SELECT, использующая рекурсивное обобщённое табличное выражение */
WITH RECURSIVE t(n) AS (
    VALUES (1)
  UNION ALL
    SELECT n+1 FROM t WHERE n < 100
)
SELECT sum(n) FROM t;

/* 24. Оконные функции. Использование конструкция MIN/MAX/AVG/OVER() */
SELECT id, species, weight,
rank() over(partition by species order by weight desc)
FROM animals;

/* 25. Оконные функции для устранения дублей */
WITH C as (
SELECT *,
rank() over(order by id)
FROM animals
),
D as (SELECT *, LAG(rank) over(order by rank) as previous_id
	FROM C
)
SELECT *
FROM D
where rank != previous_id;
