-- защита
-- написать функцию принимающая вид животного  и тип предмета, определяющую сколько предметов для данного типа и суммарную стоимость этих предметов

drop function pyfn_get_item_count_and_type_count;
CREATE OR REPLACE FUNCTION pyfn_get_item_count_and_type_count(x_name VARCHAR(20), required_type item_type)
RETURNS TABLE (
    count integer,
    sum numeric
)
AS $$
    query = plpy.prepare("""
        select count(*), sum(cost)
        from (select * from animals a
        join items_to_animals ita
        on ita.animal_id = a.id
        join items i
        on i.id = ita.item_id and type = $1 and a.species = $2) as res
        group by res.type;
        """, ["item_type", "VARCHAR(20)"])
    result = plpy.execute(query, [required_type, x_name])
    if result:
        return result
$$ LANGUAGE plpython3u;

select * from pyfn_get_item_count_and_type_count('hawk'::VARCHAR(20), 'medicine'::item_type)
