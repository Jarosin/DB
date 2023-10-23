Create or replace procedure add_inflation_to_cost(inflation_coeff numeric)
as $$
    declare
	BEGIN
        UPDATE items
        set cost = cost * inflation_coeff;
	end;
$$ LANGUAGE plpgsql;

Create or replace procedure sum_items_cost(out sum_cost numeric)
as $$
    DECLARE
        c CURSOR FOR SELECT cost FROM items;
        SQLSTATE CHAR(5) DEFAULT '00000';
        total items.cost%TYPE;
        cur_cost items.cost%TYPE;
	BEGIN
        total := 0;
        open c;
        fetch from c into cur_cost;
        WHILE SQLSTATE = '00000' LOOP
            total := total + cur_cost;
            fetch from c into cur_cost;
        END LOOP;

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
        raise notice '%', total;
	end;
$$ LANGUAGE plpgsql;


create or replace procedure print_all()
    language plpgsql as
$$
declare
    r record;
begin
	for r in (select table_name from information_schema.tables where table_schema='public')
	    loop
	        RAISE NOTICE '%', r;
	    end loop;
end
$$;
