/* Группируя по необходимому оборудованию, выводит среднее значение по трудозатратам*/
select avg(tt.time_consume), tt.equipment
from rk2.task_type as tt
group by tt.equipment;

/* удаляет соеденение между исполнителем и заказчиком если id задания исполнителя равно 1 */
delete
from rk2."performer-executor" as pe
where pe.id_customer in (select perf.id_performer
                         from rk2.performer as perf
                         where perf.id_task = 2);

