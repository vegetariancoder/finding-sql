drop database leetcode;
create database leetcode;
use leetcode;
Create table If Not Exists Weather (id int,record_date date, temp int);
insert into Weather (id,record_date,temp) value (1,'2015-01-01',10);
insert into Weather (id,record_date,temp) value (2,'2015-01-02',25);
insert into Weather (id,record_date,temp) value (3,'2015-01-03',20);
insert into Weather (id,record_date,temp) value (4,'2015-01-04',30);



select
    w1.record_date,
    datediff(w1.record_date,w2.record_date)
from
    Weather w1 , Weather w2
where
datediff(w1.record_date,w2.record_date) =1;

with 197_leetcode as (
select
    id,
    record_date,
    temp,
    ifnull(lag(temp) over (order by record_date),temp) as prev_temp,
    temp-ifnull(lag(temp) over (order by record_date),temp) as diff
from
    Weather)
select
    id
from
    197_leetcode
where
    diff > 0;



select
    w1.id
from
    Weather w1, Weather w2
where
    w1.temp > w2.temp and datediff(w1.record_date,w2.record_date)=1;

