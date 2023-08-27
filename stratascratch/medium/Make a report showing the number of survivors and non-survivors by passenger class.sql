select * from titanic;


with answer as (
select
    pclass,
    survived,
    count(passengerid) as cnt
from
    titanic
group by
    pclass,survived
order by
    pclass)
select
    survived,
    sum(case
        when pclass=1 then cnt
    end) as first_class,
    sum(case
        when pclass=2 then cnt
    end) as second_class,
    sum(case
        when pclass=3 then cnt
    end) as third_class
from
    answer
group by
    survived;

