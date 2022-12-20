drop database online;
create database online;
use online;

create table billing (
id int,
name varchar(20),
billing_id varchar(20),
billing_creation_date date,
amount int);

insert into billing values (1, 'A', 'id1', '2020-10-10', 100);
insert into billing values (1, 'A', 'id2', '2020-11-11', 150);
insert into billing values (1, 'A', 'id3', '2021-12-11', 100);
insert into billing values (2, 'B', 'id4', '2019-10-11', 150);
insert into billing values (2, 'B', 'id5', '2020-11-11', 200);
insert into billing values (2, 'B', 'id6', '2021-12-11', 250);
insert into billing values (3, 'C', 'id7', '2018-01-01', 100);
insert into billing values (3, 'C', 'id8', '2019-05-01', 250);
insert into billing values (3, 'C', 'id9', '2021-06-01', 300);

select * from billing;

with answer as (
select
    id,
    name,
    sum(case when year(billing_creation_date)=2019 then amount else 0 end) as billing_2019,
    sum(case when year(billing_creation_date)=2020 then amount else 0 end) as billing_2020,
    sum(case when year(billing_creation_date)=2021 then amount else 0 end) as billing_2021,
    count(case when year(billing_creation_date)=2019 then amount end ) as cnt_2019,
    count(case when year(billing_creation_date)=2020 then amount end) as cnt_2020,
    count(case when year(billing_creation_date)=2021 then amount end) as cnt_2021
from
    billing
group by
    id, name)
select
    id,
    name,
    (billing_2019+billing_2020+billing_2021)/(case when cnt_2019=0 then 1 else cnt_2019 end +
                                              case when cnt_2020=0 then 1 else cnt_2020 end +
                                              case when cnt_2021=0 then 1 else cnt_2021 end) as avg_billing_amt
from
    answer





