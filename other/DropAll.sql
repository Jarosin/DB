create or replace procedure drop_all(inout drop_count integer = 0)
    language plpgsql as
$$
declare
    r record;
begin
    drop_count := 0;
    for r in (select tablename from pg_tables where schemaname = 'rk2')
        loop
            if exists (select *
                       from information_schema.tables as tb
                       where tb.table_name = r.tablename) then
                begin
                    drop_count := drop_count + 1;
                    RAISE NOTICE 'Here';
                end;
            end if;

            execute 'drop table if exists ' || quote_ident(r.tablename) || ' cascade';

        end loop;
end
$$;

call drop_all();
