drop database online;
create database online;
use online;

Create table Brands
(
 Years int,
 Brand varchar(20),
 Amount int
);

insert into brands values (2018, 'Apple', 45000);
insert into brands values (2019, 'Apple', 35000);
insert into brands values (2020, 'Apple', 75000);
insert into brands values (2018, 'Samsung', 15000);
insert into brands values (2019, 'Samsung', 20000);
insert into brands values (2020, 'Samsung', 25000);
insert into brands values (2018, 'Nokia', 21000);
insert into brands values (2019, 'Nokia', 17000);
insert into brands values (2020, 'Nokia', 14000);

select * from Brands;

with answer as (
select
    Brand,
    amount_2018,
    amount_2019,
    amount_2020,
    if(amount_2018<amount_2019 and amount_2019<amount_2020,'Yes','No') as flag
from
    (
select
    Brand,
    Amount as amount_2018,
    lead(Amount) over (partition by Brand) as amount_2019,
    lead(Amount,2) over (partition by Brand) as amount_2020,
    row_number() over (partition by Brand order by (select null)) as rno
from
    Brands)calc_table
where
    rno=1)
select
    Years,
    Brand,
    Amount
from
    Brands
where
    Brand=(select Brand from answer where flag='Yes');

