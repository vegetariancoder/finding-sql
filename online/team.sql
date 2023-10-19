create database online;
use online;
-- Create the table
CREATE TABLE TeamMembers (
    teamID VARCHAR(10),
    memberID VARCHAR(10),
    Criteria1 CHAR(1),
    Criteria2 CHAR(1)
);

-- Insert data into the table
INSERT INTO TeamMembers (teamID, memberID, Criteria1, Criteria2)
VALUES
    ('T1', 'T1_mbr1', 'Y', 'Y'),
    ('T1', 'T1_mbr2', 'Y', 'Y'),
    ('T1', 'T1_mbr3', 'Y', 'Y'),
    ('T1', 'T1_mbr4', 'Y', 'Y'),
    ('T1', 'T1_mbr5', 'Y', 'N'),
    ('T2', 'T2_mbr1', 'Y', 'Y'),
    ('T2', 'T2_mbr2', 'Y', 'N'),
    ('T2', 'T2_mbr3', 'N', 'Y'),
    ('T2', 'T2_mbr4', 'N', 'N'),
    ('T2', 'T2_mbr5', 'N', 'N'),
    ('T3', 'T3_mbr1', 'Y', 'Y'),
    ('T3', 'T3_mbr2', 'Y', 'Y'),
    ('T3', 'T3_mbr3', 'N', 'Y'),
    ('T3', 'T3_mbr4', 'N', 'Y'),
    ('T3', 'T3_mbr5', 'Y', 'N');

select * from TeamMembers;


select
    *,
    if(Criteria1='Y' and Criteria2='Y','Yes','No') as quali
from
    TeamMembers;


with answer as (
select
    *,
    if(Criteria1='Y' and Criteria2='Y','Yes','No') as quali,
    count(case when if(Criteria1='Y' and Criteria2='Y','Yes','No') = 'Yes' then 1 end ) over (partition by teamID) as checking
from
    TeamMembers)
select
    teamID,
    memberID,
    Criteria1,
    Criteria2,
    if(quali='Yes' and checking>1,'Yes','No') as qualified
from
    answer;