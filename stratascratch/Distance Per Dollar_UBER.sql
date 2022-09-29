drop database strata;
create database strata;
use strata;
Create table If Not Exists uber_request_logs (request_id int, request_date date, request_status varchar(100), distance_to_travel float, monetary_cost float, driver_to_client_distance float);

select * from uber_request_logs;

select
    table1.date_wise,
    distance_per_dollar_date,
    distance_per_dollar_month
from
    (
select
    date_format(request_date,'%Y-%m') as date_wise,
    round(avg(distance_to_travel/uber_request_logs.monetary_cost),2) as distance_per_dollar_date
from
    uber_request_logs
group by
    date_wise) table1
inner join (
select
    date_format(request_date,'%Y-%m') date_wise,
    round(sum(distance_to_travel/uber_request_logs.monetary_cost),2) as distance_per_dollar_month
from
    uber_request_logs
group by
    date_wise) table2
on
    table1.date_wise=table2.date_wise;
