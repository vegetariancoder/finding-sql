with answer as (select
    user_firstname,
    user_lastname,
    dense_rank() over (order by count(distinct user_flags.video_id) desc) as drnk
from
    user_flags
inner join
    flag_review
on
  user_flags.flag_id =  flag_review.flag_id
where
    flag_review.reviewed_outcome = 'APPROVED'
group by
    1,2)
select
    concat(user_firstname,' ',user_lastname) as username
from
    answer
where
    drnk = 1;