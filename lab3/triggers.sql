create or replace function update_animals()
returns trigger
AS
$$
    declare
    begin
        raise notice 'new animal created with id = (%)', new.id;
        return new;
    end;
$$
language plpgsql;

create or replace trigger "update_animals_after_insert_trigger"
AFTER insert on animals
for each row
execute procedure "update_animals"();


insert into animals (id, aviary_id, species, weight, height, endangered, age)
values (1260, 10, 'wolf', 3, 4, true, 25);

--------------------------------------------------------------

create or replace function update_aviary()
returns trigger
AS
$$
    declare
    begin
        raise notice 'tried to change aviary row with id: (%)', old.id;
        return new;
    end;
$$
language plpgsql;

CREATE VIEW aviary_view AS
SELECT *
FROM aviary;

create trigger "update_aviary_instead_of_trigger"
    INSTEAD of update on aviary_view
    for each row
    execute procedure "update_aviary"();

update aviary_view
set outdoors = false
where id = 1;
