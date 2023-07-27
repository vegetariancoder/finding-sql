select * from google_gmail_emails;

with answer as (
select
    from_user,
    count(*) as cnt
from
    google_gmail_emails
group by
    from_user)
select
    from_user,
    cnt as total_emails,
    dense_rank() over (order by cnt desc,from_user) as row_numbers
from
    answer

