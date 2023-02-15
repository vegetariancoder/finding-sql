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


select
    driver_id,
    ifnull(cnt,0) as cnt
from
    (
select
    passenger_id,
    count(*) as cnt
from
    Rides
group by
    passenger_id) passenger_table
right join
(select
    distinct driver_id as driver_id
from
    Rides) driver_table
on
    passenger_table.passenger_id = driver_table.driver_id;