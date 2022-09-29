drop database leetcode;
create database leetcode;
use leetcode;
create table car_travels
(
    cars                    varchar(40),
    days                    varchar(10),
    cumulative_distance     int
);
insert into car_travels values ('Car1', 'Day1', 50);
insert into car_travels values ('Car1', 'Day2', 100);
insert into car_travels values ('Car1', 'Day3', 200);
insert into car_travels values ('Car2', 'Day1', 0);
insert into car_travels values ('Car3', 'Day1', 0);
insert into car_travels values ('Car3', 'Day2', 50);
insert into car_travels values ('Car3', 'Day3', 50);
insert into car_travels values ('Car3', 'Day4', 100);

select * from car_travels;

with answer as (
select
    *,
    ifnull(lag(cumulative_distance) over (partition by cars order by cumulative_distance),0) as previous_day
from
    car_travels)
select
    cars,
    days,
    cumulative_distance-previous_day as cum_distance
from
    answer;