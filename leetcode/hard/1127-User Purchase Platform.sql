drop database leetcode;
create database leetcode;
use leetcode;
Create table If Not Exists Spending (user_id int, spend_date date , platform varchar(100), amount int);
insert into Spending (user_id,spend_date,platform,amount) value (1,'2019-07-01','mobile',100);
insert into Spending (user_id,spend_date,platform,amount) value (1,'2019-07-01','desktop',100);
insert into Spending (user_id,spend_date,platform,amount) value (2,'2019-07-01','mobile',100);
insert into Spending (user_id,spend_date,platform,amount) value (2,'2019-07-02','mobile',100);
insert into Spending (user_id,spend_date,platform,amount) value (3,'2019-07-01','desktop',100);
insert into Spending (user_id,spend_date,platform,amount) value (3,'2019-07-02','desktop',100);

with maintable as (
select
    date_1.spend_date as spend_date1,
    ifnull(date_2.spend_date,date_add(date_1.spend_date,interval 1 day))as spend_date2,
    date_1.new_pltform as new_platform1,
    ifnull(date_2.new_pltform,date_1.new_pltform)as new_platform2,
    date_1.sum_amount as sum_amount1,
    ifnull(date_2.sum_amount,0) as sum_amount2
from
    (
select
    spend_date,
    case
        when user_id in (select distinct S1.user_id from Spending S1 , Spending S2 where S1.spend_date='2019-07-01' and S1.user_id = S2.user_id and S1.platform != S2.platform) then 'both'
    else platform end as new_pltform,
    sum(amount) as sum_amount
from
    Spending
where
    spend_date='2019-07-01'
group by
    spend_date, new_pltform
order by
    sum_amount,new_pltform) date_1
left join
(select
    spend_date,
    case
        when user_id in (select distinct S1.user_id from Spending S1 , Spending S2 where S1.spend_date='2019-07-02' and S1.user_id = S2.user_id and S1.platform != S2.platform) then 'both'
    else platform end as new_pltform,
    sum(amount) as sum_amount
from
    Spending
where
    spend_date='2019-07-02'
group by
    spend_date, new_pltform
order by
    sum_amount,new_pltform) date_2
on
    date_1.spend_date = date_sub(date_2.spend_date,interval 1 day )
and
    date_1.new_pltform = date_2.new_pltform)
select
    spend_date1 as spend_date,
    new_platform1 as platform,
    sum_amount1 as total_amount,
    if(sum_amount1 != 0,1,0) as total_users
from
    maintable
union all
select
    spend_date2 as spend_date,
    new_platform2 as platform,
    sum_amount2 as total_amount,
    if(sum_amount2 != 0,1,0) as total_users
from
    maintable;




