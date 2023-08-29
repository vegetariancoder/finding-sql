use online;


create table employee_mapping (
    emp varchar(100),
    id int,
    mapped_id int
);


insert into employee_mapping value ('ajay',1,3);
insert into employee_mapping value ('shalini',2,1);
insert into employee_mapping value ('vikas',3,2);
insert into employee_mapping value ('akshay',4,5);
insert into employee_mapping value ('pooja',5,6);
insert into employee_mapping value ('ritvik',6,4);


select * from employee_mapping;

with cte as (
select
    em1.emp,
    em1.id,
    em1.mapped_id,
    em2.mapped_id as person_id
from
    employee_mapping em1
inner join
    employee_mapping em2
on
    em1.mapped_id = em2.id),
answer as (
select
    cte.emp as emp,
    employee_mapping.emp as mapped_manager_name,
    if(length(cte.emp)>=length(employee_mapping.emp),'Yes','No') as flagging
from
    cte
inner join
    employee_mapping
on
    cte.person_id = employee_mapping.id)
select
    emp,
    mapped_manager_name
from
    answer
where
    flagging = 'Yes';