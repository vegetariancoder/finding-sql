drop database strata;
create database strata;
use strata;
create table google_gmail_emails
(
id int(100),
from_user varchar(100),
to_user varchar(100),
day int);

select * from google_gmail_emails;

select
    from_user,
    count(from_user) as counting,
    dense_rank() over (order by count(from_user) desc,from_user) as drnk
from
    google_gmail_emails
group by
    from_user;