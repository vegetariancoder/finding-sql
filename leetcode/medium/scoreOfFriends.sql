drop database leetcode;
create database leetcode;
use leetcode;


create table person
(
personID int,
name varchar(10),
email varchar(100),
score int
);



create table friend
(
personID int,
friendID int
);

insert into person value(1,'Alice','alice2018@hotmail.com',88);
insert into person value(2,'Bob','bob2018@hotmail.com',11);
insert into person value(3,'Davis','davis2018@hotmail.com',27);
insert into person value(4,'Tara','tara2018@hotmail.com',45);
insert into person value(5,'John','john2018@hotmail.com',63);


insert into friend value (1,2);
insert into friend value (1,3);
insert into friend value (2,1);
insert into friend value (2,3);
insert into friend value (3,5);
insert into friend value (4,2);
insert into friend value (4,3);
insert into friend value (4,5);


with answer as (
select
    friend.personID,
    count(friendID) as no_of_friends,
    sum(score) as total_score
from
    person
inner join
    friend
on
    person.personID=friend.friendID
group by
    friend.personID
having
    total_score>100)
select
    answer.personID,
    name,
    no_of_friends,
    total_score
from
    answer
left join
    person
on
    answer.personID = person.personID;
