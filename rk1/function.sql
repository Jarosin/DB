create or replace procedure starts_from(in prefix varchar(10), out total integer)
as
$$
    declare
    	r record;
    begin
        total := 0;
        for r in (select * from rk2.INFORMATION_SCHEMA.ROUTINES where routine_type = 'procedure' and left(ROUTINE_NAME, 10) not in (prefix)) LOOP
            total := total + 1;
            RAISE NOTICE '%', r.body;
        end LOOP;
    end;
$$ LANGUAGE plpgsql;

create or replace procedure hi()
as $$
BEGIN
    RAISE NOTICE 'hi';
end;
$$ LANGUAGE plpgsql;

create or replace procedure check_proc()
as
$$
declare
    total integer;
    hi varchar(10);
begin
    hi := 'hi';
    call starts_from(hi, total);
    RAISE NOTICE '%', total;
end;
$$ LANGUAGE plpgsql;

call check_proc();
