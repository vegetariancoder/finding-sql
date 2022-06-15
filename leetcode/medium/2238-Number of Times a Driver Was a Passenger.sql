use leetcode;

create table Rides
(
    ride_id   int null,
    driver_id int null,
    passenger_id int null
);

insert into Rides(ride_id, driver_id,passenger_id) values (1,7,1),
                                                            (2,7,2),
                                                          (3,11,1),
                                                          (4,11,7),
                                                          (5,11,7),
                                                          (6,11,3);

select * from Rides;

with 2238_leetcode as (
select
    passenger_id,
    count(passenger_id) as counted
from
    Rides
group by
    passenger_id)
select
    distinct driver_id,
    coalesce(counted,0) as cnt
from
    Rides
left join
    2238_leetcode
on
    Rides.driver_id = 2238_leetcode.passenger_id;


