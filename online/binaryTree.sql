drop database online;
create database online;
use online;

CREATE TABLE Emp_Details (
N int,
P int);

insert into Emp_Details (N, P)
values (1,2);
insert into Emp_Details (N, P)
values (3,2);
insert into Emp_Details (N, P)
values (6,8);
insert into Emp_Details (N, P)
values (9,8);
insert into Emp_Details (N, P)
values (2,5);
insert into Emp_Details (N, P)
values (8,5);
insert into Emp_Details (N, P)
values (5,null);

select * from Emp_Details;



select
    N,
    case
        when P is null then 'root'
        when P = (select N from Emp_Details where P is null) then 'Inner'
        else 'Leaf'
    end as outputty
from
    Emp_Details
order by
    N;