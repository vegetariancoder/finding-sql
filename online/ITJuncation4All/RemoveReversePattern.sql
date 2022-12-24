drop database online;
create database online;
use online;

Create Table Reverse_duplicates(
A int,
B int);

insert into Reverse_duplicates values(1,2);
insert into Reverse_duplicates values(3,2);
insert into Reverse_duplicates values(2,4);
insert into Reverse_duplicates values(2,1);
insert into Reverse_duplicates values(5,6);
insert into Reverse_duplicates values(4,2);

select * from Reverse_duplicates;
select * from Reverse_duplicates;


with answer as (
select
    rd1.A as A1,
    rd1.B as B1,
    rd2.A as A2,
    rd2.B as B2
from
    Reverse_duplicates rd1
left join
    Reverse_duplicates rd2
on
    rd1.A=rd2.B and rd1.B=rd2.A)
select
    A1,
    B1
from
    answer
where
    A1<A2 and B1>B2 or (A2 is null and B2 is null);



