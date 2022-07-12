USE leetcode;
CREATE TABLE Buses (
  bus_id int,
  arrival_time int
);

INSERT INTO Buses
  (bus_id, arrival_time)
VALUES
  (1,2),
  (2,4),
  (3,7);


CREATE TABLE Passengers (
  passenger_id int,
  arrival_time int
);

INSERT INTO Passengers
  (passenger_id, arrival_time)
VALUES
  (11,1),
  (12,5),
  (13,6),
  (14,7);

with 2142_leetcode as (
select
    bus_id as b_id,
    B.arrival_time as arr_time,
    ifnull(lag(B.arrival_time) over (order by B.arrival_time),1) as prev_value
from
    Buses B)
select
    b_id,
    sum(if(P.arrival_time between prev_value and arr_time,1,0)) as passengers_cnt
from
    2142_leetcode,Passengers as P
group by
    b_id
order by
    b_id;

