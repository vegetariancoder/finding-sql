drop database leetcode;
create database leetcode;
use leetcode;
Create table If Not Exists Seat (id int,student varchar (100));
insert into Seat (id,student) value (1,'Abbot');
insert into Seat (id,student) value (2,'Doris');
insert into Seat (id,student) value (3,'Emerson');
insert into Seat (id,student) value (4,'Green');
insert into Seat (id,student) value (5,'Jeames');

select
    lag(student) over (order by id)
from
    Seat;

select
    id,
    case
        when id%2=1 and lead(student) over (order by id) is null then student
        when id%2=1 then lead(student) over (order by id)
        else lag(student) over (order by id)
    end as student
from
    Seat;
