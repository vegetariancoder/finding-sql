drop database leetcode;
create database leetcode;
use leetcode;
Create table If Not Exists Days(day date);
insert into Days (day) values ('2022-04-12');
insert into Days (day) values ('2022-08-09');
insert into Days (day) values ('2022-06-26');


select * from Days;


select
    concat(dayname(day),", ",date_format(day,'%M %d, %Y')) as day
from
    Days;
