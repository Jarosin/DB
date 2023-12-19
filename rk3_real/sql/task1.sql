drop table if exists employees cascade;

create table if not exists employees(
    id INT primary key,
    name VARCHAR(64),
    date_of_birth DATE,
    department VARCHAR(64)
);

drop table if exists times cascade;

create table if not exists times(
    employee_id INT,
    foreign key (employee_id) references employees(id),
    date DATE default CURRENT_DATE,
    day_of_week VARCHAR(64),
    time TIME default CURRENT_TIME,
    type INT check (type = 1 or type = 2)
);


insert into employees(
    id,
    name,
    date_of_birth,
    department
) values
      (0, 'E0', '1991-12-16', 'FIN'),
      (1, 'E1', '1992-12-16', 'FIN'),
      (2, 'E2', '1993-12-16', 'IT'),
      (3, 'E3', '1994-12-16', 'IT'),
      (4, 'E4', '2007-12-16', 'IT'),
      (5, 'E2', '1993-12-16', 'IT'),
      (6, 'E3', '1994-12-16', 'IT'),
      (7, 'E4', '2007-12-16', 'IT'),
      (8, 'E2', '1993-12-16', 'IT'),
      (9, 'E3', '1994-12-16', 'IT'),
      (10, 'E4', '2007-12-16', 'IT'),
      (11, 'E2', '1993-12-16', 'IT'),
      (12, 'E3', '1994-12-16', 'IT'),
      (13, 'E4', '2007-12-16', 'IT');

select * from employees;


insert into times(
    employee_id,
    date,
    day_of_week,
    time,
    type
) values
      (0, '2022-12-15', 'Четверг', '09:00', 1),
      (0, '2022-12-15', 'Четверг', '09:12', 2),
      (3, '2022-12-15', 'Четверг', '09:05', 1),
      (3, '2022-12-15', 'Четверг', '09:35', 2),
      (3, '2022-12-14', 'Среда', '09:07', 1),
      (3, '2022-12-14', 'Среда', '09:45', 2),
      (3, '2022-12-13', 'Вторник', '09:46', 1),
      (3, '2022-12-13', 'Вторник', '09:50', 2),
      (3, '2022-12-13', 'Вторник', '09:55', 1),
      (3, '2022-12-13', 'Вторник', '09:58', 2),
      (3, '2022-12-12', 'Понедельник', '09:46', 1),
      (3, '2022-12-12', 'Понедельник', '09:50', 2),
      (4, '2022-12-15', 'Четверг', '09:05', 1),
      (4, '2022-12-15', 'Четверг', '09:35', 2),
      (4, '2022-12-14', 'Среда', '09:07', 1),
      (4, '2022-12-14', 'Среда', '09:45', 2),
      (4, '2022-12-13', 'Вторник', '09:46', 1),
      (4, '2022-12-13', 'Вторник', '09:50', 2),
      (4, '2022-12-12', 'Понедельник', '09:46', 1),
      (4, '2022-12-12', 'Понедельник', '09:50', 2);

select * from times;

-- Задание 1 - скалярная функция
-- Задача: найти кто опоздал и на сколько в определённую дату
CREATE OR REPLACE FUNCTION task_1(check_date date)
returns table(total bigint, arrival_time numeric)
AS
$$
    DECLARE
        workday_start time;
    BEGIN
    workday_start = '09:00';

    return query
        select count(*), late
        from (
            select res.name, EXTRACT(EPOCH from res.arrival_time)/60 as late
            from (
                select employees.name, time - workday_start as arrival_time
                from employees join times
                on employees.id = times.employee_id and times.date = check_date and times.type = 1
            ) as res
            where res.arrival_time > '0 seconds'
        ) as late_times
        group by late_times.late;
    end;
$$ LANGUAGE plpgsql;

SELECT * FROM task_1('2022-12-15');
