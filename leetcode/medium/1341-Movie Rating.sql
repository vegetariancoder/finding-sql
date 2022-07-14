drop database leetcode;
create database leetcode;
use leetcode;
Create table If Not Exists Movies (movie_id int, title varchar (100));
insert into Movies (movie_id,title) value (1,'Avengers');
insert into Movies (movie_id,title) value (2,'Frozen 2');
insert into Movies (movie_id,title) value (3,'Joker');


Create table If Not Exists Users (user_id int, name varchar (100));
insert into Users (user_id,name) value (1,'Daniel');
insert into Users (user_id,name) value (2,'Monica');
insert into Users (user_id,name) value (3,'Maria');
insert into Users (user_id,name) value (4,'James');

Create table If Not Exists Movie_Rating (movie_id int, user_id int, rating int , created_at date );
insert into Movie_Rating (movie_id,user_id,rating,created_at) value (1,1,3,'2020-01-12');
insert into Movie_Rating (movie_id,user_id,rating,created_at) value (1,2,4,'2020-02-11');
insert into Movie_Rating (movie_id,user_id,rating,created_at) value (1,3,2,'2020-02-12');
insert into Movie_Rating (movie_id,user_id,rating,created_at) value (1,4,1,'2020-01-01');
insert into Movie_Rating (movie_id,user_id,rating,created_at) value (2,1,5,'2020-02-17');
insert into Movie_Rating (movie_id,user_id,rating,created_at) value (2,2,2,'2020-02-01');
insert into Movie_Rating (movie_id,user_id,rating,created_at) value (2,3,2,'2020-03-01');
insert into Movie_Rating (movie_id,user_id,rating,created_at) value (3,1,3,'2020-02-22');
insert into Movie_Rating (movie_id,user_id,rating,created_at) value (3,2,4,'2020-02-25');


select
    name,
    title
from
    (
select
    name,
    count(movie_id) as cnt_ratings,
    dense_rank() over (order by count(movie_id) desc , name) drnk_user
from
    Movie_Rating
inner join
    Users
using (user_id)
group by
    name) name_table
inner join
(select
    title,
    avg(rating) avg_rating,
    dense_rank() over (order by avg(rating) desc , title) drnk_title
from
    Movie_Rating
inner join
    Movies
using(movie_id)
where
    substr(created_at,1,7)='2020-02'
group by
    title) title_table
on
    name_table.drnk_user = title_table.drnk_title
where
    (drnk_user,drnk_title) in (select 1 as value1,1 as value2);


select
    name,
    title
from
    (
select
    name,
    count(movie_id) as cnt_ratings,
    dense_rank() over (order by count(movie_id) desc , name) drnk_user
from
    Movie_Rating
inner join
    Users
using (user_id)
group by
    name) name_table
inner join
(select
    title,
    avg(rating) avg_rating,
    dense_rank() over (order by avg(rating) desc , title) drnk_title
from
    Movie_Rating
inner join
    Movies
using(movie_id)
where
    substr(created_at,1,7)='2020-02'
group by
    title) title_table
on
    name_table.drnk_user = title_table.drnk_title
where
    drnk_user=1 and drnk_title=1;






