drop database leetcode;
create database leetcode;
use leetcode;
CREATE TABLE IF NOT EXISTS TableA (task_id int);
CREATE TABLE IF NOT EXISTS TableB (task_id int);
insert into TableA(task_id) values(1);
insert into TableA(task_id) values(1);
insert into TableA(task_id) values(1);
insert into TableA(task_id) values(2);
insert into TableA(task_id) values(3);

insert into TableB(task_id) values(1);
insert into TableB(task_id) values(1);
insert into TableB(task_id) values(3);
insert into TableB(task_id) values(4);
insert into TableB(task_id) values(5);

# inner join --> 3 times 1 from TableA * 2 times 1 from TableB = 6 times 1
# inner join --> 1 time 3 from TableA and TableB = 1 times 3
# total count = 7 (6+1)
select
    count(task_id)
from
    TableA
inner join
    TableB
using (task_id);


# left join --> 3 times 1 from TableA * 2 times 1 from TableB = 6 times 1
# left join --> 1 time 3 from TableA and TableB = 1 times 3
# left join --> 1 time 2 from TableA ( because of left join)
# total count = 8 (6+1+1)
select
    count(task_id)
from
    TableA
left join
    TableB
using (task_id);

# right join --> 3 times 1 from TableA * 2 times 1 from TableB = 6 times 1
# right join --> 1 time 3 from TableA and TableB = 1 times 3
# right join --> 1 time 4 from TableB ( because of right join)
# right join --> 1 time 5 from TableB ( because of right join)
# total count = 9 (6+1+1+1)

select
    count(task_id)
from
    TableA
right join
    TableB
using (task_id);


# cross join --> 5 records from left table and 5 records from right table
# total count = 25 (5*5)
select
    count(*)
from
    TableA,
    TableB;





