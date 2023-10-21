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

Create or replace function items_with_availibility_by_cost(old_age integer)
returns table(id integer, age integer)
as $$
	BEGIN
	QUERY
		select *
		from animals
		where animals.age > old_age;
	end;
$$ LANGUAGE plpgsql;
