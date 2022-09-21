use leetcode;
create table tickets
(
ticket_id varchar(10),
create_date date,
resolved_date date
);
insert into tickets values
(1,'2022-08-01','2022-08-03')
,(2,'2022-08-01','2022-08-12')
,(3,'2022-08-01','2022-08-16');

select * from tickets;

with answer as (
select
    *,
    datediff(resolved_date,create_date) as date_diff,
    extract(week from resolved_date)-extract(week from create_date) as week_diff
from
    tickets)
select
    ticket_id,
    create_date,
    resolved_date,
    date_diff-2*week_diff as difference
from
    answer