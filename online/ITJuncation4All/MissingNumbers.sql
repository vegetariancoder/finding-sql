drop database online;
create database online;
use online;

Create Table Sample_Table(
ID int);

Insert into Sample_Table Values (1),(4),(7),(9),(12),(14),(16),(17),(20);


select
    *
from
    Sample_Table;


with recursive table_created as (
    select 1 as numbers
    union
    select numbers+1 from table_created where numbers<20
)
select
    numbers
from
    table_created
where
    numbers not in (select ID from Sample_Table);




with recursive table_created as (
    select 1 as numbers
    union
    select numbers+1 from table_created where numbers<20
)
select
    ID,
    numbers
from
    table_created
left join
    Sample_Table
on
    table_created.numbers=Sample_Table.ID;