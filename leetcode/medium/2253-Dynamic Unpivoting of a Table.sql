use leetcode;

select * from Prod;

with 2253_leetcode as (
select
    product_id,
    'LC_Store' as 'store',
    LC_Store as price
from
    Prod
union
select
    product_id,
    'Shop' as 'store',
    Shop as price
from
    Prod
union
select
    product_id,
    'Nozama' as 'store',
    Nozama as price
from
    Prod
union
select
    product_id,
    'Souq' as 'store',
    Souq as price
from
    Prod)
select
    *
from
    2253_leetcode
where
    price is not null
order by
    product_id;