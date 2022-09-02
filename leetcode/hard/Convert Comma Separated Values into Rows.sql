drop database leetcode;
create database leetcode;
use leetcode;

create table airbnb_searches
(
user_id int,
date_searched date,
filter_room_types varchar(200)
);
insert into airbnb_searches values
(1,'2022-01-01','entire home,private room')
,(2,'2022-01-02','entire home,shared room')
,(3,'2022-01-02','private room,shared room')
,(4,'2022-01-03','private room')
;


select * from airbnb_searches;

with answer as (
select
    substring_index(substring_index(filter_room_types,',',numbers.n),',',-1) as split_data
from
    (SELECT 1 n UNION ALL SELECT 2
   UNION ALL SELECT 3 UNION ALL SELECT 4) numbers inner join airbnb_searches
on
    char_length(filter_room_types) -char_length(replace(filter_room_types,',',''))>=numbers.n-1)
select
    split_data as value,
    count(*) as cnt
from
    answer
group by
    value;
