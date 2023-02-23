use leetcode;

CREATE TABLE Flights (
departure_airport int,
arrival_airport int,
flights_count int
);

INSERT into Flights values (1,2,4),
                           (2,1,5),
                           (2,4,5);

select * from Flights;

with answer as (
select
    airport,
    sum(cnt) as cnt,
    dense_rank() over (order by sum(cnt) desc ) as drnk
from
    (
select
    departure_airport as airport,
    sum(flights_count) as cnt
from
    Flights
group by
    departure_airport
union all
select
    arrival_airport as airport,
    sum(flights_count) as cnt
from
    Flights
group by
    arrival_airport)calc_table
group by
    airport)
select
    airport
from
    answer
where
    drnk=1;



