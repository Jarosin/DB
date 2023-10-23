CREATE function or replace avg_age() returns decimal
LANGUAGE sql
as 'select avg(age) from animals'

Create or replace function old_animals(old_age integer)
returns table(id integer, age integer)
as $$
	BEGIN
	return QUERY
		select animals.id, animals.age
		from animals
		where animals.age > old_age;
	end;
$$ LANGUAGE plpgsql;

Create or replace function item_with_cost_deviation_from_average()
returns items_with_cost table(id integer, deviation numeric)
as
$$
	declare
		average numeric;
	begin
		select avg(cost) into average from items;

		insert into items_with_cost
		select items.id, items.cost - average
		from items;
		return;
	end;
$$ LANGUAGE plpgsql;
