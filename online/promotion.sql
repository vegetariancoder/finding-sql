drop database online;
create database online;

use online;


create table emp_table
(emp_name varchar(100),
 date_col date,
 position varchar(100));

insert into emp_table values ('A','1990-10-10','Clerk');
insert into emp_table values ('A','1990-10-10','Agent');
insert into emp_table values ('A','1990-10-10','Clerk');
insert into emp_table values ('B','1990-10-10','Agent');
insert into emp_table values ('B','1990-10-10','Assistant_Manager');
insert into emp_table values ('B','1990-10-10','Manager');
insert into emp_table values ('C','1990-10-10','Assistant_Manager');
insert into emp_table values ('C','1990-10-10','Agent');
insert into emp_table values ('D','1990-10-10','Agent');
insert into emp_table values ('D','1990-10-10','Assistant_Manager');
insert into emp_table values ('D','1990-10-10','Head_Manager');


create table designation_table(
    designation varchar(100),
    order_type int
);

insert into designation_table values ('Clerk',1);
insert into designation_table values ('Agent',2);
insert into designation_table values ('Assistant_Manager',3);
insert into designation_table values ('Manager',4);
insert into designation_table values ('Head_Manager',5);


select * from emp_table;
select * from designation_table;


with cte as (
select
    emp_table.*,
    order_type,
    lead(order_type) over (partition by emp_name order by emp_name) as next_order
from
    emp_table
inner join
    designation_table
on
    emp_table.position = designation_table.designation),
answer as (
select
    *,
    next_order-order_type as checking
from
    cte)

select distinct emp_name from emp_table where emp_name not in (select emp_name from answer where checking < 0);