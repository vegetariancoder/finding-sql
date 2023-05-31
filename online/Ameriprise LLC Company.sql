drop database online;
create database online;
use online;


create table Ameriprise_LLC
(
teamID varchar(2),
memberID varchar(10),
Criteria1 varchar(1),
Criteria2 varchar(1)
);
insert into Ameriprise_LLC values
('T1','T1_mbr1','Y','Y'),
('T1','T1_mbr2','Y','Y'),
('T1','T1_mbr3','Y','Y'),
('T1','T1_mbr4','Y','Y'),
('T1','T1_mbr5','Y','N'),
('T2','T2_mbr1','Y','Y'),
('T2','T2_mbr2','Y','N'),
('T2','T2_mbr3','N','Y'),
('T2','T2_mbr4','N','N'),
('T2','T2_mbr5','N','N'),
('T3','T3_mbr1','Y','Y'),
('T3','T3_mbr2','Y','Y'),
('T3','T3_mbr3','N','Y'),
('T3','T3_mbr4','N','Y'),
('T3','T3_mbr5','Y','N');


select * from Ameriprise_LLC;


with checking as (
select
    *,
    case
        when Criteria1='y' and Criteria2 = 'y' then 'y' else 'N'
    end as qualifies_program
from
    Ameriprise_LLC),
answer as (
select
    *,
    sum(case when qualifies_program='y' then 1 else 0 end) over (partition by teamID) as flag
from
    checking)
select
    teamID,
    memberID,
    Criteria1,
    Criteria2,
    qualifies_program,
    case
        when flag>=2 and qualifies_program='y' then 'Y' else 'N'
    end as output
from
    answer;