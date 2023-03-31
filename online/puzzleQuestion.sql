drop database online;
create database online;
use online;

create table input (
id int,
formula varchar(10),
value int
);
insert into input values (1,'1+4',10),(2,'2+1',5),(3,'3-2',40),(4,'4-1',20);

select * from input;


select cast(substring(formula,2,1) as char)from input;


with answer as (
select
    *,
    left(formula,1) as first_num,
    right(formula,1) as second_num,
    (substring(formula,2,1)) as symbol_operator
from
    input)
select
    a1.id,
    a1.formula,
    a1.value,
    case
        when a1.symbol_operator='+' then a1.value+a2.value
    else a1.value-a2.value
    end as new_value
from
    answer a1
inner join
    answer a2
on
    a1.second_num=a2.id;






