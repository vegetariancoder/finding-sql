use leetcode;
CREATE TABLE IF NOT EXISTS Departments (
    id INT,
    name varchar(100));

insert into Departments (id, name) values (1,'Electrical Engineering');
insert into Departments (id, name) values (7,'Computer Engineering');
insert into Departments (id, name) values (13,'Bussiness Engineering');


CREATE TABLE IF NOT EXISTS Students (
    id INT,
    name varchar(100),
    department_id INT);

insert into Students (id, name,department_id) values (23,'Alice',1);
insert into Students (id, name,department_id) values (1,'Bob',7);
insert into Students (id, name,department_id) values (5,'Jennifer',13);
insert into Students (id, name,department_id) values (2,'John',14);
insert into Students (id, name,department_id) values (4,'Jasmine',77);
insert into Students (id, name,department_id) values (3,'Steve',74);
insert into Students (id, name,department_id) values (6,'Luis',1);
insert into Students (id, name,department_id) values (8,'Jonathan',7);
insert into Students (id, name,department_id) values (7,'Daiana',33);
insert into Students (id, name,department_id) values (11,'Madelynn',1);


select
    S.id,
    S.name
from
    Departments D
right join
    Students S on D.id = S.department_id
where
    D.id is null;

