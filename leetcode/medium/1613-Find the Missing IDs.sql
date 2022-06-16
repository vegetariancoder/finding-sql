drop database leetcode;
create database leetcode;
use leetcode;

CREATE TABLE IF NOT EXISTS Customers (
    customer_id INT,
    customer_name varchar(100));

insert into Customers (customer_id,customer_name) values (1,'Alice');
insert into Customers (customer_id,customer_name) values (4,'Bob');
insert into Customers (customer_id,customer_name) values (5,'Charlie');


select * from Customers;

with 1613_leetcode as (
select
    customer_id,
    customer_name,
    row_number() over (order by customer_id) as row_nums
from
    Customers)
select
    row_nums as ids
from
    1613_leetcode
where
    row_nums not in (select customer_id from leetcode.Customers);
