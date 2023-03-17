create table section_data
(
section varchar(5),
number integer
);
insert into section_data
values ('A',5),('A',7),('A',10) ,('B',7),('B',9),('B',10) ,('C',9),('C',7),('C',9) ,('D',10),('D',3),('D',8);

select * from section_data;


with cte_1 as (
select
    section,
    number,
    sum(number) over (partition by section) as sumvals
from
    (
select
    *,
    row_number() over (partition by section order by number desc ) as drnk
from
    section_data) calc_table
where
    drnk <=2),
cte_2 as (
select
    *,
    dense_rank() over (order by sumvals desc ) as rno,
    max(number) over (partition by section) as max_num
from
    cte_1),
main_cte as (
select
    section,
    number,
    sumvals,
    max_num,
    dense_rank() over (order by max_num desc ) as mx_rnk
from
    cte_2
where
    rno <=2)
select
    section,
    number
from
    main_cte
where
    mx_rnk=1;