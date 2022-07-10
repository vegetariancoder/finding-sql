drop database leetcode;
create database leetcode;
use leetcode;
CREATE TABLE IF NOT EXISTS Person (id int, name varchar(100), phone_number varchar(100));

insert into Person (id, name, phone_number)
values (3,'Jonathan','051-1234567');
insert into Person (id, name, phone_number)
values (12,'Elvis','051-7654321');
insert into Person (id, name, phone_number)
values (1,'Moncef','212-1234567');
insert into Person (id, name, phone_number)
values (2,'Maroua','212-6523651');
insert into Person (id, name, phone_number)
values (7,'Meir','972-1234567');
insert into Person (id, name, phone_number)
values (9,'Rachel','972-0011100');


CREATE TABLE IF NOT EXISTS Country (name varchar(100), country_code int);
insert into Country(name, country_code) VALUES ('Peru',051);
insert into Country(name, country_code) VALUES ('Israel',972);
insert into Country(name, country_code) VALUES ('Morocco',212);
insert into Country(name, country_code) VALUES ('Germany',049);
insert into Country(name, country_code) VALUES ('Ethiopia',251);

CREATE TABLE IF NOT EXISTS Calls (caller_id int, callee_id int, duration int);
insert into Calls(caller_id, callee_id, duration) VALUES (1,9,33);
insert into Calls(caller_id, callee_id, duration) VALUES (2,9,4);
insert into Calls(caller_id, callee_id, duration) VALUES (1,2,59);
insert into Calls(caller_id, callee_id, duration) VALUES (3,12,102);
insert into Calls(caller_id, callee_id, duration) VALUES (3,12,330);
insert into Calls(caller_id, callee_id, duration) VALUES (12,3,5);
insert into Calls(caller_id, callee_id, duration) VALUES (7,9,13);
insert into Calls(caller_id, callee_id, duration) VALUES (7,1,3);
insert into Calls(caller_id, callee_id, duration) VALUES (9,7,1);
insert into Calls(caller_id, callee_id, duration) VALUES (1,7,7);


select
    countryname,
    avg(duration) as call_duration
from
    (
with Person_table as (
select
    id,
    Person.name,
    phone_number,
    substr(phone_number,1,3) as country_code_values
from
    Person)
select
    id,
    Person_table.name,
    phone_number,
    Country.name as countryname,
    substr(phone_number,1,3) as country_code_values
from
    Person_table
inner join
    Country
on Person_table.country_code_values = Country.country_code) mt1
inner join
    Calls
on
    mt1.id = Calls.callee_id
group by
    countryname;



with 1501_leetcode as (
select
    countryname,
    avg(duration) as avg,
    (select 2*sum(duration)/(select count(caller_id)+count(callee_id) from Calls) from Calls) as total_global_sum
from
    (
with Person_table as (
select
    id,
    Person.name,
    phone_number,
    substr(phone_number,1,3) as country_code_values
from
    Person)
select
    id,
    Person_table.name,
    phone_number,
    Country.name as countryname,
    substr(phone_number,1,3) as country_code_values
from
    Person_table
inner join
    Country
on Person_table.country_code_values = Country.country_code) mt1
inner join
    Calls
on
    mt1.id = Calls.callee_id
group by
    countryname)
select
    countryname
from
    1501_leetcode
where
    avg>total_global_sum;

