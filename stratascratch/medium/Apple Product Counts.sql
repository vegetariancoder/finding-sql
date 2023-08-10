select
    playbook_users.language,
    count(distinct case when playbook_events.device in ('iphone 5s','ipad air','macbook pro') then playbook_events.user_id else null end) as n_apple_user,
    count(distinct playbook_events.user_id) as n_total_users
from
    playbook_events
inner join
    playbook_users
on
   playbook_events.user_id =  playbook_users.user_id
group by
    playbook_users.language