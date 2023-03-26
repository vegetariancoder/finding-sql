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





with answer as (
select
    c_name,
    sum(sm_dur),
    sum(cnt),
    sum(sm_dur)/sum(cnt) as avg_call,
    (select sum(duration)*2/(count(caller_id) + count(callee_id)) from Calls) as global_check,
    if((sum(sm_dur)/sum(cnt))>(select sum(duration)*2/(count(caller_id) + count(callee_id)) from Calls),'Yes','No') as checking
from
    (
select
    sm_dur,
    cnt,
    c_name
from
    (
select
    caller_id as id,
    sum(duration) as sm_dur,
    count(caller_id) as cnt
from
    Calls
group by
    caller_id
union all
select
    callee_id as id,
    sum(duration) as sm_dur,
    count(callee_id) as cnt
from
    Calls
group by
    callee_id)cals
inner join
(select
    id,
    Country.name as c_name
from
    Person
inner join
    Country
on
    substring_index(phone_number,'-',1) = Country.country_code) countries
on
    cals.id=countries.id)mt
group by
    c_name)
select
    c_name
from
    answer
where
    checking='Yes';