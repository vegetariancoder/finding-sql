drop database online;
create database online;
use online;

Create Table Calls
(
From_Id int,
To_Id int,
Duration int
);
INSERT INTO Calls Values(1,2,59);
INSERT INTO Calls Values(2,1,11);
INSERT INTO Calls Values(1,3,20);
INSERT INTO Calls Values(3,4,100);
INSERT INTO Calls Values(3,4,200);
INSERT INTO Calls Values(3,4,200);
INSERT INTO Calls Values(4,3,499);


select * from Calls;

with answer as (
select
    *
from
    Calls
union all
select
    To_Id,
    From_Id,
    Duration
from
    Calls)
select
    From_Id as person_1,
    To_Id as person_2,
    count(*) as call_count,
    sum(Duration) as total_duration
from
    answer
where
    From_Id<To_Id
group by
    From_Id, To_Id;