drop database datalemur;
create database datalemur;
use datalemur;


Create table If Not Exists Trireviewsps (review_id int, user_id varchar(50), submit_date date,product_id int, stars int);

insert into Trireviewsps (review_id, user_id, submit_date, product_id, stars) values (6171,123,'2022-06-08',50001,4);
insert into Trireviewsps (review_id, user_id, submit_date, product_id, stars) values (7802,265,'2022-06-10',69852,4);
insert into Trireviewsps (review_id, user_id, submit_date, product_id, stars) values (5293,362,'2022-06-18',50001,3);
insert into Trireviewsps (review_id, user_id, submit_date, product_id, stars) values (6352,192,'2022-07-26',69852,3);
insert into Trireviewsps (review_id, user_id, submit_date, product_id, stars) values (4517,981,'2022-07-05',69852,2);


select
    month(submit_date) as month,
    product_id,
    round(avg(stars),2) as avg_stars
from
    Trireviewsps
group by
    month(submit_date), product_id;