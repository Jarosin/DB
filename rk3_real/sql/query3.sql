-- найти сотрудника, который пришел сегодня последним

select employees.name
from employees join times
on employee_id = employees.id
where date = $1::date and times.time = (
    select max(times.time)
    from times
    where date = $1::date
    and times.type = '1'
);

-- 2022-12-13
