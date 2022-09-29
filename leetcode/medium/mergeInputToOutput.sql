drop database leetcode;
create database leetcode;
use leetcode;
create table src_dest_distance
(
    source          varchar(20),
    destination     varchar(20),
    distance        int
);
insert into src_dest_distance values ('Bangalore', 'Hyderbad', 400);
insert into src_dest_distance values ('Hyderbad', 'Bangalore', 400);
insert into src_dest_distance values ('Mumbai', 'Delhi', 400);
insert into src_dest_distance values ('Delhi', 'Mumbai', 400);
insert into src_dest_distance values ('Chennai', 'Pune', 400);
insert into src_dest_distance values ('Pune', 'Chennai', 400);

select * from src_dest_distance;

with answer as (
select
    *,
    lead(destination) over (order by row_num) as next_dest,
    lead(source) over (order by row_num) as next_source
from
    (
select
    *,
    row_number() over (order by (select null)) as row_num
from
    src_dest_distance) calc_table)
select
    source,
    destination,
    distance
from
    answer
where
    source=next_dest and destination=next_source;