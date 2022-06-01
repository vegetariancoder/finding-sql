drop database leetcode;
create database leetcode;
use leetcode;

CREATE TABLE IF NOT EXISTS Logs (
    log_id INT);

insert into Logs (log_id) values (1);
insert into Logs (log_id) values (2);
insert into Logs (log_id) values (3);
insert into Logs (log_id) values (7);
insert into Logs (log_id) values (8);
insert into Logs (log_id) values (10);


select * from Logs;

with 1285_leetcode as (
select
    log_id,
    log_id-row_number() over (order by log_id) as ids
from
    Logs)
select
    min(log_id) as start_id,
    max(log_id) as end_id
from
    1285_leetcode
group by
    ids;




