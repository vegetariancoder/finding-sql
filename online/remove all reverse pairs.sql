drop database online;
create database online;
use online;

create table number_pairs(A int, B int);
insert into number_pairs values(1,2);
insert into number_pairs values(3,2);
insert into number_pairs values(2,4);
insert into number_pairs values(2,1);
insert into number_pairs values(5,6);
insert into number_pairs values(4,2);

select * from number_pairs;


select
    A,B
from
    number_pairs;


select
    np1.A,
    np1.B
from
    number_pairs np1
left join
    number_pairs np2
on
    np1.A = np2.B
and
    np1.B = np2.A
where
    np2.A is null or np1.A < np2.A;
