drop database leetcode;
create database leetcode;
use leetcode;
Create table If Not Exists Seat (id int,student varchar (100));
insert into Seat (id,student) value (1,'Abbot');
insert into Seat (id,student) value (2,'Doris');
insert into Seat (id,student) value (3,'Emerson');
insert into Seat (id,student) value (4,'Green');
insert into Seat (id,student) value (5,'Jeames');


select * from Seat;


with answer as (
select
    *,
    ifnull(lag(student) over (order by id),student) as prev_student,
    ifnull(lead(student) over (order by id),student) as next_student
from
    Seat)
select
    id,
    case
        when mod(id,2)!= 0 then next_student else prev_student
    end as student
from
    answer;