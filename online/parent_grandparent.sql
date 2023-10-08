drop database online;
create database online;
use online;

create table persons
(
	person			varchar(10),
	parent			varchar(10),
	person_status	varchar(10)
);
insert into persons values ('A','X','Alive');
insert into persons values ('B','Y','Dead');
insert into persons values ('X','X1','Alive');
insert into persons values ('Y','Y1','Alive');
insert into persons values ('X1','X2','Alive');
insert into persons values ('Y1','Y2','Dead');

select * from persons;

with cte as (
select
    p1.person,
    p1.person_status,
    p2.person as child,
    p2.parent as parent,
    p1.parent as grand_parent
from
    persons p1
left join
    persons p2
on
    p1.person = p2.parent
where
    p2.person is not null and p2.parent is not null)
select
    count(c2.child) as cnt
from
    cte c1
inner join
    cte c2
on
    c1.person = c2.grand_parent
where
    c1.person_status = 'Alive';