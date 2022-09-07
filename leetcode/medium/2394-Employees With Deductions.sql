drop database leetcode;
create database leetcode;
use leetcode;

create table employees
(
employee_id int,
needed_hours int
);

insert into employees (employee_id, needed_hours) values (1,20);
insert into employees (employee_id, needed_hours) values (2,12);
insert into employees (employee_id, needed_hours) values (3,1);


create table Logs
(
employee_id int,
in_time timestamp,
out_time timestamp
);

insert into Logs (employee_id, in_time,out_time ) values (1,'2022-10-01 09:00:00','2022-10-01 17:00:00');
insert into Logs (employee_id, in_time,out_time ) values (1,'2022-10-06 09:05:04','2022-10-06 17:09:03');
insert into Logs (employee_id, in_time,out_time ) values (1,'2022-10-12 23:00:00','2022-10-13 03:00:01');
insert into Logs (employee_id, in_time,out_time ) values (2,'2022-10-29 12:00:00','2022-10-29 19:58:58');

with answer as (
select
    employees.employee_id,
    needed_hours,
    ifnull(diff,0) as time_dedicated,
    if(diff>employees.needed_hours,'Yes','No') as cleared
from
    employees
left join
(select
    employee_id,
    sum(round(hour(timediff(out_time,in_time)) + minute(timediff(out_time,in_time))/100,2)) as diff
from
    Logs
group by
    employee_id) calc_table
on
    employees.employee_id = calc_table.employee_id)
select
    employee_id
from
    answer
where
    cleared = 'No';