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


select * from PointsChange;

with answer as (
select
    TeamPoints.team_id,
    name,
    CAST(points as SIGNED) as points,
    CAST(points_change as SIGNED) as points_change,
    CAST(dense_rank() over (order by points desc ) as SIGNED )as prev_ranks,
    points+PointsChange.points_change as result,
    CAST(dense_rank() over (order by points+PointsChange.points_change desc,name) as SIGNED )as new_ranks
from
    TeamPoints
inner join
    PointsChange
on
    TeamPoints.team_id = PointsChange.team_id)
select
    team_id,
    name,
    CAST(prev_ranks-new_ranks as SIGNED)as rank_diff
from
    answer;