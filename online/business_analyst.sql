drop database online;
create database online;
use online;

create table candidates
(
    id      int,
    gender  varchar(1),
    age     int,
    party   varchar(20)
);
insert into candidates values(1,'M',55,'Democratic');
insert into candidates values(2,'M',51,'Democratic');
insert into candidates values(3,'F',62,'Democratic');
insert into candidates values(4,'M',60,'Republic');
insert into candidates values(5,'F',61,'Republic');
insert into candidates values(6,'F',58,'Republic');


create table results
(
    constituency_id     int,
    candidate_id        int,
    votes               int
);
insert into results values(1,1,847529);
insert into results values(1,4,283409);
insert into results values(2,2,293841);
insert into results values(2,5,394385);
insert into results values(3,3,429084);
insert into results values(3,6,303890);


select * from candidates;
select * from results;


with cte as (
select
    constituency_id,
    candidate_id,
    votes as demo_votes,
    party,
    lead(votes) over (partition by constituency_id order by constituency_id) as rep_votes
from
    candidates
inner join
    results
on candidates.id = results.candidate_id)
, answer as (
select
    case
        when demo_votes > rep_votes then 'Democratic' else 'Republic'
    end as winner
from
    cte
where
    rep_votes is not null
)
select winner,count(*) as cnt from answer group by winner;


with answer as (
select
    constituency_id,
    candidate_id,
    votes,
    party,
    rank() over (partition by constituency_id order by votes desc ) as rnk
from
    candidates
inner join
    results
on candidates.id = results.candidate_id)
select
    party,
    count(*) as cnt
from
    answer
where
    rnk=1
group by
    party;

drop table if exists customers;
create table customers
(
    id          int,
    first_name  varchar(50),
    last_name   varchar(50)
);
insert into customers values(1, 'Carolyn', 'O''Lunny');
insert into customers values(2, 'Matteo', 'Husthwaite');
insert into customers values(3, 'Melessa', 'Rowesby');

drop table if exists campaigns;
create table campaigns
(
    id          int,
    customer_id int,
    name        varchar(50)
);
insert into campaigns values(2, 1, 'Overcoming Challenges');
insert into campaigns values(4, 1, 'Business Rules');
insert into campaigns values(3, 2, 'YUI');
insert into campaigns values(1, 3, 'Quantitative Finance');
insert into campaigns values(5, 3, 'MMC');

drop table if exists events;
create table events
(
    campaign_id int,
    status      varchar(50)
);
insert into events values(1, 'success');
insert into events values(1, 'success');
insert into events values(2, 'success');
insert into events values(2, 'success');
insert into events values(2, 'success');
insert into events values(2, 'success');
insert into events values(2, 'success');
insert into events values(3, 'success');
insert into events values(3, 'success');
insert into events values(3, 'success');
insert into events values(4, 'success');
insert into events values(4, 'success');
insert into events values(4, 'failure');
insert into events values(4, 'failure');
insert into events values(5, 'failure');
insert into events values(5, 'failure');
insert into events values(5, 'failure');
insert into events values(5, 'failure');
insert into events values(5, 'failure');
insert into events values(5, 'failure');
insert into events values(4, 'success');
insert into events values(5, 'success');
insert into events values(5, 'success');
insert into events values(1, 'failure');
insert into events values(1, 'failure');
insert into events values(1, 'failure');
insert into events values(2, 'failure');
insert into events values(3, 'failure');

select * from customers;
select * from campaigns;
select * from events;

with cte as (
select
    events.campaign_id,
    events.status,
    campaigns.customer_id,
    campaigns.name,
    customers.first_name,
    customers.last_name
from
    events
inner join
    campaigns
on
    events.campaign_id = campaigns.id
inner join
    customers
on
    campaigns.customer_id = customers.id),
success as (
select
    'success' as event_type,
    first_name,
    last_name,
    group_concat(distinct name) as campaign,
    count(campaign_id) as cnt,
    dense_rank() over (order by count(campaign_id) desc ) as drnk
from
    cte
where
    status = 'success'
group by
    first_name, last_name),
failure as (
  select
    'failure' as event_type,
    first_name,
    last_name,
    group_concat(distinct name) as campaign,
    count(campaign_id) as cnt,
    dense_rank() over (order by count(campaign_id) desc ) as drnk
from
    cte
where
    status = 'failure'
group by
    first_name, last_name
)
select event_type, concat(first_name,' ',last_name) as customer, campaign, cnt from success where drnk=1
union
select event_type, concat(first_name,' ',last_name) as customer, campaign, cnt from failure where drnk=1;



drop table if exists candidates_tab;
create table candidates_tab
(
    id          int,
    first_name  varchar(50),
    last_name   varchar(50)
);
insert into candidates_tab values(1, 'Davide', 'Kentish');
insert into candidates_tab values(2, 'Thorstein', 'Bridge');

drop table if exists results_tab;
create table results_tab
(
    candidate_id    int,
    state           varchar(50)
);
insert into results_tab values(1, 'Alabama');
insert into results_tab values(1, 'Alabama');
insert into results_tab values(1, 'California');
insert into results_tab values(1, 'California');
insert into results_tab values(1, 'California');
insert into results_tab values(1, 'California');
insert into results_tab values(1, 'California');
insert into results_tab values(2, 'California');
insert into results_tab values(2, 'California');
insert into results_tab values(2, 'New York');
insert into results_tab values(2, 'New York');
insert into results_tab values(2, 'Texas');
insert into results_tab values(2, 'Texas');
insert into results_tab values(2, 'Texas');
insert into results_tab values(1, 'New York');
insert into results_tab values(1, 'Texas');
insert into results_tab values(1, 'Texas');
insert into results_tab values(1, 'Texas');
insert into results_tab values(2, 'California');
insert into results_tab values(2, 'Alabama');

select * from candidates_tab;
select * from results_tab;

with cte as (
select
    candidate_id,
    state,
    concat(first_name,' ',last_name) as candidate_name
from
    results_tab
inner join
    candidates_tab
on
    results_tab.candidate_id = candidates_tab.id),
all_results as (
select
    candidate_name,
    state,
    count(*) as cnt
from
    cte
group by
    candidate_name, state),
ranks_cte as (
select
    *,
    dense_rank() over (partition by candidate_name order by cnt desc ) as drnk
from
    all_results
order by
    cnt desc )
select
    candidate_name,
    group_concat(case
        when drnk = 1 then concat(state,' (',cnt,')')
    end) as first_place,
    group_concat(case
        when drnk = 2 then concat(state,' (',cnt,')')
    end) as second_place,
    group_concat(case
        when drnk = 3 then concat(state,' (',cnt,')')
    end) as third_place
from
    ranks_cte
group by
    candidate_name;


