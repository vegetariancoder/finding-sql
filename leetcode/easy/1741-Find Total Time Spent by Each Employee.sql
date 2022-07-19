Drop table Employee;
Create table If Not Exists Employees(emp_id int, event_day date, in_time int, out_time int)
insert into Employees (emp_id, event_day, in_time, out_time) values ('1', '2020-11-28', '4', '32')
insert into Employees (emp_id, event_day, in_time, out_time) values ('1', '2020-11-28', '55', '200')
insert into Employees (emp_id, event_day, in_time, out_time) values ('1', '2020-12-3', '1', '42')
insert into Employees (emp_id, event_day, in_time, out_time) values ('2', '2020-11-28', '3', '33')
insert into Employees (emp_id, event_day, in_time, out_time) values ('2', '2020-12-9', '47', '74')

select
    event_day as day,
    emp_id as emp_id,
    sum(resultant) as total_time
from
    (
select
    *,
    out_time-in_time as resultant
from
    Employees) 1741_leetcode
group by
    day,emp_id;


