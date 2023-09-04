use online;

drop table if exists job_positions;
create table job_positions
(
	id			int,
	title 		varchar(100),
	groups_value 		varchar(10),
	levels		varchar(10),
	payscale	int,
	totalpost	int
);
insert into job_positions values (1, 'General manager', 'A', 'l-15', 10000, 1);
insert into job_positions values (2, 'Manager', 'B', 'l-14', 9000, 5);
insert into job_positions values (3, 'Asst. Manager', 'C', 'l-13', 8000, 10);

drop table if exists job_employees;
create table job_employees
(
	id				int,
	name 			varchar(100),
	position_id 	int
);
insert into job_employees values (1, 'John Smith', 1);
insert into job_employees values (2, 'Jane Doe', 2);
insert into job_employees values (3, 'Michael Brown', 2);
insert into job_employees values (4, 'Emily Johnson', 2);
insert into job_employees values (5, 'William Lee', 3);
insert into job_employees values (6, 'Jessica Clark', 3);
insert into job_employees values (7, 'Christopher Harris', 3);
insert into job_employees values (8, 'Olivia Wilson', 3);
insert into job_employees values (9, 'Daniel Martinez', 3);
insert into job_employees values (10, 'Sophia Miller', 3);

select * from job_positions;
select * from job_employees;



with recursive numbers as (
    select 1 as n
    union all
    select n+1 from numbers where n < (select max(totalpost) from job_positions)
),
calculated as (
select
    job_positions.*,
    row_number() over (partition by title order by id) as rno
from
    job_positions
inner join
    numbers
on
    numbers.n <= job_positions.totalpost
order by
    totalpost),
job_post as (
    select
    *,
    row_number() over (partition by position_id order by id) as rno
from
    job_employees
)
select
    title,
    groups_value,
    levels,
    payscale,
    ifnull(name,'Vacant') as name
from
    calculated
left join
    job_post
on
    calculated.rno = job_post.rno and calculated.id = job_post.position_id;
