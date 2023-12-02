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
