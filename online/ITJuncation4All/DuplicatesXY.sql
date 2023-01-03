drop database online;
create database online;
use online;

Create Table Sample_1
(
X Bigint,
Y Bigint,
Z Bigint);

Insert into Sample_1 Values (200,400,1);
Insert into Sample_1 Values (200,400,2);
Insert into Sample_1 Values (200,400,3);
Insert into Sample_1 Values (10000,60000,1);
Insert into Sample_1 Values (500,600,1);
Insert into Sample_1 Values (500,600,2);
Insert into Sample_1 Values (20000,80000,1);


select * from Sample_1;


select
    X,
    Y,
    Z
from
    Sample_1
where
    (X,Y) in (
select
    X,
    Y
from
    Sample_1
group by
    X, Y
having
    count(*) > 1);



with answer as (
select
    X,
    Y
from
    Sample_1
group by
    X, Y
having
    count(*) > 1)
select
    *
from
    Sample_1
where
    (X,Y) in (select * from answer);