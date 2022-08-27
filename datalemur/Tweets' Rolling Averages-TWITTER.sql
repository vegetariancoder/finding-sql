drop database datalemur;
create database datalemur;
use datalemur;

Create table If Not Exists tweets (tweet_id int, user_id int, tweet_date date);
insert into tweets (tweet_id, user_id, tweet_date) values (214252,111,'2022-06-01');
insert into tweets (tweet_id, user_id, tweet_date) values (739252,111,'2022-06-01');
insert into tweets (tweet_id, user_id, tweet_date) values (846402,111,'2022-06-02');
insert into tweets (tweet_id, user_id, tweet_date) values (241425,254,'2022-06-02');
insert into tweets (tweet_id, user_id, tweet_date) values (137374,111,'2022-06-04');

with answer as (
select
    *,
    sum(counts) over (partition by user_id order by tweet_date) as r_sum,
    row_number() over (partition by user_id order by tweet_date) as row_num
from
    (
select
    user_id,
    tweet_date,
    count(tweet_id) as counts
from
    tweets
group by
    user_id, tweet_date
order by
    user_id) calc_tab)
select
    user_id,
    tweet_date,
    round(r_sum/row_num,2) as rolling_avg_3days
from
    answer;