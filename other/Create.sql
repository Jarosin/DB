create table task_type
(
    id           integer                                                     not null
        constraint work_type_pk
            primary key,
    type         varchar(100)     default 'Not specified'::character varying not null,
    time_consume double precision default 0                                  not null,
    equipment    varchar(100)     default 'Not specified'::character varying not null
);

create table person
(
    id            integer                                                 not null
        constraint person_pk
            primary key,
    full_name     varchar(100) default 'Not specified'::character varying not null,
    date_of_birth date                                                    not null,
    experiences   integer      default 0                                  not null,
    phone_number  varchar(32)  default 'Not specified'::character varying not null
);

create table performer
(
    id           integer not null
        constraint performer_pk
            primary key,
    id_task      integer
        constraint performer_work_type_id_fk
            references task_type,
    id_performer integer
        constraint performer_person_id_fk
            references person
);

create table executor
(
    id          integer not null
        constraint executor_pk
            primary key,
    id_work     integer
        constraint executor_work_type_id_fk
            references task_type,
    id_customer integer
        constraint executor_person_id_fk
            references person
);

create table "performer-executor"
(
    id           integer not null
        constraint "performer-executor_pk"
            primary key,
    id_performer integer
        constraint "performer-executor_person_id_fk"
            references person,
    id_customer  integer
        constraint "performer-executor_person_id_fk2"
            references person
);

