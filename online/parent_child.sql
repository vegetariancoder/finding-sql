drop database online;
create database online;

use online;

create table people
(id int primary key not null,
 name varchar(20),
 gender char(2));

create table relations
(
    c_id int,
    p_id int,
    FOREIGN KEY (c_id) REFERENCES people(id),
    foreign key (p_id) references people(id)
);

insert into people (id, name, gender)
values
    (107,'Days','F'),
    (145,'Hawbaker','M'),
    (155,'Hansel','F'),
    (202,'Blackston','M'),
    (227,'Criss','F'),
    (278,'Keffer','M'),
    (305,'Canty','M'),
    (329,'Mozingo','M'),
    (425,'Nolf','M'),
    (534,'Waugh','M'),
    (586,'Tong','M'),
    (618,'Dimartino','M'),
    (747,'Beane','M'),
    (878,'Chatmon','F'),
    (904,'Hansard','F');

insert into relations(c_id, p_id)
values
    (145, 202),
    (145, 107),
    (278,305),
    (278,155),
    (329, 425),
    (329,227),
    (534,586),
    (534,878),
    (618,747),
    (618,904);


select * from people;

select * from relations;


with child_name as (
select
    c_id,
    p_id,
    name as child_name
from
    relations
inner join
    people
on
    relations.c_id = people.id),
parent_name as (
select
    c_id,
    p_id,
    name as parent_name,
    case when people.gender = 'F' then 'Mother' else 'Father' end as Gender
from
    relations
inner join
    people
on
    relations.p_id = people.id),
parent as (
select
    child_name,
    parent_name,
    Gender
from
    child_name
inner join
    parent_name
on
    child_name.c_id = parent_name.c_id and child_name.p_id = parent_name.p_id),
Mother as (
select
    child_name,
    parent_name as Mother
from
    parent
where
    Gender='Mother'),
Father as (
select
    child_name,
    parent_name as Father
from
    parent
where
    Gender='Father')
select
    Mother.child_name,
    Father.Father,
    Mother.Mother
from
    Mother
inner join
    Father
on
    Mother.child_name = Father.child_name;