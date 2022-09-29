drop database leetcode;
create database leetcode;
use leetcode;
create table brands
(
    Year    int,
    Brand   varchar(20),
    Amount  int
);
insert into brands values (2018, 'Apple', 45000);
insert into brands values (2019, 'Apple', 35000);
insert into brands values (2020, 'Apple', 75000);
insert into brands values (2018, 'Samsung',	15000);
insert into brands values (2019, 'Samsung',	20000);
insert into brands values (2020, 'Samsung',	25000);
insert into brands values (2018, 'Nokia', 21000);
insert into brands values (2019, 'Nokia', 17000);
insert into brands values (2020, 'Nokia', 14000);
insert into brands values (2018, 'FB', 10000);
insert into brands values (2019, 'FB', 20000);
insert into brands values (2020, 'FB', 30000);


select * from brands;

with answer as (
select
    distinct Brand
from
    (
select
    *,
    case
        when Amount-previous_amount < 0 then 'No' else 'Yes'
    end as increasing_year
from
    (
select
    *,
    ifnull(lag(Amount) over (partition by Brand),0) as previous_amount
from
    brands) calc_table) test_table
where
    increasing_year = 'No')
select distinct Brand from brands where Brand not in (select Brand from answer);




