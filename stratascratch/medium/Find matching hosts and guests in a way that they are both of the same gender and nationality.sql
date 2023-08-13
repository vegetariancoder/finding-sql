use strata;

select * from airbnb_host;


select * from airbnb_guests;


select
    distinct host_id as host_id,
    guest_id
from
    airbnb_host
inner join
    airbnb_guests
where
    airbnb_host.gender = airbnb_guests.gender and airbnb_host.nationality= airbnb_guests.nationality;