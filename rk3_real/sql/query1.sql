-- Старший работник бухгалтерии
select distinct employees.name
from employees
where employees.date_of_birth = (
    select min(date_of_birth)
    from employees
    where department = 'FIN'
);
