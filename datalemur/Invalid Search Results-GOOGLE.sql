drop database datalemur;
create database datalemur;
use datalemur;


Create table If Not Exists search_category (country varchar(100), search_cat varchar(100), num_search int, invalid_result_pct float);
insert into search_category (country, search_cat,num_search,invalid_result_pct) values ('UK','home',0,0.0);
insert into search_category (country, search_cat,num_search,invalid_result_pct) values ('UK','tax',98000,1.00);
insert into search_category (country, search_cat,num_search,invalid_result_pct) values ('UK','travel',100000,3.25);

select * from search_category;

select
    country,
    sum(num_search) as num_search,
    round((sum(num_search * (invalid_result_pct/100)))/sum(num_search)*100,2) as invalid_result_pct
from
    search_category
group by
    country;
