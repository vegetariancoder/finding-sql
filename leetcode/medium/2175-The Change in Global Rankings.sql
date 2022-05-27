use leetcode;

CREATE TABLE TeamPoints (
team_id int,
name varchar(100),
points int
);

INSERT into TeamPoints values (3,'Algeria',1431),
                           (1,'Senegal',2132),
                           (2,'New Zealand',1402),
                           (4,'Croatia',1817);



CREATE TABLE PointsChange (
team_id int,
points_change int
);

INSERT into PointsChange values (3,399),
                           (2,0),
                           (4,13),
                           (1,-22);


select * from TeamPoints;

with leetcode2175 as (
select
    TeamPoints.team_id,
    name,
    points as old_points,
    row_number() over (order by points desc) as old_ranks,
    points+points_change as new_points,
    row_number() over (order by points+points_change desc,name) as new_ranks
from
    TeamPoints
inner join
    PointsChange on TeamPoints.team_id = PointsChange.team_id
order by
        old_points desc, new_points desc)
select
    team_id,
    name,
    old_ranks-new_ranks as diff
from
    leetcode2175;