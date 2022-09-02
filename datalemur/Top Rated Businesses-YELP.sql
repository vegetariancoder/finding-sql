drop database datalemur;
create database datalemur;
use datalemur;


Create table If Not Exists reviews (business_id int, review_id float, review_stars int);
insert into reviews (business_id, review_id,review_stars) values (532,1234,5);
insert into reviews (business_id, review_id,review_stars) values (824,1452,3);
insert into reviews (business_id, review_id,review_stars) values (819,2341,5);
insert into reviews (business_id, review_id,review_stars) values (716,1325,4);
insert into reviews (business_id, review_id,review_stars) values (423,1434,2);

select
    count(business_id) business_num,
    round(count(business_id)/(select count(*) from reviews)*100,2) as top_business_pct
from
    reviews
where
    review_stars>3;