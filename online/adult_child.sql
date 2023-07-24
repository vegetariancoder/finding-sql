use online;

create table family
(
person varchar(5),
type varchar(10),
age int
);
insert into family values ('A1','Adult',54)
,('A2','Adult',53),('A3','Adult',52),('A4','Adult',58),('A5','Adult',54),('C1','Child',20),('C2','Child',19),('C3','Child',22),('C4','Child',15);

select * from family;


with adult as (
select
    person as adult,
    row_number() over (order by person) as rn
from
    family
where
    type='Adult')
, child as (
select
    person as child,
    row_number() over (order by person) as rn
from
    family
where
    type='Child')
select
    adult,
    child
from
    adult
left join
    child
on
    adult.rn=child.rn;
