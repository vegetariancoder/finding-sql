drop database online;
create database online;
use online;


CREATE TABLE employee_checkin_details (
    employeeid INT,
    entry_details VARCHAR(10),
    timestamp_details TIMESTAMP
);

INSERT INTO employee_checkin_details (employeeid, entry_details, timestamp_details)
VALUES
    (1000, 'login', '2023-06-16 01:00:15.34'),
    (1000, 'login', '2023-06-16 02:00:15.34'),
    (1000, 'login', '2023-06-16 03:00:15.34'),
    (1000, 'logout', '2023-06-16 12:00:15.34'),
    (1001, 'login', '2023-06-16 01:00:15.34'),
    (1001, 'login', '2023-06-16 02:00:15.34'),
    (1001, 'login', '2023-06-16 03:00:15.34'),
    (1001, 'logout', '2023-06-16 12:00:15.34');


CREATE TABLE employee_details (
    employeeid INT,
    phone_number VARCHAR(10),
    isdefault BOOLEAN
);

INSERT INTO employee_details (employeeid, phone_number, isdefault)
VALUES
    (1001, '9999', false),
    (1001, '1111', false),
    (1001, '2222', true),
    (1003, '3333', false);


select * from employee_checkin_details;
select * from employee_details;

select
    employee_checkin_details.employeeid,
    phone_number,
    sum(case when entry_details='login' then 1 else 0 end) as total_entry
from
    employee_checkin_details
left join
    employee_details
on
    employee_checkin_details.employeeid = employee_details.employeeid
group by
    employee_checkin_details.employeeid,phone_number;


with answer as (
select
    employee_checkin_details.employeeid as employeeid,
    phone_number,
    isdefault,
    count(*) as totalentry,
    sum(case when entry_details='login' then 1 else 0 end) as totallogin,
    sum(case when entry_details='logout' then 1 else 0 end) as totallogout,
    (select max(timestamp_details) from employee_checkin_details where entry_details='login') as latestlogin,
    (select max(timestamp_details) from employee_checkin_details where entry_details='logout') as latestlogout,
    row_number() over (partition by employee_details.employeeid order by isdefault desc ) as rno
from
    employee_checkin_details
left join
    employee_details
on
    employee_checkin_details.employeeid = employee_details.employeeid
group by
    employee_checkin_details.employeeid, phone_number,isdefault)
select
    employeeid,
    phone_number,
    totalentry,
    totallogin,
    totallogout,
    latestlogin,
    latestlogout
from
    answer
where
    rno=1;


select 22
