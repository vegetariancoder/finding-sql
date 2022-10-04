select * from attendances;

select * from instructor_batch_maps;

select * from sessions;

select * from batches;

select
    session_id,
    avg(rating) as avg_rating
from
    attendances
group by
    session_id;
