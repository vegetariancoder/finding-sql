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


with mt as (

select
    task_id,
    numbers
from
    (
WITH RECURSIVE cte AS (
    SELECT 1 AS numbers
    UNION ALL
    SELECT numbers + 1 FROM cte WHERE numbers < 10
)
SELECT
    task_id,
    numbers
from
    cte,Tasks
where
    task_id=1
and
    numbers between 1 and subtasks_count) table1
union all
(WITH RECURSIVE cte AS (
    SELECT 1 AS numbers
    UNION ALL
    SELECT numbers + 1 FROM cte WHERE numbers < 10
)
SELECT
    task_id,
    numbers
from
    cte,Tasks
where
    task_id=2
and
    numbers between 1 and subtasks_count)
union all
(WITH RECURSIVE cte AS (
    SELECT 1 AS numbers
    UNION ALL
    SELECT numbers + 1 FROM cte WHERE numbers < 10
)
SELECT
    task_id,
    numbers
from
    cte,Tasks
where
    task_id=3
and
    numbers between 1 and subtasks_count))
select
    task_id,
    numbers
from
    mt
where
    (task_id,numbers) not in (select task_id,subtask_id from Executed);

