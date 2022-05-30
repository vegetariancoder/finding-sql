drop database leetcode;
create database leetcode;
use leetcode;
Create table If Not Exists FriendRequest (sender_id int, send_to_id int, request_date varchar(100));
Create table If Not Exists RequestAccepted (requester_id int, accepter_id int, accept_date varchar(100));
insert into FriendRequest (sender_id, send_to_id, request_date) values (1,2,'2016/06/01');
insert into FriendRequest (sender_id, send_to_id, request_date) values (1,3,'2016/06/01');
insert into FriendRequest (sender_id, send_to_id, request_date) values (1,4,'2016/06/01');
insert into FriendRequest (sender_id, send_to_id, request_date) values (2,3,'2016/06/02');
insert into FriendRequest (sender_id, send_to_id, request_date) values (3,4,'2016/06/09');
insert into RequestAccepted (requester_id, accepter_id, accept_date) values (1,2,'2016/06/03');
insert into RequestAccepted (requester_id, accepter_id, accept_date) values (1,3,'2016/06/08');
insert into RequestAccepted (requester_id, accepter_id, accept_date) values (2,3,'2016/06/08');
insert into RequestAccepted (requester_id, accepter_id, accept_date) values (3,4,'2016/06/09');
insert into RequestAccepted (requester_id, accepter_id, accept_date) values (3,4,'2016/06/10');



select
    round(count(*)/(select count(*) from FriendRequest),1) as accept_rate
from(
select
    requester_id,
    accepter_id
from
    RequestAccepted
group by
    requester_id,
    accepter_id
having
    count(*) >= 1) table1;






