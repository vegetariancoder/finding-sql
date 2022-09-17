select
    date,
    total_energy
from
    (
with answer as (
select * from fb_eu_energy
union all
select * from fb_asia_energy
union all
select * from fb_na_energy)
select
    date,
    sum(consumption) as total_energy,
    rank() over (order by sum(consumption) desc) as rnk
from
    answer
group by
    date) calc
where
    rnk=1
order by date