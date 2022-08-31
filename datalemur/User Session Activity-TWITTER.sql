drop database datalemur;
create database datalemur;
use datalemur;


Create table If Not Exists session (session_id int, user_id int, session_type varchar(100), duration int);
insert into session (session_id, user_id,session_type,duration) values (6368,111,'like',3);
insert into session (session_id, user_id,session_type,duration) values (1742,111,'retweet',6);
insert into session (session_id, user_id,session_type,duration) values (8464,222,'reply',8);
insert into session (session_id, user_id,session_type,duration) values (7153,111,'retweet',5);
insert into session (session_id, user_id,session_type,duration) values (3252,333,'reply',15);

select
    user_id,
    session_type,
    dense_rank() over (partition by session_type order by duration) as ranking
from
    session
order by user_id desc,session_type desc ;