drop database online;
create database online;
use online;

CREATE TABLE Emp(
groupvals varchar(20),
Sequence  int );

INSERT INTO Emp VALUES('A',1);
INSERT INTO Emp VALUES('A',2);
INSERT INTO Emp VALUES('A',3);
INSERT INTO Emp VALUES('A',5);
INSERT INTO Emp VALUES('A',6);
INSERT INTO Emp VALUES('A',8);
INSERT INTO Emp VALUES('A',9);
INSERT INTO Emp VALUES('B',11);
INSERT INTO Emp VALUES('C',1);
INSERT INTO Emp VALUES('C',2);
INSERT INTO Emp VALUES('C',3);

select * from Emp;

with answer as (
select
    *,
    Sequence- row_number() over (partition by groupvals order by Sequence) as rno
from
    Emp)
select
    groupvals,
    min(Sequence) as min_seq,
    max(Sequence) as max_seq
from
    answer
group by
    groupvals, rno;