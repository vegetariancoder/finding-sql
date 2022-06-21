drop database leetcode;
create database leetcode;
use leetcode;
CREATE TABLE IF NOT EXISTS Friends (
    id INT,
    name VARCHAR(19),
    activity VARCHAR(19));


CREATE TABLE IF NOT EXISTS Activities (
    id INT,
    name VARCHAR(19));


insert into Friends (id,name,activity) values (1,"JonathanD","Eating");
insert into Friends (id,name,activity) values (2,"Jade","Singing");
insert into Friends (id,name,activity) values (3,"Victor","Singing");
insert into Friends (id,name,activity) values (4,"Elvis","Eating");
insert into Friends (id,name,activity) values (5,"Daniel","Eating");
insert into Friends (id,name,activity) values (6,"Bob","Horse Riding");
# insert into Friends (id,name,activity) values (7,"Sahil","Soccer");
# insert into Friends (id,name,activity) values (8,"Nikki","Soccer");
# insert into Friends (id,name,activity) values (9,"Chao","Soccer");
# insert into Friends (id,name,activity) values (10,"Ranjit","Soccer");

insert into Activities (id,name) values (1,"Eating");
insert into Activities (id,name) values (2,"Singing");
insert into Activities (id,name) values (3,"Horse Riding");

select * from Friends;




select
    activity
from
    (
select
    activity,
    count(1) as count_values
from
    Friends
group by
    activity) maintable
where
    count_values not in (
select
    max(count_values) as val
from
    (
select
    count(1) as count_values
from
    Friends
group by
    activity) maintable
union
select
    min(count_values) as val
from
    (
select
    count(1) as count_values
from
    Friends
group by
    activity) maintable);


# if data has only these values

with 1355_leetcode as (
select
    activity,
    count(1) as count_values,
    dense_rank() over (order by count(1) desc ) as rankings
from
    Friends
group by
    activity)
select
    activity
from
    1355_leetcode
where
    rankings=count_values;










