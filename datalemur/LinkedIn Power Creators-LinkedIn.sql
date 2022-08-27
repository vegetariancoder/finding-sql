drop database datalemur;
create database datalemur;
use datalemur;

Create table If Not Exists personal_profiles (profile_id int, name varchar(100), followers int);
insert into personal_profiles (profile_id, name, followers) values (1,'Nick Singh',92000);
insert into personal_profiles (profile_id, name, followers) values (2,'Zach Wilson',199000);
insert into personal_profiles (profile_id, name, followers) values (3,'Daliana Liu',171000);
insert into personal_profiles (profile_id, name, followers) values (4,'Ravit Jain',107000);
insert into personal_profiles (profile_id, name, followers) values (5,'Vin Vashishta',139000);

Create table If Not Exists employee_company (personal_profile_id int, company_id int);
insert into employee_company (personal_profile_id, company_id) values (1,4);
insert into employee_company (personal_profile_id, company_id) values (1,9);
insert into employee_company (personal_profile_id, company_id) values (2,2);
insert into employee_company (personal_profile_id, company_id) values (3,1);
insert into employee_company (personal_profile_id, company_id) values (4,3);
insert into employee_company (personal_profile_id, company_id) values (5,6);
insert into employee_company (personal_profile_id, company_id) values (6,5);


Create table If Not Exists company_pages (company_id int, name varchar(100), followers int);
insert into company_pages (company_id, name,followers ) values (1,'The Data Science Podcast',8000);
insert into company_pages (company_id, name,followers ) values (2,'Airbnb',700000);
insert into company_pages (company_id, name,followers ) values (3,'The Ravit Show',6000);
insert into company_pages (company_id, name,followers ) values (4,'DataLemur',200);
insert into company_pages (company_id, name,followers ) values (5,'YouTube',1600000);
insert into company_pages (company_id, name,followers ) values (6,'DataScience.Vin',4500);
insert into company_pages (company_id, name,followers ) values (9,'Ace The Data Science Interview',4479);


with answer as (
select
    pp.profile_id,
    pp.name,
    pp.followers as user_follower,
    ec.company_id,
    cp.followers as comp_follower,
    if(pp.followers>cp.followers,'Yes','No') as power
from
    personal_profiles pp
inner join
    employee_company ec
on
    pp.profile_id = ec.personal_profile_id
inner join
    company_pages cp
on
    ec.company_id=cp.company_id
order by
    pp.profile_id)
select
    distinct profile_id
from
    answer
where
    power='Yes'
order by
    profile_id;

