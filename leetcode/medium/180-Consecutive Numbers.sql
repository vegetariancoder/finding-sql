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


select
    L1.num as ConsecutiveNums
from
    Logs L1,Logs L2,Logs L3
where
    L1.num=L2.num
and
    L2.num = L3.num
and
    L1.id=L2.id+1
and
    L2.id=L3.id+1;


