use leetcode;
create table If Not Exists Weather (city_id int, day_value date, degree_value int);
insert into Weather (city_id, day_value,degree_value) values (1,'2022-01-07',-12);
insert into Weather (city_id, day_value,degree_value) values (1,'2022-03-07',5);
insert into Weather (city_id, day_value,degree_value) values (1,'2022-07-07',24);
insert into Weather (city_id, day_value,degree_value) values (2,'2022-08-07',37);
insert into Weather (city_id, day_value,degree_value) values (2,'2022-08-17',37);
insert into Weather (city_id, day_value,degree_value) values (3,'2022-02-07',-7);
insert into Weather (city_id, day_value,degree_value) values (3,'2022-12-07',-6);



select * from Weather;


with answer as (
select
    city_id,
    day_value,
    degree_value,
    dense_rank() over (partition by city_id order by day_value,degree_value) as drnk
from
    Weather
where
    (city_id,degree_value) in (
select
    city_id,
    max(degree_value)
from
    Weather
group by
    city_id))
select
    city_id,
    day_value,
    degree_value
from
    answer
where
    drnk=1;