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


insert into Friends (id,name,activity) values (1,'JonathanD','Eating');
insert into Friends (id,name,activity) values (2,'Jade','Singing');
insert into Friends (id,name,activity) values (3,'Victor','Singing');
insert into Friends (id,name,activity) values (4,'Elvis','Eating');
insert into Friends (id,name,activity) values (5,'Daniel','Eating');
insert into Friends (id,name,activity) values (6,'Bob','Horse Riding');


insert into Activities (id,name) values (1,'Eating');
insert into Activities (id,name) values (2,'Singing');
insert into Activities (id,name) values (3,'Horse Riding');

select
    activity
from
    (
select
    activity,
    count(*) as cnt
from
    Friends
group by
    activity)mt
where
    cnt not in (select max(cnt) from (select activity,count(*) as cnt from Friends group by activity) as max_tb) and cnt not in (select min(cnt) from (select activity,count(*) as cnt from Friends group by activity) as min_tb);