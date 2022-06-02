CREATE TABLE IF NOT EXISTS Register (student varchar(100), class varchar(100));
insert into Register (student, class) values ('A','Math');
insert into Register (student, class) values ('B','English');
insert into Register (student, class) values ('C','Math');
insert into Register (student, class) values ('D','Biology');
insert into Register (student, class) values ('E','Math');
insert into Register (student, class) values ('F','Computer');
insert into Register (student, class) values ('G','Math');
insert into Register (student, class) values ('H','Math');
insert into Register (student, class) values ('I','Math');


select
    class
from
    Register
group by
    class
having
    count(student) > 5;