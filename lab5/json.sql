-- 1. Из таблиц базы данных, созданной в первой лабораторной работе, извлечь
-- данные в XML (MSSQL) или JSON(Oracle, Postgres). Для выгрузки в XML
-- проверить все режимы конструкции FOR XML

-- select jsonb_agg(jsonb_build_object('id', id, 'aviary_id', aviary_id, 'age', age,
--                                     'weight', weight, 'height', height, 'species',
--                                     species, 'endangered', endangered)) as animals
-- from animals;

-- select jsonb_agg(jsonb_build_object('id', id, 'size', size, 'pavilion', pavilion,
--                                     'outdoors', outdoors, 'construction_date', construction_date,
--                                     'cleaning_stuff_size', cleaning_stuff_size)) as aviaries
-- from aviary;

-- select jsonb_agg(jsonb_build_object('id', id, 'cost', cost, 'weight', weight,
--                                     'type', type, 'expiraton_date', expiraton_date)) as json_items
-- from items;

-- select jsonb_agg(jsonb_build_object('id', id, 'animal_id', animal_id, 'item_id', item_id,
--                                    'availability', availability))
-- from items_to_animals;

COPY (Select array_to_json(array_agg(row_to_json(a))) from animals a)
to '/tmp/animals.json';

sudo mv /tmp/animals.json /home/jarozin/uni/sem5/DB/lab5/

COPY (Select array_to_json(array_agg(row_to_json(a))) from aviary a)
to '/tmp/aviary.json';

sudo mv /tmp/aviary.json /home/jarozin/uni/sem5/DB/lab5/

COPY (Select array_to_json(array_agg(row_to_json(i))) from items i)
to '/tmp/items.json';

sudo mv /tmp/items.json /home/jarozin/uni/sem5/DB/lab5/

COPY (Select array_to_json(array_agg(row_to_json(ia))) from items_to_animals ia)
to '/tmp/items_to_animals.json';

sudo mv /tmp/items_to_animals.json /home/jarozin/uni/sem5/DB/lab5/

---------------------------------

-- 2. Выполнить загрузку и сохранение XML или JSON файла в таблицу.
-- Созданная таблица после всех манипуляций должна соответствовать таблице
-- базы данных, созданной в первой лабораторной работе.

DROP TABLE IF EXISTS items_json;
CREATE TABLE IF NOT EXISTS items_json (
    id integer ,
    cost DECIMAL,
    weight DECIMAL DEFAULT 0,
    type item_type ,
    expiraton_date DATE
);

ALTER TABLE items_json
ADD CONSTRAINT pk_items_json PRIMARY KEY(id);
ALTER TABLE items_json
ALTER COLUMN weight SET NOT NULL;
ALTER TABLE items_json
ALTER COLUMN type SET NOT NULL;
ALTER TABLE items_json
ADD CONSTRAINT price_check_json CHECK(cost > 0);
ALTER TABLE items_json
ADD CONSTRAINT weight_check_json CHECK(weight > 0);

DROP TABLE IF EXISTS json_table;
CREATE TABLE IF NOT EXISTS json_table
(
    data JSONB
);

COPY json_table(data) from '/tmp/items.json';

Select * from json_table;

insert into items_json
select
    (data->>'id')::integer,
    (data->>'cost')::DECIMAL,
    (data->>'weight')::decimal,
    (data->>'type')::item_type,
    (data->>'expiraton_date')::date
from (SELECT jsonb_array_elements(data) AS data FROM json_table) as data;

select * from items_json;

-- 3. Создать таблицу, в которой будет атрибут(-ы) с типом XML или JSON, или
-- добавить атрибут с типом XML или JSON к уже существующей таблице.
-- Заполнить атрибут правдоподобными данными с помощью команд INSERT
-- или UPDATE.

DROP TABLE IF EXISTS animal_json_atr;
CREATE TABLE IF NOT EXISTS animal_json_atr
(
    id int PRIMARY KEY,
    name text NOT NULL,
    personal_data JSONB
);

INSERT INTO animal_json_atr VALUES
(1, 'Pumba', '{"tail_length" : 9, "hobby" : {"early_life": "eating glue", "late_life": "being a king"}}'),
(2, 'Mufasa', '{"tail_length" : 13, "hobby" : {"early_life": "playing with others", "late_life": "playing with deers"}}');

select * from animal_json_atr;

UPDATE animal_json_atr
SET personal_data = '{"tail_length" : 10, "hobby" : {"early_life": "playing with family", "late_life": "defeating scratch"}}';

select * from animal_json_atr;

-- 4. Выполнить следующие действия:
-- 1. Извлечь XML/JSON фрагмент из XML/JSON документа
SELECT
       name,
       personal_data->>'tail_length' AS tail_length,
       personal_data->'hobby' AS hobby
FROM animal_json_atr;
-- 2. Извлечь значения конкретных узлов или атрибутов XML/JSON
-- документа
SELECT
       name,
       personal_data->>'tail_length' AS tail_length,
       personal_data->'hobby'->>'early_life' AS hobby
FROM animal_json_atr;
-- 3. Выполнить проверку существования узла или атрибута
INSERT INTO animal_json_atr VALUES
(3, 'Scrach', '{"tail_length" : 4, "hobby" : "NULL"}'),
(4, 'Mom', NULL);

select * from animal_json_atr;

SELECT *
FROM animal_json_atr
where personal_data IS NOT NULL;

SELECT *
FROM animal_json_atr
where personal_data IS NOT NULL and personal_data->>'hobby' != 'NULL';
-- 4. Изменить XML/JSON документ
UPDATE animal_json_atr
SET personal_data = '{"tail_length" : 10, "hobby" : {"early_life": "playing with family", "late_life": "defeating scratch"}}'
where personal_data is null;

select * from animal_json_atr;
-- 5. Разделить XML/JSON документ на несколько строк по узлам
SELECT jsonb_array_elements(data) AS data FROM json_table;
