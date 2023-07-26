drop database leetcode;
create database leetcode;
use leetcode;


-- Create Flights table
CREATE TABLE Flights (
  flight_id INT PRIMARY KEY,
  capacity INT
);

-- Insert data into Flights table
INSERT INTO Flights (flight_id, capacity)
VALUES
  (1, 2),
  (2, 2),
  (3, 1);

-- Create Passengers table
CREATE TABLE Passengers (
  passenger_id INT PRIMARY KEY,
  flight_id INT,
  FOREIGN KEY (flight_id) REFERENCES Flights(flight_id)
);

-- Insert data into Passengers table
INSERT INTO Passengers (passenger_id, flight_id)
VALUES
  (101, 1),
  (102, 1),
  (103, 1),
  (104, 2),
  (105, 2),
  (106, 3),
  (107, 3);


with calc as (
select
    flight_id,
    count(*) as cnt
from
    Passengers
group by
    flight_id)
select
    Flights.flight_id,
    capacity as booked_cnt,
    (cnt-Flights.capacity) as waitlist_cnt
from
    Flights
inner join
    calc
on
    Flights.flight_id = calc.flight_id;