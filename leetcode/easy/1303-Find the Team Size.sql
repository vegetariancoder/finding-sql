use leetcode;
drop table Employees;
CREATE TABLE IF NOT EXISTS Employee (
    employee_id INT,
    team_id varchar(100));

insert into Employee (employee_id, team_id) values (1,8);
insert into Employee (employee_id, team_id) values (2,8);
insert into Employee (employee_id, team_id) values (3,8);
insert into Employee (employee_id, team_id) values (4,7);
insert into Employee (employee_id, team_id) values (5,9);
insert into Employee (employee_id, team_id) values (6,9);

with 1303_leetcode as (
select
    team_id,
    count(team_id) as count_values
from
    Employee
group by
    team_id)
select
    employee_id,
    count_values as teamsize
from
    Employee
left join
    1303_leetcode
on
    Employee.team_id = 1303_leetcode.team_id;