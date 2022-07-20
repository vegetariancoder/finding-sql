use leetcode;
CREATE TABLE IF NOT EXISTS Tweets (
    tweet_id INT,
    content varchar(100));

insert into Tweets (tweet_id, content) values (1,'Vote for Biden');
insert into Tweets (tweet_id, content) values (2,'Let us make America great again!');

with 1683_leetcode as (
select
    *,
    if(length(content) > 15, 'Yes','No') as decision
from
    Tweets)
select
    tweet_id
from
    1683_leetcode
where
    decision = 'Yes';