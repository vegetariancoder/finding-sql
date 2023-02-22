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


select * from Customer;

with table_1 as (
select
    visited_on,
    sum(amount) as amt_1
from
    Customer
group by
    visited_on)
, table_2 as (
    select
    visited_on,
    sum(amount) as amt_1
from
    Customer
group by
    visited_on
)
select
    table_1.visited_on,
    sum(table_2.amt_1) as amount,
    round(avg(table_2.amt_1),2) as avg_amount
from
    table_1
inner join
    table_2
on
    datediff(table_1.visited_on,table_2.visited_on) between 0 and 6
where
    day(table_1.visited_on)>=7
group by
    table_1.visited_on;

