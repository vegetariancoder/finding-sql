drop database leetcode;
create database leetcode;
use leetcode;

CREATE TABLE IF NOT EXISTS Customer (
    customer_id INT,
    name varchar(100),
    visited_on date ,
    amount int);

insert into Customer (customer_id,name,visited_on,amount) values (1,'John','2019-01-01',100);
insert into Customer (customer_id,name,visited_on,amount) values (2,'Daniel','2019-01-02',110);
insert into Customer (customer_id,name,visited_on,amount) values (3,'Jade','2019-01-03',120);
insert into Customer (customer_id,name,visited_on,amount) values (4,'Khaled','2019-01-04',130);
insert into Customer (customer_id,name,visited_on,amount) values (5,'Winston','2019-01-05',110);
insert into Customer (customer_id,name,visited_on,amount) values (6,'Elvis','2019-01-06',140);
insert into Customer (customer_id,name,visited_on,amount) values (7,'Anna','2019-01-07',150);
insert into Customer (customer_id,name,visited_on,amount) values (8,'Maria','2019-01-08',80);
insert into Customer (customer_id,name,visited_on,amount) values (9,'Jaze','2019-01-09',110);
insert into Customer (customer_id,name,visited_on,amount) values (1,'John','2019-01-10',130);
insert into Customer (customer_id,name,visited_on,amount) values (3,'Jade','2019-01-10',150);


select *
from Customer;

select
    mt1.visited_on,
    sum(sum_amount_2) as amount,
    round(avg(sum_amount_2),2) as average_amount
from(
(select
    visited_on,
    sum(amount) as sum_amount_1
from
    Customer
group by
    visited_on) mt1
inner join
(select
    visited_on,
    sum(amount) as sum_amount_2
from
    Customer
group by
    visited_on) mt2
on
    datediff(mt1.visited_on,mt2.visited_on) between 0 and 6)
where
    day(mt1.visited_on)>=7
group by
    mt1.visited_on;



WITH TotalAmount AS (SELECT visited_on,
sum(amount) as total
FROM Customer
GROUP BY visited_on),
answer as (
select
    visited_on,
    sum(total) over (order by visited_on rows between 6 preceding and current row ) as sm,
    round(avg(total) over (order by visited_on rows between 6 preceding and current row),2) as avg
from
    TotalAmount)
select
    visited_on,
    sm as amount,
    avg as average_amount
from
    answer
where
    date_sub(visited_on,interval 6 day) in (select visited_on from TotalAmount);











