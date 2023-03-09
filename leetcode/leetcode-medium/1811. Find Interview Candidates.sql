drop database leetcode;
create database leetcode;
use leetcode;
Create table If Not Exists Contests (contest_id int, gold_medal int , silver_medal int, bronze_medal int);
insert into Contests (contest_id,gold_medal,silver_medal,bronze_medal) value (190,1,5,2);
insert into Contests (contest_id,gold_medal,silver_medal,bronze_medal) value (191,2,3,5);
insert into Contests (contest_id,gold_medal,silver_medal,bronze_medal) value (192,5,2,3);
insert into Contests (contest_id,gold_medal,silver_medal,bronze_medal) value (193,1,3,5);
insert into Contests (contest_id,gold_medal,silver_medal,bronze_medal) value (194,4,5,2);
insert into Contests (contest_id,gold_medal,silver_medal,bronze_medal) value (195,4,2,1);
insert into Contests (contest_id,gold_medal,silver_medal,bronze_medal) value (196,1,5,2);


Create table If Not Exists Users (user_id int, mail varchar(100), name varchar(100));
insert into Users (user_id,mail,name) value (1,'sarah@gmail.com','Sarah');
insert into Users (user_id,mail,name) value (2,'bob@gmail.com','Bob');
insert into Users (user_id,mail,name) value (3,'alice@gmail.com','Alice');
insert into Users (user_id,mail,name) value (4,'hercy@gmail.com','Hercy');
insert into Users (user_id,mail,name) value (5,'quarz@gmail.com','Quarz');

select
    name,
    mail
from
    Users
where
    user_id in (
select
    gold_medal as user_id
from
    Contests
group by
    gold_medal
having
    count(*)>=3
union all
(with contest_and_medal as (
select
    contest_id,
    gold_medal as user_id
from
    Contests
union all
select
    contest_id,
    silver_medal as user_id
from
    Contests
union all
select
    contest_id,
    bronze_medal as user_id
from
    Contests)
select
    distinct c1.user_id
from
    contest_and_medal as c1,
    contest_and_medal as c2,
    contest_and_medal as c3
where
    c1.contest_id-c2.contest_id=1
and
    c2.contest_id-c3.contest_id=1
and
    c1.user_id=c2.user_id
and
    c2.user_id=c3.user_id));