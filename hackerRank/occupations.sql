create database hackerRank;
use hackerRank;

CREATE TABLE IF NOT EXISTS Occupation (
    name varchar(100),
    occupation varchar(100));

insert into Occupation (name,occupation) values ('Samantha','Doctor');
insert into Occupation (name,occupation) values ('Julia','Actor');
insert into Occupation (name,occupation) values ('Maria','Actor');
insert into Occupation (name,occupation) values ('Meera','Singer');
insert into Occupation (name,occupation) values ('Ashely','Professor');
insert into Occupation (name,occupation) values ('Ketty','Professor');
insert into Occupation (name,occupation) values ('Christeen','Professor');
insert into Occupation (name,occupation) values ('Jane','Actor');
insert into Occupation (name,occupation) values ('Jenny','Doctor');
insert into Occupation (name,occupation) values ('Priya','Singer');

with answer as (
select
    row_nums,
    max(case
        when occupation='Doctor'then name
    end) as Doctor,
    max(case
        when occupation='Professor'then name
    end) as Professor,
    max(case
        when occupation='Singer'then name
    end) as Singer,
    max(case
        when occupation='Actor'then name
    end) as Actor
from
    (select
    Occupation,
    Name,
    row_number() over(partition by Occupation order by Name) as row_nums
from
    Occupation) tb
group by
    row_nums)
select
Doctor, Professor, Singer, Actor
from
    answer;