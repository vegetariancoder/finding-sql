drop database online;
create database online;
use online;

Create Table SeatArrangement (
ID int,
StudentName Varchar(30)
);

Insert into SeatArrangement Values (1,'Emma');
Insert into SeatArrangement Values (2,'John');
Insert into SeatArrangement Values (3,'Sophia');
Insert into SeatArrangement Values (4,'Donald');
Insert into SeatArrangement Values (5,'Tom');



select * from SeatArrangement;


with answer as (
select
    ID,
    StudentName,
    ifnull(lead(StudentName) over (order by ID),StudentName) as next_name,
    lag(StudentName) over (order by ID) as last_name
from
    SeatArrangement)
select
    ID,
    if(mod(ID,2)=0,last_name,next_name) as Name
from
    answer;

