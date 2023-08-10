select
    airbnb_hosts.nationality,
    count(distinct airbnb_units.host_id) as apartment_count
from
    airbnb_hosts
inner join
    airbnb_units
on
    airbnb_hosts.host_id = airbnb_units.host_id
where
    airbnb_units.unit_type = 'Apartment'
and
    airbnb_hosts.age <= 30;