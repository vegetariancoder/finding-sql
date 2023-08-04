use online;
drop table if exists emp_input;
create table emp_input
(
id      int,
name    varchar(40)
);
insert into emp_input values (1, 'Emp1');
insert into emp_input values (2, 'Emp2');
insert into emp_input values (3, 'Emp3');
insert into emp_input values (4, 'Emp4');
insert into emp_input values (5, 'Emp5');
insert into emp_input values (6, 'Emp6');
insert into emp_input values (7, 'Emp7');
insert into emp_input values (8, 'Emp8');
insert into emp_input values (9, 'Emp9');
insert into emp_input values (10, 'Emp10');

select * from emp_input;

select
    *,
    lead(id) over (order by id) as next_id,
    lead(name) over (order by id) as next_name
from
    emp_input;

with cte as (
select
    *,
    if(mod(id, 2) = 0, 0, 1) as checking
from
    emp_input),
odd_records as (
select
    id as odd_id,
    name as odd_name,
    row_number() over (order by id) as rno
from
    cte
where
    checking=1),
even_records as (
select
    id as even_id,
    name as even_name,
    row_number() over (order by id) as rno
from
    cte
where
    checking=0),
main_answer as (
select
    odd_id,
    odd_name,
    even_id,
    even_name
from
    odd_records
inner join
    even_records
on
    odd_records.rno = even_records.rno)
select
    concat(odd_id,' ',odd_name,',',even_id,' ',even_name) as result
from
    main_answer;




