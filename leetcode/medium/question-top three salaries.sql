use leetcode;

CREATE TABLE emp(
 emp_id int NULL,
 emp_name varchar(50) NULL,
 salary int NULL,
 manager_id int NULL,
 emp_age int NULL,
 dep_id int NULL,
 dep_name varchar(20) NULL,
 gender varchar(10) NULL
) ;
insert into emp values(1,'Ankit',14300,4,39,100,'Analytics','Female');
insert into emp values(2,'Mohit',14000,5,48,200,'IT','Male');
insert into emp values(3,'Vikas',12100,4,37,100,'Analytics','Female');
insert into emp values(4,'Rohit',7260,2,16,100,'Analytics','Female');
insert into emp values(5,'Mudit',15000,6,55,200,'IT','Male');
insert into emp values(6,'Agam',15600,2,14,200,'IT','Male');
insert into emp values(7,'Sanjay',12000,2,13,200,'IT','Male');
insert into emp values(8,'Ashish',7200,2,12,200,'IT','Male');
insert into emp values(9,'Mukesh',7000,6,51,300,'HR','Male');
insert into emp values(10,'Rakesh',8000,6,50,300,'HR','Male');
insert into emp values(11,'Akhil',4000,1,31,500,'Ops','Male');

select * from raw_data;

# with main_table as (
# select
#     *,
#     dense_rank() over (partition by department order by salary) as rn,
#     count(1) over (partition by department) as cnt
# from
#     raw_data)
# select
#     *
# from
#     main_table
# where
#     rn=3 or (cnt<3 and rn=cnt);
#
# select
#     distinct department
# from
#     raw_data;
#
#
#
#
#
#
# select
#     *,
#     dense_rank() over (partition by department order by salary) as rankins,
#     count(1) over (partition by department) as cnt
# from
#     raw_data;
#
# select
#     department,salary
# from(
# select
#     department,
#     salary,
#     max(rankings) over (partition by department)as maxrank
# from
#     (
# select
#     department,
#     salary,
#     dense_rank() over (partition by department order by salary desc ) as rankings
# from
#     raw_data) table1) table2
# where
#     (maxrank==3) or (maxrank<=2 and maxrank==rankings)



select * from emp;

with answer as (
select
    emp_id,
    emp_name,
    salary,
    dep_name,
    dense_rank() over (partition by dep_name order by salary desc ) as rnk,
    count(dep_name) over (partition by dep_name) as count_values
from
    emp)
select
    emp_id,
    emp_name,
    salary,
    dep_name
from
    answer
where
    rnk=3 or (rnk <=3 and rnk=count_values);

