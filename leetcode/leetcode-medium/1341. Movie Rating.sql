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

Create table If Not Exists MovieRating (movie_id int, user_id int, rating int , created_at date );
insert into MovieRating (movie_id,user_id,rating,created_at) value (1,1,3,'2020-01-12');
insert into MovieRating (movie_id,user_id,rating,created_at) value (1,2,4,'2020-02-11');
insert into MovieRating (movie_id,user_id,rating,created_at) value (1,3,2,'2020-02-12');
insert into MovieRating (movie_id,user_id,rating,created_at) value (1,4,1,'2020-01-01');
insert into MovieRating (movie_id,user_id,rating,created_at) value (2,1,5,'2020-02-17');
insert into MovieRating (movie_id,user_id,rating,created_at) value (2,2,2,'2020-02-01');
insert into MovieRating (movie_id,user_id,rating,created_at) value (2,3,2,'2020-03-01');
insert into MovieRating (movie_id,user_id,rating,created_at) value (3,1,3,'2020-02-22');
insert into MovieRating (movie_id,user_id,rating,created_at) value (3,2,4,'2020-02-25');

select * from MovieRating;

select
    name
from
    (
select
    name,
    dense_rank() over (order by count(movie_id) desc , name) as drnk
from
    MovieRating
inner join
    Users
on MovieRating.user_id = Users.user_id
group by
    name) calc
where
    drnk=1
union all
select
    title
from
    (
select
    title,
    avg(rating),
    dense_rank() over (order by avg(rating) desc , title) as drnk
from
    Movies
inner join
    MovieRating
on Movies.movie_id = MovieRating.movie_id
where
    month(created_at)=2
group by
    title) calc
where
    drnk=1;





with username as (
select
    name,
    count(rating) as cnt,
    dense_rank() over (order by count(rating) desc,name) as drnk
from
  MovieRating
inner join
   Users
on
  MovieRating.user_id = Users.user_id 
group by
  name)
, high_rate as (
select
  title,
  avg(rating) as mx_rate,
  dense_rank() over (order by avg(rating) desc,title ) as drnk
from
  MovieRating
inner join
   Movies
on
  MovieRating.movie_id = Movies.movie_id
where
    substring(created_at,1,7) = '2020-02'
group by
    title)
, user as (
select name  from username where drnk=1 limit 1)
, movie as (
select title from high_rate where drnk=1 limit 1)
select
    name as results
from
    user
union all
select
    title as results
from
    movie;





with username as (
select
    name,
    count(rating) as cnt,
    dense_rank() over (order by count(rating) desc,name) as drnk
from
  MovieRating
inner join
   Users
on
  MovieRating.user_id = Users.user_id
group by
  name)
, highest_rating as (
select
  title,
  rating,
  dense_rank() over (order by rating desc, title) as drnk
from
  MovieRating
inner join
   Movies
on
  MovieRating.movie_id = Movies.movie_id
where
    substring(created_at,1,7) = '2020-02'
)
select name as results from username where drnk=1
union all
select title as results from highest_rating where drnk=1;



select substring('2020-02-11',1,7);