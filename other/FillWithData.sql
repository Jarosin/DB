insert into rk2.person (id, full_name, date_of_birth, experiences, phone_number)
values (1, 'A A A ', '2000-01-01', 10, '8800553535');

insert into rk2.person (id, full_name, date_of_birth, experiences, phone_number)
values (2, 'B B B ', '2000-01-01', 5, '8916924849');

insert into rk2.person (id, full_name, date_of_birth, experiences, phone_number)
values (3, 'C C C ', '2000-01-01', 7, '8916849840');

insert into rk2.person (id, full_name, date_of_birth, experiences, phone_number)
values (4, 'D D D ', '2000-01-01', 2, '8916473983');

insert into rk2.person (id, full_name, date_of_birth, experiences, phone_number)
values (5, 'E E E ', '2000-01-01', 4, '8916847838');

insert into rk2.task_type (id, type, time_consume, equipment)
values (1, 'Курсовая', 42, DEFAULT);
insert into rk2.task_type (id, type, time_consume, equipment)
values (2, 'Рк', 30, 'Компьютер');
insert into rk2.task_type (id, type, time_consume, equipment)
values (3, 'Дз', 3, DEFAULT);
insert into rk2.task_type (id, type, time_consume, equipment)
values (4, 'НИР', 72, 'Источники информации ');
insert into rk2.task_type (id, type, time_consume, equipment)
values (5, 'Диплом', 102, 'Компьютер');

insert into rk2.executor (id, id_work, id_customer)
values (1, 1, 1);
insert into rk2.executor (id, id_work, id_customer)
values (2, 1, 4);
insert into rk2.executor (id, id_work, id_customer)
values (3, 2, 2);
insert into rk2.executor (id, id_work, id_customer)
values (4, 5, 1);
insert into rk2.executor (id, id_work, id_customer)
values (5, 3, 3);

insert into rk2.performer (id, id_task, id_performer)
values (1, 1, 4);
insert into rk2.performer (id, id_task, id_performer)
values (2, 2, 5);
insert into rk2.performer (id, id_task, id_performer)
values (3, 1, 3);
insert into rk2.performer (id, id_task, id_performer)
values (4, 5, 1);
insert into rk2.performer (id, id_task, id_performer)
values (5, 2, 3);

insert into rk2."performer-executor" (id, id_performer, id_customer)
values (1, 1, 2);
insert into rk2."performer-executor" (id, id_performer, id_customer)
values (2, 3, 4);
insert into rk2."performer-executor" (id, id_performer, id_customer)
values (3, 1, 4);
insert into rk2."performer-executor" (id, id_performer, id_customer)
values (4, 2, 4);
insert into rk2."performer-executor" (id, id_performer, id_customer)
values (5, 3, 5);

