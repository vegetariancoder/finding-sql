use leetcode;
Create table If Not Exists Logs (id int, num int);
insert into Logs (id,num) value (1,1);
insert into Logs (id,num) value (2,1);
insert into Logs (id,num) value (3,1);
insert into Logs (id,num) value (4,2);
insert into Logs (id,num) value (5,1);
insert into Logs (id,num) value (6,2);
insert into Logs (id,num) value (7,2);

select * from Logs;

with answer as (
select
    *,
    lead(num,1) over (order by id) as second_num,
    lead(num,2) over (order by id) as third_num,
    case
        when num=lead(num,1) over (order by id) and lead(num,1) over (order by id)=lead(num,2) over (order by id) and lead(num,2) over (order by id)=num then 'Yes'
    else 'No' end as flagging

from
    Logs)
select
    distinct num
from
    answer
where
    flagging='Yes';
