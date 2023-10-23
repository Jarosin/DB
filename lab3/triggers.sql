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

create trigger "update_animals_after_insert_trigger"
    AFTER insert on animals
    for each row
    execute procedure "update_animals"();










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
