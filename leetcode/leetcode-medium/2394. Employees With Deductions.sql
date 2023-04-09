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



select * from Logs;

select
    employee_id,
    timediff(out_time,in_time) as diff
from
    Logs;



with answer as (
select
    emp.employee_id,
    ifnull(diff,sec_to_time(0*60*60)) as diff,
    hour_value,
    if(ifnull(diff,sec_to_time(0*60*60))<hour_value,'Yes','No') as checking
from
    (
select
    employee_id,
    sec_to_time(sum(time_to_sec(timediff(out_time,in_time)))) as diff
from
    Logs
group by
    employee_id) logs
right join
(select employee_id,
       sec_to_time(needed_hours*60*60) as hour_value
from
    employees) emp
on
    logs.employee_id=emp.employee_id)
select
    employee_id
from
    answer
where
    checking='Yes';
