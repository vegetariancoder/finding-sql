use leetcode;
create table If Not Exists Weather (city_id int, day_value date, degree_value int);
insert into Weather (city_id, day_value,degree_value) values (1,'2022-01-07',-12);
insert into Weather (city_id, day_value,degree_value) values (1,'2022-03-07',5);
insert into Weather (city_id, day_value,degree_value) values (1,'2022-07-07',24);
insert into Weather (city_id, day_value,degree_value) values (2,'2022-08-07',37);
insert into Weather (city_id, day_value,degree_value) values (2,'2022-08-17',37);
insert into Weather (city_id, day_value,degree_value) values (3,'2022-02-07',-7);
insert into Weather (city_id, day_value,degree_value) values (3,'2022-12-07',-6);

with 2314_leetcode as (
select
    *,
    dense_rank() over (partition by city_id order by degree_value desc,day_value) as drnk
from
    Weather)

select
    city_id,
    day_value,
    degree_value
from
    2314_leetcode
where
    drnk=1;