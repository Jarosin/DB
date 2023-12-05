CREATE EXTENSION IF NOT EXISTS plpython3u;
SELECT * FROM pg_language;

-- Создать, развернуть и протестировать 6 объектов SQL CLR:

-- 1. Определяемую пользователем скалярную функцию CLR,
DROP FUNCTION IF EXISTS pyfn_get_total_item_type_cost;
CREATE OR REPLACE FUNCTION pyfn_get_total_item_type_cost(x_name VARCHAR(10))
RETURNS numeric
AS $$
    query = plpy.prepare("""
        select sum(cost) as sum
        from items
        where type = $1::item_type
        """, ["VARCHAR(10)"])
    result = plpy.execute(query, [x_name])
    if result:
        return result[0]["sum"]
$$ LANGUAGE plpython3u;
--
SELECT * FROM pyfn_get_total_item_type_cost('medicine'::VARCHAR(10));

-- 2. Пользовательскую агрегатную функцию CLR,
DROP FUNCTION IF EXISTS pyfn_get_total_item_type_total;
CREATE OR REPLACE FUNCTION pyfn_get_total_item_type_total(x_name VARCHAR(10))
RETURNS VARCHAR(32)
AS $$
    query = plpy.prepare("""
        select *
        from items
        where type = $1::item_type
        """, ["VARCHAR(10)"])
    result = plpy.execute(query, [x_name])
    if result:
        return len(result)
$$ LANGUAGE plpython3u;
--
SELECT * FROM pyfn_get_total_item_type_total('medicine'::VARCHAR(10));

-- 3. Определяемую пользователем табличную функцию CLR,
DROP FUNCTION IF EXISTS pyfn_get_animals_with_species;
CREATE OR REPLACE FUNCTION pyfn_get_animals_with_species(x_name VARCHAR(20))
RETURNS TABLE (
    id integer,
    endangered boolean,
    weight numeric
) AS $$
    query = plpy.prepare("""
        SELECT id, endangered, weight
        FROM animals
        WHERE species = $1
        """, ["VARCHAR(20)"])
    result = plpy.execute(query, [x_name])
    if result:
        return result
$$ LANGUAGE plpython3u;
--
SELECT * FROM pyfn_get_animals_with_species('hawk'::VARCHAR(20));

-- 4. Хранимую процедуру CLR,
CREATE OR REPLACE PROCEDURE pyfn_insert_animal(species VARCHAR(20))
AS $$
    query = plpy.prepare("""
        insert into animals (id, aviary_id, species, weight, height, endangered, age)
                     values (1560, 10, $1, 3, 4, true, 25);
    """, ["VARCHAR(20)"])
    plpy.execute(query, [species])
$$ LANGUAGE plpython3u;
--
CALL pyfn_insert_animal('panthera');
--
select * from animals where species = 'panthera';

-- 5. Триггер CLR,
CREATE OR REPLACE FUNCTION pyfn_you_shall_not_pass()
RETURNS TRIGGER
AS $$
    old = TD["old"]
    plpy.error(f"YOU SHALL NOT PASS {old['id']}")
    return None
$$ LANGUAGE plpython3u;
--
DROP VIEW items_copy;
CREATE VIEW items_copy AS
SELECT * FROM items;
--
CREATE OR REPLACE TRIGGER tg_you_shall_not_pass
    INSTEAD OF DELETE
    ON items_copy
    FOR EACH ROW
EXECUTE PROCEDURE pyfn_you_shall_not_pass();
--
DELETE FROM items_copy;

-- 6. Определяемый пользователем тип данных CLR.
CREATE TYPE item_type_count AS
(
    type item_type,
    count integer
);
DROP FUNCTION IF EXISTS pyfn_get_item_type_count;
CREATE OR REPLACE FUNCTION pyfn_get_item_type_count(required_type item_type)
RETURNS item_type_count
AS $$
    query = plpy.prepare("""
        SELECT type, COUNT(*) AS cnt
        FROM items
        WHERE type = $1
        GROUP BY type
        """, ["item_type"])
    result = plpy.execute(query, [required_type])
    if result:
        return (result[0]["type"], result[0]["cnt"])
$$ LANGUAGE plpython3u;
--
    SELECT * FROM pyfn_get_item_type_count('medicine'::item_type);
