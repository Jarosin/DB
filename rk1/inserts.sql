insert into excursion(id, name, description, opening_date, closing_date)
values (1, 'Машины 19 века', 'Экскурсия по машинам 19 века', '2016-08-10', '2022-10-20');

insert into excursion(id, name, description, opening_date, closing_date)
values (2, 'История телефонов', 'Экскурсия посвященная телефонам', '2016-08-3', '2022-06-20');

insert into excursion(id, name, description, opening_date, closing_date)
values (3, 'Битвы великой Отечественной', 'Экскурсия по ключевым битвам Великой Отечественной', '2016-08-3', '2022-10-12');

insert into excursion(id, name, description, opening_date, closing_date)
values (4, 'Роботы', 'Экскурсия по роботам', '2013-08-10', '2019-10-20');

insert into excursion(id, name, description, opening_date, closing_date)
values (5, 'Игрушки', 'Экскурсия по игрушкам', '2016-08-03', '2022-10-06');

insert into excursion(id, name, description, opening_date, closing_date)
values (6, 'Телефоны', 'Экскурсия по телефонам', '2016-02-10', '2021-09-20');

insert into excursion(id, name, description, opening_date, closing_date)
values (7, 'Танки', 'Экскурсия танкам', '2017-08-10', '2023-10-20');

insert into excursion(id, name, description, opening_date, closing_date)
values (8, 'Конфеты', 'Экскурсия по конфетам', '2013-08-10', '2016-03-20');

insert into excursion(id, name, description, opening_date, closing_date)
values (9, 'Самолеты', 'Экскурсия по самолетам 20 века', '2016-08-10', '2018-10-20');

insert into excursion(id, name, description, opening_date, closing_date)
values (10, 'Дерижабли', 'Экскурсия по дерижаблям', '2016-08-10', '2019-10-20');


insert into stand(id, name, subject_field, description)
values (1, 'Дерижабль', 'Авиация', 'Дерижабль, построенный в 19 веке');

insert into stand(id, name, subject_field, description)
values (2, 'СУ-26', 'Авиация', 'Современный истребитель');

insert into stand(id, name, subject_field, description)
values (3, 'СУ-11', 'Авиация', 'Устаревший истребитель');

insert into stand(id, name, subject_field, description)
values (4, 'Милка', 'Конфеты', 'Известный производитель конфет');

insert into stand(id, name, subject_field, description)
values (5, 'Аленка', 'Конфеты', 'Отечественный производитель конфет');

insert into stand(id, name, subject_field, description)
values (6, 'Робот петр', 'Робототехника', 'Современный российский робот');

insert into stand(id, name, subject_field, description)
values (7, 'Робот пес', 'Робототехника', 'Последняя наработка Boston Dynamics');

insert into stand(id, name, subject_field, description)
values (8, 'Samsung', 'Телефоны', 'Один из самых больших производителей мобильных телефонов');

insert into stand(id, name, subject_field, description)
values (9, 'iPhone', 'Телефоны', 'Известный производитель телефонов');

insert into stand(id, name, subject_field, description)
values (10, 'Робокоп', 'Робототехника', 'Известный персонаж одноименных фильмов');


insert into visitor(id, name, adress, phone_number)
values (1, 'Петров Андрей Васильевич', 'Улица Арбат дом 10', '7-916-324-43-23');

insert into visitor(id, name, adress, phone_number)
values (2, 'Петров Генадий Васильевич', 'Улица Арбат дом 9', '7-916-123-33-21');

insert into visitor(id, name, adress, phone_number)
values (3, 'Петрова Анастасия Васильевна', 'Улица Арбат дом 11', '7-916-327-53-23');

insert into visitor(id, name, adress, phone_number)
values (4, 'Петров Петр Петрович', 'Улица Электрозаводская дом 10', '7-916-314-89-23');

insert into visitor(id, name, adress, phone_number)
values (5, 'Иванов Иван Иванович', 'Улица Ховрино дом 3', '7-916-324-22-11');

insert into visitor(id, name, adress, phone_number)
values (6, 'Зубец Анна Евгеньевна', 'Улица Ленина дом 1', '7-916-114-21-99');

insert into visitor(id, name, adress, phone_number)
values (7, 'Дубов Дмитрий Иванович', 'Улица Сталина дом 3', '7-916-311-28-77');

insert into visitor(id, name, adress, phone_number)
values (8, 'Петрова Дарья Андреевна', 'Улица Арбат дом 10', '7-916-324-43-23');

insert into visitor(id, name, adress, phone_number)
values (9, 'Селезнев Дмитрий Валерьевич', 'Улица Красный Октябрь дом 2', '7-916-876-41-23');

insert into visitor(id, name, adress, phone_number)
values (10, 'Лебедев Михаил Владимирович', 'Улица Жукова дом 3', '7-916-876-13-63');

insert into stand_to_excursion(stand_id, excursion_id)
values (2, 3);

insert into stand_to_excursion(stand_id, excursion_id)
values (3, 4);

insert into stand_to_excursion(stand_id, excursion_id)
values (1, 2);

insert into stand_to_excursion(stand_id, excursion_id)
values (5, 6);

insert into stand_to_excursion(stand_id, excursion_id)
values (1, 4);

insert into stand_to_excursion(stand_id, excursion_id)
values (7, 8);

insert into stand_to_excursion(stand_id, excursion_id)
values (8, 9);

insert into stand_to_excursion(stand_id, excursion_id)
values (9, 1);

insert into stand_to_excursion(stand_id, excursion_id)
values (3, 2);

insert into stand_to_excursion(stand_id, excursion_id)
values (7, 1);


insert into excursion_to_visitor(id, excursion_id, visitor_id)
values (1, 2, 3);

insert into excursion_to_visitor(id, excursion_id, visitor_id)
values (2, 3, 4);

insert into excursion_to_visitor(id, excursion_id, visitor_id)
values (3, 4, 5);

insert into excursion_to_visitor(id, excursion_id, visitor_id)
values (4, 5, 6);

insert into excursion_to_visitor(id, excursion_id, visitor_id)
values (5, 6, 7);

insert into excursion_to_visitor(id, excursion_id, visitor_id)
values (6, 7, 8);

insert into excursion_to_visitor(id, excursion_id, visitor_id)
values (7, 8, 9);

insert into excursion_to_visitor(id, excursion_id, visitor_id)
values (8, 9, 10);

insert into excursion_to_visitor(id, excursion_id, visitor_id)
values (9, 2, 1);

insert into excursion_to_visitor(id, excursion_id, visitor_id)
values (10, 3, 2);
