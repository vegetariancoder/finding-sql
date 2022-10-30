drop database datalemur;
create database datalemur;
use datalemur;

Create table If Not Exists measurements (measurement_id int, measurement_value float, measurement_time datetime);
insert into measurements (measurement_id, measurement_value,measurement_time ) values (131233,1109.51,'2022-07-10 09:00:00');
insert into measurements (measurement_id, measurement_value,measurement_time ) values (135211,1662.74,'2022-07-10 11:00:00');
insert into measurements (measurement_id, measurement_value,measurement_time ) values (523542,1246.24,'2022-07-10 13:15:00');
insert into measurements (measurement_id, measurement_value,measurement_time ) values (143562,1124.50,'2022-07-11 15:00:00');
insert into measurements (measurement_id, measurement_value,measurement_time ) values (346462,1234.14,'2022-07-11 16:45:00');

with answer as (
select
    *
from
    (
select
    *,
    dense_rank() over (partition by date(measurement_time) order by measurement_time) as odd_eve_values
from
    measurements) calc_table)
select
    date(measurement_time) as measurement_day,
    round(sum(case
        when mod(odd_eve_values,2)=1 then measurement_value
    end),2) as odd_sum,
    round(sum(case
        when mod(odd_eve_values,2)=0 then measurement_value
    end),2) as even_sum
from
    answer
group by
    1;
