drop database online;
create database online;
use online;
Create Table Sample_Table(
ID int);

Insert into Sample_Table Values (1),(4),(7),(9),(12),(14),(16),(17),(20);

select * from Sample_Table;


with recursive tablecreation as (
    select 1 as numbers
    union
    select numbers+1 from tablecreation where numbers<20
)
select numbers from tablecreation where numbers not in (select id from Sample_Table);


with recursive tablecreation as (
    select 1 as numbers
    union
    select numbers+1 from tablecreation where numbers<20
)
select numbers,ID from tablecreation left join Sample_Table on tablecreation.numbers=Sample_Table.ID where Sample_Table.ID is null;
