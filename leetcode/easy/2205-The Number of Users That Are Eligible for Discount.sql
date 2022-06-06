use leetcode;

CREATE TABLE Purchases (
user_id int,
time_stamp timestamp ,
amount int
);

INSERT into Purchases values (1,'2022-04-20 09:03:00',4416),
                             (2,'2022-03-19 19:24:02',678),
                             (3,'2022-03-18 12:03:09',4523),
                             (3,'2022-03-30 09:43:42',626);

select * from Purchases


select
    count(user_id) as user_cnt
from
    Purchases
where
    date(time_stamp) > '2022-03-08' and date(time_stamp) < '2022-03-20'
and
    amount > 1000;


