drop database hackerRank;
create database hackerRank;
use hackerRank;

CREATE TABLE IF NOT EXISTS Students (
    id int,
    name varchar(100));

CREATE TABLE IF NOT EXISTS Friends (
    id int,
    friend_id int);

CREATE TABLE IF NOT EXISTS Packages (
    id int,
    salary float);


insert into Students (id,name) values (1,'Ashley');
insert into Students (id,name) values (2,'Samantha');
insert into Students (id,name) values (3,'Julia');
insert into Students (id,name) values (4,'Scarlet');

insert into Friends (id,friend_id) values (1,2);
insert into Friends (id,friend_id) values (2,3);
insert into Friends (id,friend_id) values (3,4);
insert into Friends (id,friend_id) values (4,1);

insert into Packages (id,salary) values (1,15.20);
insert into Packages (id,salary) values (2,10.06);
insert into Packages (id,salary) values (3,11.55);
insert into Packages (id,salary) values (4,12.12);


with answer as (
select
    name,
    Packages.salary as main_salary,
    friend_id
from
    Students
inner join
    Packages
on
    Students.id = Packages.id
inner join
    Friends
on
    Students.id = Friends.id)
select
    name
from
    answer
inner join
    Packages
on
    answer.friend_id=Packages.id
where
    if(main_salary<salary,'Yes','No')='Yes'
order by
    main_salary;