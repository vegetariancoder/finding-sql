drop database leetcode;
create database leetcode;
use leetcode;
SET GLOBAL time_zone = '+3:00';

create table Accounts(
    id int,
    name varchar(100)
);

create table Logins(
    id int,
    logins date
);


insert into Accounts values (1,'Winston'),
                            (7,'Jonathan');

insert into Logins
values (7,'2020-05-30'),
       (1,'2020-05-30'),
       (7,'2020-05-31'),
       (7,'2020-06-01'),
       (7,'2020-06-02'),
       (7,'2020-06-03'),
       (1,'2020-06-07'),
       (7,'2020-06-10');


SELECT t1.logins, t2.logins
FROM Logins t1
JOIN Logins t2 ON t1.logins <= t2.logins AND t2.logins <= DATE_ADD(t1.logins, INTERVAL 3 DAY)
GROUP BY t1.logins, t2.logins
HAVING COUNT(*) >= 5;


select * from Logins;


select
    *,
    lead(logins) over (partition by id order by logins) as first_date,
    lead(logins,2) over (partition by id order by logins) as second_date
from
    Logins;

with answer as (
select
    id,
    logins,
    row_num,
    count(id) over (partition by id) as cnt
from
    (
select
    *,
    row_number() over (partition by id order by logins) as row_num
from
    Logins) calc),
main_answer as (
select
    *,
    cnt - (cnt-row_num) as checking,
    if((row_num=cnt - (cnt-row_num)) & (cnt>=5),'Yes','No') as flag
from
    answer)
select
    distinct id
from
    main_answer
where
    flag='Yes';