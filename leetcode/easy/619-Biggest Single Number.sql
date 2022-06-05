-- create table command

create table If Not Exists numbers (number int);
-- insert data
insert into numbers (number) values (8),
                                    (8),
                                    (3),
                                    (3),
                                    (1),
                                    (4),
                                    (5),
                                    (6);

select
    max(number) as max_number
from
    (
select
    number
from
    numbers
group by
    number
having
    count(*) = 1) maintable;


with 619_leetcode as (
select
    number
from
    numbers
group by
    number
having
    count(*) = 1)
select
    max(number) as biggest_number
from
    619_leetcode;








