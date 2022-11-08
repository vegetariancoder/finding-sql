drop database online;
create database online;
use online;

CREATE TABLE Emp_Details (
empid int,
gender varchar(100),
rmailID varchar(30),
deptid int);


INSERT INTO Emp_Details VALUES (1001,'M','YYYYY@gmaix.com',104);
INSERT INTO Emp_Details VALUES (1002,'M','ZZZ@gmaix.com',103);
INSERT INTO Emp_Details VALUES (1003,'F','AAAAA@gmaix.com',102);
INSERT INTO Emp_Details VALUES (1004,'F','PP@gmaix.com',104);
INSERT INTO Emp_Details VALUES (1005,'M','CCCC@yahu.com',101);
INSERT INTO Emp_Details VALUES (1006,'M','DDDDD@yahu.com',100);
INSERT INTO Emp_Details VALUES (1007,'F','E@yahu.com',102);
INSERT INTO Emp_Details VALUES (1008,'M','M@yahu.com',102);
INSERT INTO Emp_Details VALUES (1009,'F','SS@yahu.com',100);

select
    *
from
    Emp_Details;

select
    deptid,
    group_concat(rmailID) as email_list
from
    Emp_Details
group by
    deptid;
