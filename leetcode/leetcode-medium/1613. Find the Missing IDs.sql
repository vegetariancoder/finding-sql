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


-- solution -1
with recursive cte as (select 1 as id
                       union
                       select id + 1
                       from cte
                       where id < (select max(customer_id) from Customers))
select id from cte where id not in (select customer_id from Customers);


-- solution -2
with recursive cte as (select 1 as id
                       union
                       select id + 1
                       from cte
                       where id < (select max(customer_id) from Customers))
select id from cte left join Customers on cte.id=Customers.customer_id where customer_id is null;