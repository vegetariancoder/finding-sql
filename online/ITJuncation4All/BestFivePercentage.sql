drop database online;
create database online;
use online;

create table ssc_exam (
Id int,
English int,
Maths int,
Science int,
Geography int,
History int,
Sanskrit int);

Insert into ssc_exam Values (1,85,99,92,86,86,99);
Insert into ssc_exam Values (2,81,82,83,86,95,96);
Insert into ssc_exam Values (3,76,55,76,76,56,76);
Insert into ssc_exam Values (4,84,84,84,84,84,84);
Insert into ssc_exam Values (5,83,99,45,88,75,90);



select * from ssc_exam;

select
    Id,
    round(((English+Maths+Science+Geography+History+Sanskrit)-least(English,Maths,Science,Geography,History,Sanskrit))/5,1) as percentage
from
    ssc_exam;