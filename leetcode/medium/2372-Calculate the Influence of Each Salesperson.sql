drop database leetcode;
create database leetcode;
use leetcode;

create table Salesperson
(
salesperson_id int,
name Varchar(20)
);
INSERT INTO Salesperson values(1,'Alice');
INSERT INTO Salesperson values(2,'Bob');
INSERT INTO Salesperson values(3,'Jerry');

create table Customer
(
customer_id int,
salesperson_id int
);
INSERT INTO Customer values(1,1);
INSERT INTO Customer values(2,1);
INSERT INTO Customer values(3,2);

create table Sales
(
sale_id int,
customer_id int,
price int
);
INSERT INTO Sales values(1,2,892);
INSERT INTO Sales values(2,1,354);
INSERT INTO Sales values(3,3,988);
INSERT INTO Sales values(4,3,856);

with answer as (
select
    salesperson_id,
    name,
    sum(price) as total
from
    Sales
inner join
    Customer
using(customer_id)
inner join
    Salesperson
using (salesperson_id)
group by
    salesperson_id, name)
select
    Salesperson.salesperson_id,
    Salesperson.name,
    ifnull(total,0) as total
from
    answer
right join
    Salesperson
using
    (salesperson_id);