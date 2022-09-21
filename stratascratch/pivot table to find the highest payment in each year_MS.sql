drop database strata;
create database strata;
use strata;
create table sf_public_salaries
(
id int,
employeename varchar(100),
jobtitle varchar(100),
basepay float,
overtimepay float,
otherpay float,
benefits float,
totalpay float,
totalpaybenefits float,
year int,
notes varchar(100),
agency varchar(100),
status varchar(100)
);

select * from sf_public_salaries;



select
    max(year_2011) as year_2011,
    max(year_2012) as year_2012,
    max(year_2013) as year_2013,
    max(year_2014) as year_2014
from
    (
with answer as (
select
    year,
    employeename
from
    sf_public_salaries
where
    (year,basepay) in (
select
    year,
    max(basepay) as max_salary
from
    sf_public_salaries
group by
    year))
select
    row_number() over (partition by year) as rno,
    case when year=2011 then employeename end as year_2011,
    case when year=2012 then employeename end as year_2012,
    case when year=2013 then employeename end as year_2013,
    case when year=2014 then employeename end as year_2014
from
    answer) calc
group by
    rno;