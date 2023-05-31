CREATE TABLE booking_table(
   Booking_id       VARCHAR(3) NOT NULL
  ,Booking_date     date NOT NULL
  ,User_id          VARCHAR(2) NOT NULL
  ,Line_of_business VARCHAR(6) NOT NULL
);
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b1','2022-03-23','u1','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b2','2022-03-27','u2','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b3','2022-03-28','u1','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b4','2022-03-31','u4','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b5','2022-04-02','u1','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b6','2022-04-02','u2','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b7','2022-04-06','u5','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b8','2022-04-06','u6','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b9','2022-04-06','u2','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b10','2022-04-10','u1','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b11','2022-04-12','u4','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b12','2022-04-16','u1','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b13','2022-04-19','u2','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b14','2022-04-20','u5','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b15','2022-04-22','u6','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b16','2022-04-26','u4','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b17','2022-04-28','u2','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b18','2022-04-30','u1','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b19','2022-05-04','u4','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b20','2022-05-06','u1','Flight');
;
CREATE TABLE user_table(
   User_id VARCHAR(3) NOT NULL
  ,Segment VARCHAR(2) NOT NULL
);
INSERT INTO user_table(User_id,Segment) VALUES ('u1','s1');
INSERT INTO user_table(User_id,Segment) VALUES ('u2','s1');
INSERT INTO user_table(User_id,Segment) VALUES ('u3','s1');
INSERT INTO user_table(User_id,Segment) VALUES ('u4','s2');
INSERT INTO user_table(User_id,Segment) VALUES ('u5','s2');
INSERT INTO user_table(User_id,Segment) VALUES ('u6','s3');
INSERT INTO user_table(User_id,Segment) VALUES ('u7','s3');
INSERT INTO user_table(User_id,Segment) VALUES ('u8','s3');
INSERT INTO user_table(User_id,Segment) VALUES ('u9','s3');
INSERT INTO user_table(User_id,Segment) VALUES ('u10','s3');



# question -1

with actual_users as (
select
    booking_id,
    booking_date,
    booking_table.user_id,
    line_of_business,
    segment
from
    booking_table
inner join
    user_table
on
    booking_table.User_id=user_table.User_id
where
    Line_of_business='Flight' and month(Booking_date)=4)
, total_users as (
select
     Segment,
     count(*) as total_user_cnt
from
    user_table
group by
    Segment
)
select
    actual_users.Segment,
    total_users.total_user_cnt,
    count(distinct User_id) as User_who_booked_flight_april_2022
from
    actual_users
inner join
    total_users
on
    actual_users.Segment=total_users.Segment
group by
    Segment;


# question - 2
with answer as (
select
    User_id,
    min(Booking_date) as min_booking_date
from
    booking_table
group by
    User_id)
select
    User_id
from
    booking_table
where
    (User_id,Booking_date) in (select User_id,min_booking_date from answer) and Line_of_business='Hotel';



with answer as (
select
    User_id,
    Booking_date,
    Line_of_business,
    dense_rank() over (partition by User_id order by Booking_date) as drnk
from
    booking_table)
select
    User_id
from
    answer
where
    drnk=1 and Line_of_business = 'Hotel';


# question - 3
with answer as (
select
    User_id,
    min(Booking_date) as first_date,
    max(Booking_date) as last_date
from
    booking_table
group by
    User_id)
select
    User_id,
    datediff(last_date,first_date) as diff
from
    answer

# question -4

select
    segment,
    sum(case when Line_of_business = 'Flight' then 1 else 0 end) as flight,
    sum(case when Line_of_business = 'Hotel' then 1 else 0 end) as hotel
from
    (
select
    line_of_business,
    segment
from
    booking_table
inner join
    user_table
on
    booking_table.User_id=user_table.User_id) calc
group by
    segment;

