drop database online;
create database online;
use online;

create table products(
    chips varchar(100),
    amount varchar(100)
);

insert into products (chips, amount)
values ('lays1,uncle_chips1,kurkure1','10,20,30');
insert into products (chips, amount)
values ('waffers2','40,50');
insert into products (chips, amount)
values ('potatochips3,hotchips3,balaji3','60,70,80');

select * from products;

select
    chips,
    substring_index(chips,',',1) as chips_1,
    substring_index(chips,',',-3) as chips_2,
    substring_index(chips,',',-1) as chips_3
from
    products;

with answer as (
select
    substring_index(substring_index(chips,',',n.n),',',-1) as chips_list,
    right(substring_index(substring_index(chips,',',n.n),',',-1),1) as last_vals,
    substring_index(substring_index(amount,',',n.n),',',-1) as amount
from
    products
inner join
    (select 1 as n union all select 2 as n union all select 3 as n union all select 4 as n union all select 5) as n
on
    length(chips) - length(replace(chips,',','')) >= n.n-1
)
select chips_list,amount from answer order by last_vals;



select  from products;