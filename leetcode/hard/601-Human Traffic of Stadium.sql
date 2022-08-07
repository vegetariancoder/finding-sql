drop database leetcode;
create database leetcode;
use leetcode;

CREATE TABLE IF NOT EXISTS Stadium (
    id INT,
    visit_date date,
    people int);

insert into Stadium (id,visit_date, people) values (1,'2017-01-01',10);
insert into Stadium (id,visit_date, people) values (2,'2017-01-02',109);
insert into Stadium (id,visit_date, people) values (3,'2017-01-03',105);
insert into Stadium (id,visit_date, people) values (4,'2017-01-04',99);
insert into Stadium (id,visit_date, people) values (5,'2017-01-05',145);
insert into Stadium (id,visit_date, people) values (6,'2017-01-06',1455);
insert into Stadium (id,visit_date, people) values (7,'2017-01-07',199);
insert into Stadium (id,visit_date, people) values (8,'2017-01-08',188);



with maintable as (
select
    *,
    row_number() over (order by id) as row_nums,
    id-row_number() over (order by id) as diff
from
    Stadium
where
    people>100)
select
    id
from
    maintable
where
    diff in (select diff from maintable group by diff having count(*)>=4);