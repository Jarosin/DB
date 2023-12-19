-- Найти сотрудника, пришеднего сегодня на работу раньше всех
select employees.name
from employees join times
on employee_id = employees.id
where date = '2022-12-13' and times.time = (
    select min(times.time)
    from times
    where date = '2022-12-13'
    and times.type = '1'
);
