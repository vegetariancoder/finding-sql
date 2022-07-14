use leetcode;
Create table If Not Exists Experiments (experiment_id int, platform varchar(100) , experiment_name varchar(100));

insert into Experiments (experiment_id,platform,experiment_name) value (4,'IOS','Programming');
insert into Experiments (experiment_id,platform,experiment_name) value (13,'IOS','Sports');
insert into Experiments (experiment_id,platform,experiment_name) value (14,'Android','Reading');
insert into Experiments (experiment_id,platform,experiment_name) value (8,'Web','Reading');
insert into Experiments (experiment_id,platform,experiment_name) value (12,'Web','Reading');
insert into Experiments (experiment_id,platform,experiment_name) value (18,'Web','Programming');

with jointb as (
with experiment_values as (
select
    distinct experiment_name
from
    Experiments)
select
    distinct platform,
    experiment_values.experiment_name
from
    Experiments
cross join
    experiment_values
order by
    platform,experiment_name)
select
    platform,
    experiment_name,
    case
        when (platform,experiment_name) in (select platform,experiment_name from Experiments) then 1 else 0
    end as num_experiments
from
    jointb
order by
    platform,num_experiments desc ;













