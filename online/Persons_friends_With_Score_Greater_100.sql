drop database online;
create database online;
use online;


create table friends (
personId int,
friendId int);

insert into friends
values (1,2),
       (1,3),
       (2,1),
       (2,3),
       (3,5),
       (4,2),
       (4,3),
       (4,5);

create table persons (
personId int,
name varchar(100),
email varchar(100),
score int);

insert into persons
values (1,'Alice','alice2018@hotmail.com',88),
       (2,'Bob','bob2018@hotmail.com',11),
       (3,'Davis','davis2018@hotmail.com',27),
       (4,'Tara','tara2018@hotmail.com',45),
       (5,'John','john2018@hotmail.com',63);

select * from persons;

with answer as (
select
    personId,
    count(friendId) as no_of_friends,
    sum(score) as total_friendScore
from
     (
select
    friends.personId,
    friendId,
    score
from
    friends
inner join
    persons
on friends.friendId = persons.personId) calc_table
group by
    personId)
select
    answer.personId,
    name,
    no_of_friends,
    total_friendScore
from
    answer
left join
    persons
on
    answer.personId=persons.personId
where
    total_friendScore > 100;
