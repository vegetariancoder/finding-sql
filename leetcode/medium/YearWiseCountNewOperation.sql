drop database leetcode;
create database leetcode;
use leetcode;
create table business_city (
business_date date,
city_id int
);

insert into business_city
values('2020-01-02' ,3),('2020-07-01' ,7),('2021-01-01' ,3),('2021-02-03' ,19)
,('2022-12-01' ,3),('2022-12-15' ,3),('2022-02-28' ,12);

select * from business_city;

select year,count(1) as count_new_year from (
with answer as (
select
    year(business_date) year,
    city_id
from
    business_city)
select
    a1.year,
    a2.city_id
from
    answer a1
left join
    answer a2
on
    a1.year > a2.year and a1.city_id = a2.city_id) calc_table
where
    city_id is null
group by
    year;
