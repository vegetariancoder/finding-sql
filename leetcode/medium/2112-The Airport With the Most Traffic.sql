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


with 2112_leetcode as (
select
    ap,
    sum(sum_flight) as sum_flight,
    rank() over (order by sum(sum_flight) desc ) rnk
    from
(

(select
    departure_airport as ap,
    sum(flights_count) as sum_flight
from
    Flights
group by
    departure_airport)
union all
(select
    arrival_airport as ap,
    sum(flights_count) as sum_flight
from
    Flights
group by
    arrival_airport)) tb
group by
    ap)
select
    ap
from
    2112_leetcode
where
    rnk=1;



select
    ap,
    sum(sum_flight)
from
    (

(select
    departure_airport as ap,
    sum(flights_count) as sum_flight
from
    Flights
group by
    departure_airport)
union all
(select
    arrival_airport as ap,
    sum(flights_count) as sum_flight
from
    Flights
group by
    arrival_airport)) tb
group by
    ap;







