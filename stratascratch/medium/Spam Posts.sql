with normal_cnt as (
select
    post_date,
    count(viewer_id) as cnt
from
    facebook_posts
inner join
    facebook_post_views
on
    facebook_posts.post_id = facebook_post_views.post_id
group by
    post_date)
, spam_cnt as (
select
    post_date,
    count(viewer_id) as spamcnt
from
    facebook_posts
inner join
    facebook_post_views
on
    facebook_posts.post_id = facebook_post_views.post_id
where
    post_keywords like '%spam%'
group by
    post_date)
select
    normal_cnt.post_date,
    (spamcnt/cnt)*100 as spam_share
from
    normal_cnt
inner join
    spam_cnt
on
    normal_cnt.post_date = spam_cnt.post_date;
