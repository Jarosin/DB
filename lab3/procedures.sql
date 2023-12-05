Create or replace procedure add_inflation_to_cost(inflation_coeff numeric)
as $$
    declare
	BEGIN
        UPDATE items
        set cost = cost * inflation_coeff;
	end;
$$ LANGUAGE plpgsql;

-------------------------------------------------------------------

-- из dbeaver не видно, делай из psql(вход: sudo -u postgres psql)
Create or replace procedure print_n_animals_age(n integer)
as
$$
	declare
        age integer;
	begin
        SELECT animals.age into age from animals where animals.id = n;

        RAISE notice 'Id = (%), age = (%)', n, age;
		if n > 0 then
			call print_n_animals_age(n - 1);
            return;
		end if;
	end;
$$ LANGUAGE plpgsql;

call print_n_animals_age(5);

-------------------------------------------------------------------

Create or replace procedure sum_items_cost(out sum_cost numeric)
as $$
    DECLARE
        c CURSOR FOR SELECT cost FROM items;
        total items.cost%TYPE;
        cur_cost items.cost%TYPE;
	BEGIN
        total := 0;
        open c;
        loop

        fetch from c into cur_cost;

        exit when not found;

        total := total + cur_cost;
        end loop;

        close c;
        sum_cost := total;
	end;
$$ LANGUAGE plpgsql;

create or replace procedure print_sum_cost()
as $$
    DECLARE
        total numeric;
	BEGIN
        call sum_items_cost(total);
        raise notice 'Calculated total equal: %', total;
	end;
$$ LANGUAGE plpgsql;

call print_sum_cost();

-------------------------------------------------------------------
create or replace procedure print_all()
    language plpgsql as
$$
declare
    r record;
begin
	for r in (select table_name from information_schema.tables where table_schema='public')
	    loop
	        RAISE notice 'Таблица из базы данных называется %', r;
	    end loop;
end
$$;

call print_all();
