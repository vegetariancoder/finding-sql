drop database strata;
create database strata;
use strata;
create table uber_trips
(
trip_id int(100),
trip_date date,
fare int,
driver_id int,
is_completed bool);

select * from uber_trips;

with answer as (
select
    month(trip_date) as _trip_month,
    driver_id,
    ifnull(lead(month(trip_date)) over (partition by driver_id order by month(trip_date)),month(trip_date)) as _next_month

from
    uber_trips
where
    is_completed != FALSE)
select
    distinct driver_id
from
    answer
where
    _next_month-_trip_month=1;