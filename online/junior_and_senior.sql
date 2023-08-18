use online;

drop table candidates;
Create table candidates(
id int primary key,
positions varchar(10) not null,
salary int not null);


insert into candidates values(10,'junior',10000);
insert into candidates values(40,'junior',10000);
insert into candidates values(20,'senior',15000);
insert into candidates values(30,'senior',30000);
insert into candidates values(50,'senior',15000);

insert into candidates values(1,'junior',15000);
insert into candidates values(2,'junior',15000);
insert into candidates values(3,'junior',20000);
insert into candidates values(4,'senior',60000);


insert into candidates values(20,'junior',10000);
insert into candidates values(30,'senior',15000);
insert into candidates values(40,'senior',30000);

insert into candidates values(1,'junior',5000);
insert into candidates values(2,'junior',7000);
insert into candidates values(3,'junior',7000);
insert into candidates values(4,'senior',10000);
insert into candidates values(5,'senior',30000);
insert into candidates values(6,'senior',20000);

select * from candidates;



with senior_calculation as (
select
    *,
    sum(salary) over (partition by positions order by salary) as sm,
    50000 as tamount
from
    candidates
where
    positions='senior'
order by
    positions desc, salary)
, main_cal as (
select
    *,
    tamount-sm as testing,
    if(tamount-sm >0,'Yes','No') as chec
from
    senior_calculation)
, junior as (
select
    1 as id,
    count(id) as Juniors
from
    candidates
where
    salary < (select min(testing) from main_cal where testing>0) and positions = 'junior'),
senior as (
select
    1 as id,
    count(id) as Seniors
from
    main_cal
where
    chec = 'Yes')
select
    Juniors,
    Seniors
from
    junior
inner join
    senior
on
    junior.id = senior.id;


with running_value as (
select
    *,
    sum(salary) over (partition by positions order by salary desc , id) run_salary
from
    candidates),
seniors_cte as (
select
    1 as id,
    count(*) as Seniors
from
    running_value
where
    positions='senior' and run_salary <=50000),
juniors_cte as (
select
    1 as id,
    count(*) as Juniors
from
    running_value
where
    positions = 'junior' and
    run_salary <= 50000-(select sum(salary) from seniors_cte))
select Juniors,Seniors
from
    juniors_cte
inner join
    seniors_cte
on
    juniors_cte.id = seniors_cte.id;


select
    *,
    row_number() over (partition by positions order by salary desc ) as rno
from
    candidates;


select
    *
from
    candidates
QUALIFY row_number() over (partition by positions order by salary desc ) = 1;
