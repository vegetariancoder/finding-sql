drop database online;
create database online;
use online;
    
Create Table Staffing (
employee_id int,
is_consultant bit,
job_id int);

Insert into Staffing values(111,1,7898);
Insert into Staffing values(121,0,6789);
Insert into Staffing values(111,1,9020);
Insert into Staffing values(156,1,4455);
Insert into Staffing values(111,1,8885);

Create Table Consulting_engagements(
job_id int,
client_id int,
start_dates date,
end_dates date,
contract_amount int
);


Insert into Consulting_engagements values (6789,20045,'2021-06-01','2021-11-12',33040);
Insert into Consulting_engagements values (8885,20022,'2021-07-05','2021-07-31',4670);
Insert into Consulting_engagements values (9020,20345,'2021-08-14','2021-10-31',22370);
Insert into Consulting_engagements values (4455,20001,'2021-01-25','2021-05-31',31839);
Insert into Consulting_engagements values (7898,20076,'2021-05-25','2021-06-30',11290);
Insert into Consulting_engagements values (3462,20099,'2021-09-15','2021-11-15',240000);
Insert into Consulting_engagements values (2354,20001,'2021-10-14','2021-12-31',54000);


select * from Consulting_engagements;
select * from Staffing;

with answer as (
select
    Consulting_engagements.job_id,
    client_id,
    start_dates,
    end_dates,
    employee_id,
    datediff(end_dates,start_dates) as date_diff
from
    Consulting_engagements
left join
    Staffing
on
    Consulting_engagements.job_id=Staffing.job_id
where
    Staffing.is_consultant=1)
select
    employee_id,
    365-sum(date_diff) as bench_days
from
    answer
group by
    employee_id;

