create database if not exists leetcode;
use leetcode;


create table if not exists Queue(person_id int,
person_name varchar(100),
weight int,
turn int);

insert into Queue(person_id, person_name, weight, turn) VALUES (5,'George Washington',250,1);
insert into Queue(person_id, person_name, weight, turn) VALUES (3,'John Adams',350,2);
insert into Queue(person_id, person_name, weight, turn) VALUES (6,'Thomas Jefferson',400,3);
insert into Queue(person_id, person_name, weight, turn) VALUES (2,'Will Johnliams',200,4);
insert into Queue(person_id, person_name, weight, turn) VALUES (4,'Thomas Jefferson',175,5);
insert into Queue(person_id, person_name, weight, turn) VALUES (1,'James Elephant',500,6);


select * from Queue;

with answer as (
select
    *,
    sum(weight) over (order by turn) as sm
from
    Queue)
select
    person_name
from
    answer
where
    sm between 950 and 1000;