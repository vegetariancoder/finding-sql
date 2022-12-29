drop database online;
create database online;
use online;

Create Table Stadium(
id int,
Visit_Date Date,
No_Of_People Bigint);

Insert into Stadium Values(1,'2018-01-01',10);
Insert into Stadium Values(2,'2018-01-02',110);
Insert into Stadium Values(3,'2018-01-03',150);
Insert into Stadium Values(4,'2018-01-04',98);
Insert into Stadium Values(5,'2018-01-05',140);
Insert into Stadium Values(6,'2018-01-06',1450);
Insert into Stadium Values(7,'2018-01-07',199);
Insert into Stadium Values(8,'2018-01-09',125);
Insert into Stadium Values(9,'2018-01-10',88);

select * from Stadium;

with answer as (
select
    st1.id as id,
    st1.Visit_Date as Visit_Date,
    st1.No_Of_People as No_Of_People,
    st2.id-row_number() over (order by (select null)) as test
from
    Stadium st1
right join
    Stadium st2
on
    st1.id=st2.id+1
where
    st1.No_Of_People>100)
select
    id,
    Visit_Date,
    No_Of_People
from
    answer
where
    test=1;


