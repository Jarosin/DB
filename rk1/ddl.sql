create table excursion(
    id integer PRIMARY KEY,
    name varchar(30) not null,
    description text,
    opening_date date,
    closing_date date
);

create table stand(
    id integer primary key,
    name varchar(30) not null,
    subject_field varchar(30) not null,
    description text
);

create table visitor(
    id integer primary key,
    name varchar(50) not null,
    adress varchar(100),
    phone_number varchar(20)
);

create table stand_to_excursion(
    stand_id integer references stand(id) on delete cascade,
    excursion_id integer references excursion(id) on delete cascade,
    PRIMARY KEY (stand_id, excursion_id)
);

create table excursion_to_visitor(
    id integer primary key,
    excursion_id integer references excursion(id) on delete cascade,
    visitor_id integer references visitor(id) on delete cascade
);

alter table excursion add CONSTRAINT later_date check(closing_date > opening_date);
