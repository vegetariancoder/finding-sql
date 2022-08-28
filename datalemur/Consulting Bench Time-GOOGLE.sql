drop database datalemur;
create database datalemur;
use datalemur;


Create table If Not Exists staffing (employee_id int, is_consultant varchar(100), job_id int);
insert into staffing (employee_id, is_consultant,job_id ) values (111,'true',7898);
insert into staffing (employee_id, is_consultant,job_id ) values (121,'false',6789);
insert into staffing (employee_id, is_consultant,job_id ) values (156,'true',4455);


Create table If Not Exists consulting_engagements (job_id int, client_id int, start_date date, end_date date);
insert into consulting_engagements (job_id, client_id,start_date,end_date) values (7898,20076,'2021-05-25','2021-06-30');
insert into consulting_engagements (job_id, client_id,start_date,end_date) values (6789,20045,'2021-06-01','2021-11-12');
insert into consulting_engagements (job_id, client_id,start_date,end_date) values (4455,20001,'2021-01-25','2021-05-31');

select
    employee_id,
    364-datediff(end_date,start_date) as bench_days
from
    staffing
inner join
    consulting_engagements
on
    staffing.job_id=consulting_engagements.job_id
where
    staffing.is_consultant='true';
