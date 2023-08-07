with answer as (
select
    id_guest,
    sum(n_messages) as sm_messages
from
    airbnb_contacts
group by
    id_guest
    )
select
    id_guest,
    dense_rank() over (order by sm_messages desc) as ranks,
    sm_messages
from
    answer
order by
    ranks,id_guest