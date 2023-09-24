use strata;

select
    *
from
    active;

select
    round(sum(case when status='open' then 1 else 0 end)/count(user_id),1) as active_users_share
from
    active;
