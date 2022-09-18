drop database leetcode;
create database leetcode;
use leetcode;

create table Buses
(
bus_id int,
arrival_time int,
capacity int
);
INSERT INTO Buses values(1,2,1);
INSERT INTO Buses values(2,4,10);
INSERT INTO Buses values(3,7,2);


create table Passengers
(
passenger_id int,
arrival_time int
);
INSERT INTO Passengers values(11,1);
INSERT INTO Passengers values(12,1);
INSERT INTO Passengers values(13,5);
INSERT INTO Passengers values(14,6);
INSERT INTO Passengers values(15,7);




WITH RECURSIVE cte1 (row_num, bus_id, capacity, waited_passengers_cnt) AS (
    SELECT
        ROW_NUMBER() OVER(ORDER BY Periods.arrival_time ASC) AS row_num,
        Periods.bus_id,
        Periods.capacity,
        COUNT(Passengers.passenger_id) AS waited_passengers_cnt
    FROM (
        SELECT
            bus_id,
            capacity,
            arrival_time,
            LAG(arrival_time, 1, -1) OVER(ORDER BY arrival_time ASC) AS previous_time
        FROM Buses
    ) AS Periods
    LEFT JOIN Passengers
    ON (
        Periods.arrival_time >= Passengers.arrival_time
        AND
        Periods.previous_time < Passengers.arrival_time
    )
    GROUP BY Periods.bus_id
), cte2 (row_num, bus_id, diff, passengers_cnt) AS (
    SELECT
        row_num,
        bus_id,
        IF(capacity < waited_passengers_cnt, waited_passengers_cnt - capacity, 0) AS diff,
        IF(capacity < waited_passengers_cnt, capacity, waited_passengers_cnt) AS passengers_cnt
    FROM cte1
    WHERE row_num = 1
    UNION ALL
    SELECT
        cte1.row_num,
        cte1.bus_id,
        IF(cte1.capacity < cte1.waited_passengers_cnt + cte2.diff, cte1.waited_passengers_cnt + cte2.diff - cte1.capacity, 0) AS diff,
        IF(cte1.capacity < cte1.waited_passengers_cnt + cte2.diff, cte1.capacity, cte1.waited_passengers_cnt + cte2.diff) AS passengers_cnt
    FROM cte1
    JOIN cte2
    ON cte1.row_num = cte2.row_num + 1
)

SELECT bus_id, passengers_cnt
FROM cte2
ORDER BY bus_id ASC;
