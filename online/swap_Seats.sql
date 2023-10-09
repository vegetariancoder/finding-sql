drop database online;
create database online;
use online;

create table seats(
    id int,
    student varchar(10)
);

insert into seats (id, student)
values (1,'A');
insert into seats (id, student)
values (2,'D');
insert into seats (id, student)
values (3,'E');
insert into seats (id, student)
values (4,'G');
insert into seats (id, student)
values (5,'J');

select * from seats;

select
    *,
    ifnull(IF(mod(id, 2) = 0, lag(student) over (order by id), lead(student) over (order by id)), student) as checking
from
    seats;
