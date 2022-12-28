drop database online;
create database online;
use online;

Create Table Club (
Club_Id int,
Member_Id int,
EDU varchar(30));

Insert into Club Values (1001,210,Null);
Insert into Club Values (1001,211,'MM:CI');
Insert into Club Values (1002,215,'CD:CI:CM');
Insert into Club Values (1002,216,'CL:CM');
Insert into Club Values (1002,217,'MM:CM');
Insert into Club Values (1003,255,Null);
Insert into Club Values (1001,216,'CO:CD:CL:MM');
Insert into Club Values (1002,210,Null);



select * from Club;

select
    *
from
    Club
OUTER APPLY string_split(Cl)
