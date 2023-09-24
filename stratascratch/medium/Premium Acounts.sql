use strata;

select * from premium;

select
    entry_date,
    count(account_id) as premium_paid_accounts
from
    premium
where
    final_price>0
group by
    entry_date;


select
    a.entry_date,
    count(a.account_id) as premium_paid_accounts,
    count(b.account_id) as premium_paid_accounts_after_7d
from
    premium as a
left join
    premium as b
on
    a.account_id = b.account_id
and
    datediff(b.entry_date,a.entry_date)=7
and
    b.final_price>0
where
    a.final_price>0
group by
    a.entry_date;
