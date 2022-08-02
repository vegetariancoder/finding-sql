drop database leetcode;
create database leetcode;
use leetcode;

Create table If Not Exists Product (product_id int, product_name varchar(100));


insert into Product (product_id,product_name) values(1,'LC Phone');
insert into Product (product_id,product_name) values(2,'LC Shirt');
insert into Product (product_id,product_name) values(3,'LC Keychain');


Create table If Not Exists Sales (product_id int, period_start date, period_end date, average_daily_sales int);

insert into Sales (product_id,period_start,period_end,average_daily_sales) values(1,'2019-01-25','2019-02-28',100);
insert into Sales (product_id,period_start,period_end,average_daily_sales) values(2,'2018-12-01','2020-01-01',10);
insert into Sales (product_id,period_start,period_end,average_daily_sales) values(3,'2019-12-01','2020-01-31',1);

select
    *,
    makedate(year((period_end) - interval timestampdiff(year ,period_start,period_end) year),1 ) as diff_date
from
    Sales
where
    product_id=1;



with 1384_leetcode as (
select
    product_id,
    year(date_period) as year,
    sum(datediff(next_date,date_period)*average_daily_sales) as total_amount
from
    (
select
    *,
    ifnull(lead(date_period) over (partition by product_id),date_add(date_period,interval 1 day) ) as next_date
from
    (
select
    product_id,
    average_daily_sales,
    period_start as date_period
from
    Sales
where
    product_id=1
union all
select
    product_id,
    average_daily_sales,
    period_end as date_period
from
    Sales
where
    product_id=1
union all
select
    product_id,
    average_daily_sales,
    period_start as date_period
from
    (
select
    *
from
    Sales
where
   year(period_start) != year(period_end))b_tab
where
    product_id=2
union all
select
    product_id,
    average_daily_sales,
    diff_date as date_period
from
    (
select
    *,
    makedate(year((period_end) - interval timestampdiff(year ,period_start,period_end) year),1 ) as diff_date
from
    Sales
where
   year(period_start) != year(period_end))b_tab
where
    product_id=2
union all
select
    product_id,
    average_daily_sales,
    period_end as date_period
from
    (
select
    *
from
    Sales
where
   year(period_start) != year(period_end))b_tab
where
    product_id=2
union all
select
    product_id,
    average_daily_sales,
    period_start as date_period
from
    (
select
    *
from
    Sales
where
   year(period_start) != year(period_end))b_tab
where
    product_id=3
union all
select
    product_id,
    average_daily_sales,
    diff_date as date_period
from
    (
select
    *,
    makedate(year((period_end) - interval timestampdiff(year ,period_start,period_end) year),1 ) as diff_date
from
    Sales
where
   year(period_start) != year(period_end))b_tab
where
    product_id=3
union all
select
    product_id,
    average_daily_sales,
    period_end as date_period
from
    (
select
    *
from
    Sales
where
   year(period_start) != year(period_end))b_tab
where
    product_id=3) u_table) b_table
group by
    product_id, year(date_period))
select
    1384_leetcode.product_id,
    product_name,
    year,
    total_amount
from
    1384_leetcode
left join
    Product
on
    1384_leetcode.product_id = Product.product_id;

