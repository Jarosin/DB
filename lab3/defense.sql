-- защита
-- для таблицы с животными будет считать количество конкретных изменений(кол-во insert, delete, update)

create table change_animals(
    insert_total integer,
    delete_total integer,
    update_total integer
)

insert into change_animals(insert_total, delete_total, update_total, id)
VALUES (0, 0, 0)

create or replace function update_insert_total_trigger()
returns trigger
AS
$$
    declare
    begin
        update change_animals
        set insert_total = insert_total + 1;

        return new;
    end;
$$
language plpgsql;

create or replace function update_update_total_trigger()
returns trigger
AS
$$
    declare
    begin
        update change_animals
        set update_total = update_total + 1;

        return new;
    end;
$$
language plpgsql;

create or replace function update_delete_total_trigger()
returns trigger
AS
$$
    declare
    begin
        update change_animals
        set delete_total = delete_total + 1;

        return new;
    end;
$$
language plpgsql;


create trigger "count_update_total_animals"
    AFTER update on animals
    for each row
    execute procedure update_update_total_trigger();

create trigger "count_delete_total_animals"
    AFTER delete on animals
    for each row
    execute procedure update_delete_total_trigger();

create or replace trigger "count_insert_total_animals"
    AFTER insert on animals
    for each row
    execute procedure update_insert_total_trigger();

select * from change_animals;

insert into animals (id, aviary_id, species, weight, height, endangered, age)
values (1265, 10, 'wolf', 3, 4, true, 25);

Update animals
set endangered = false
where id = 1265;

delete from animals
where id = 1265;

select * from change_animals;
