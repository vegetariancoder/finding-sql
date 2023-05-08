use leetcode;
create table If Not Exists Candidates (employee_id int, experience varchar(100), salary int);
insert into Candidates (employee_id,experience,salary) values (1,'Junior',10000),
                                                              (9,'Junior',15000),
                                                              (2,'Senior',20000),
                                                              (11,'Senior',16000),
                                                              (13,'Senior',50000),
                                                              (4,'Junior',40000);



CREATE TABLE Candidates (
  employee_id INT,
  experience VARCHAR(10),
  salary INT
);

-- insert data into the employees table
INSERT INTO Candidates (employee_id, experience, salary)
VALUES (1, 'Junior', 25000),
       (9, 'Junior', 10000),
       (2, 'Senior', 85000),
       (11, 'Senior', 80000),
       (13, 'Senior', 90000),
       (4, 'Junior', 30000);


select * from Candidates;



with calc as (
select
    employee_id,
    experience,
    salary,
    70000 as total_budget,
    sum(salary) over (partition by experience order by salary) as sm,
    if(sum(salary) over (partition by experience order by salary)>70000,'Yes','No') as flagging,
    row_number() over (partition by experience order by salary) as rno
from
    Candidates
order by
    experience desc)
, max_row as (
select
    max(rno) as max_row_no
from
    calc
where
    experience='Senior' and flagging='No')
, senior_id as (
select
    employee_id
from
    calc
where
    flagging='No' and experience='Senior'),
remaining_amount as (
select
    total_budget-sm as  remaining
from
    calc
where
    experience='Senior' and rno = (select max_row_no from max_row))
, junior_id as (
select
    *,
    (select remaining from remaining_amount) as remain,
    if(sm>(select remaining from remaining_amount),'Yes','No') as ju_flagging
from
    calc
where
    experience = 'Junior')
select
    employee_id
from
    senior_id
union
select
    employee_id
from
    junior_id
where
    ju_flagging = 'No';

