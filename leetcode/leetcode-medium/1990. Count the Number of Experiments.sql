use leetcode;
Create table If Not Exists Experiments (experiment_id int, platform varchar(100) , experiment_name varchar(100));

insert into Experiments (experiment_id,platform,experiment_name) value (4,'IOS','Programming');
insert into Experiments (experiment_id,platform,experiment_name) value (13,'IOS','Sports');
insert into Experiments (experiment_id,platform,experiment_name) value (14,'Android','Reading');
insert into Experiments (experiment_id,platform,experiment_name) value (8,'Web','Reading');
insert into Experiments (experiment_id,platform,experiment_name) value (12,'Web','Reading');
insert into Experiments (experiment_id,platform,experiment_name) value (18,'Web','Programming');





select
    platform,
    experiment_name,
    case
        when (platform,experiment_name) in (select platform,experiment_name from Experiments group by platform, experiment_name) then 1 else 0
    end as num_experiments
from
(select
    distinct platform
from
    Experiments) as platform
cross join
(select
    distinct experiment_name
from
    Experiments) as experiment_name
order by
    platform,num_experiments desc ;
