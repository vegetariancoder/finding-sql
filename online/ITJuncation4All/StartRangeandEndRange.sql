drop database online;
create database online;
use online;

Create Table SampleTable
(
Start_Range int,
End_Range int
);
Insert into SampleTable Values (1,4);
Insert into SampleTable Values (6,6);
Insert into SampleTable Values (8,9);
Insert into SampleTable Values (11,13);
Insert into SampleTable Values (15,15);


select * from SampleTable;

with recursive answer as (
select
    Start_Range as id,
    End_Range
from
    SampleTable
union all
select
    id+1 as id,
    End_Range
from
    answer
where
    id<End_Range
)
select id from answer order by id;

select * from SampleTable;




with recursive answer as (
select
    Start_Range as id,
    End_Range
from
    SampleTable
union all
select
    id+1,
    End_Range
from
    answer
where
    id<End_Range)
select
    id
from
    answer
order by
    id;











