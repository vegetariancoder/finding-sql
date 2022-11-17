
drop database online;
create database online;
use online;

Create Table BalanceTbl(
Balance int,
Dates Date
);

Insert into BalanceTbl Values(26000,'2020-01-01');
Insert into BalanceTbl Values(26000,'2020-01-02');
Insert into BalanceTbl Values(26000,'2020-01-03');
Insert into BalanceTbl Values(30000,'2020-01-04');
Insert into BalanceTbl Values(30000,'2020-01-05');
Insert into BalanceTbl Values(26000,'2020-01-06');
Insert into BalanceTbl Values(26000,'2020-01-07');
Insert into BalanceTbl Values(32000,'2020-01-08');
Insert into BalanceTbl Values(31000,'2020-01-09');

select * from BalanceTbl;


select
    Balance,
    min(Dates) as start_date,
    max(Dates) as end_date
from
    BalanceTbl
group by
    Balance;

with answer as (
select
    Balance,
    Dates,
    day(Dates)-row_number() over (partition by Balance order by Dates) as diff
from
    BalanceTbl
order by
    Dates)
select
    Balance,
    min(Dates) as start_date,
    max(Dates) as end_date
from
    answer
group by
    Balance,diff;