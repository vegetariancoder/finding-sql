Create table If Not Exists Teams(team_name varchar(100));
insert into Teams (team_name) values ('Leetcode');
insert into Teams (team_name) values ('Ahly');
insert into Teams (team_name) values ('Real');


select
    *
from
    Teams T1
cross join
    Teams T2
where
    T1.team_name !=T2.team_name
order by
    T1.team_name desc;