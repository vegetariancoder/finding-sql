# Problem Statement: Write a SQL query to find the total no of Olympic Games held as per the dataset.

select
    count(distinct Games) as total_olympics_games
from
    athlete_events;

# Problem Statement: Write a SQL query to list down all the Olympic Games held so far.

select
    Year,
    Season,
    City
from
    athlete_events
group by
    Year,Season,City
order by
    Year;

# Problem Statement: SQL query to fetch total no of countries participated in each olympic games.

with answer as (
select
    Games,
    region
from
    athlete_events
inner join
    noc_regions
on
    athlete_events.NOC = noc_regions.NOC)
select
    Games,
    count(distinct region) as cnt
from
    answer
group by
    Games;


# Problem Statement: Write a SQL query to return the Olympic Games which had the highest participating countries and the lowest participating countries.

with answer as (
select
    Games,
    region
from
    athlete_events
inner join
    noc_regions
on
    athlete_events.NOC = noc_regions.NOC)
, lowest as (
select
    1 as id,
    Games,
    count(distinct region) as cnt,
    dense_rank() over (order by count(distinct region)) as drnk
from
    answer
group by
    Games)
, highest as (
select
    1 as id,
    Games,
    count(distinct region) as cnt,
    dense_rank() over (order by count(distinct region) desc ) as drnk
from
    answer
group by
    Games)
, final_lowest as (
select
    id,
    concat(Games,'-',cnt) as lowest_countries
from
    lowest
where
    drnk=1)
, final_highest as (
select
    id,
    concat(Games,'-',cnt) as highest_countries
from
    highest
where
    drnk=1)
select lowest_countries,highest_countries from final_lowest inner join final_highest on final_lowest.id = final_highest.id;


# Problem Statement: SQL query to return the list of countries who have been part of every Olympics games.

with answer as (
select
    region,
    count(distinct Games) as cnt
from
    athlete_events
inner join
    noc_regions
on
    athlete_events.NOC=noc_regions.NOC
group by
    region)
select
    region,
    cnt
from
    answer
where
    cnt = (select count(distinct Games) from athlete_events);


