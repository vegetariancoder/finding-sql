drop database leetcode;
create database leetcode;
use leetcode;
create table travel_items
(
id              int,
item_name       varchar(50),
total_count     int
);
insert into travel_items values
(1, 'Water Bottle', 2),
(2, 'Tent', 1),
(3, 'Apple', 4);


select * from travel_items;

with recursive cte as (
select
    id,
    item_name,
    total_count,
    1 as level
from
    travel_items
union
select
    cte.id,cte.item_name,cte.total_count-1,level+1 as level
from
    cte
inner join
    travel_items
on
    cte.id=travel_items.id and cte.item_name=travel_items.item_name
where
    cte.total_count>1
) select id,item_name from cte order by id;






