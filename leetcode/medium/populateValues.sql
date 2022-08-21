use leetcode;
create table brands
(
category varchar(20),
brand_name varchar(20)
);
insert into brands values
('chocolates','5-star')
,(null,'dairy milk')
,(null,'perk')
,(null,'eclair')
,('Biscuits','britannia')
,(null,'good day')
,(null,'boost');


select * from brands;


with answer as (
select
    category,
    brand_name,
    row_number() over (order by null) as rno
from
    brands),
    answers2 as (
select
    *,
    lead(rno,1,999) over (order by rno) as next_value
from
    answer
where
    category is not null)
select
    answers2.category,
    answer.brand_name
from
    answer
inner join
    answers2
on
    answer.rno >= answers2.rno and answer.rno <= answers2.next_value-1;