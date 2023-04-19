drop database leetcode;
create database leetcode;
use leetcode;
CREATE TABLE IF NOT EXISTS Tasks (task_id int, subtasks_count  int);
insert into Tasks (task_id, subtasks_count) values (1,3);
insert into Tasks (task_id, subtasks_count) values (2,2);
insert into Tasks (task_id, subtasks_count) values (3,4);


CREATE TABLE IF NOT EXISTS Executed (task_id int, subtask_id int);
insert into Executed (task_id, subtask_id) values (1,2);
insert into Executed (task_id, subtask_id) values (3,1);
insert into Executed (task_id, subtask_id) values (3,2);
insert into Executed (task_id, subtask_id) values (3,3);
insert into Executed (task_id, subtask_id) values (3,4);



with answer as (
(with recursive cte as (
    select 1 as numbers
    union all
    select numbers+1
    from cte where numbers < (select max(subtasks_count) from Tasks where task_id=1)
)
select
    task_id,
    numbers
from
    Tasks,cte
where
    task_id=1)
union all
(with recursive cte as (
    select 1 as numbers
    union all
    select numbers+1
    from cte where numbers < (select max(subtasks_count) from Tasks where task_id=2)
)
select
    task_id,
    numbers
from
    Tasks,cte
where
    task_id=2)
union all
(with recursive cte as (
    select 1 as numbers
    union all
    select numbers+1
    from cte where numbers < (select max(subtasks_count) from Tasks where task_id=3)
)
select
    task_id,
    numbers
from
    Tasks,cte
where
    task_id=3))
select
    task_id,
    numbers as subtask_id
from
    answer
where
    (task_id,numbers) not in (select task_id,subtask_id from Executed);