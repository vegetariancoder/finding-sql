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
    sum(price) as total
from
    (
select
    sale_id,
    Sales.customer_id,
    salesperson_id,
    price
from
    Sales
inner join
    Customer
on
    Sales.customer_id=Customer.customer_id) calc_table
group by
    salesperson_id)
select
    Salesperson.salesperson_id,
    name,
    ifnull(total,0) as total
from
    answer
right join
    Salesperson
on
    answer.salesperson_id=Salesperson.salesperson_id;