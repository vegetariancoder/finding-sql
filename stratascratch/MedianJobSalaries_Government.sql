drop database strata;
create database strata;
use strata;

CREATE TABLE sf_public_salaries
(
    id int  NOT NULL,
    employeename varchar(100)  NOT NULL,
    jobtitle varchar(30) null,
    basepay float null,
    overtimepay float null,
    otherpay float,
    benefits float null,
    totalpay float null,
    totalpaybenefits float null,
    year int null,
    notes int null,
    agency varchar(100),
    status varchar(100)
);

select * from sf_public_salaries;


with answer as (
select
    jobtitle,
    totalpay,
    row_number() over (partition by jobtitle order by totalpay) as r_no,
    count(*) over (partition by jobtitle order by totalpay rows between unbounded preceding and unbounded following) as cnt
from
    sf_public_salaries)
select
    jobtitle,
    avg(totalpay) as median_salary
from
    answer
where
    r_no between cnt*1.0/2 and cnt*1.0/2+1
group by
    jobtitle;



