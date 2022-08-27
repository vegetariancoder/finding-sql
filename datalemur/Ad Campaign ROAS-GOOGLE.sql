drop database datalemur;
create database datalemur;
use datalemur;

Create table If Not Exists ad_campaigns (campaign_id int, spend int, revenue int, advertiser_id int);
insert into ad_campaigns (campaign_id, spend, revenue, advertiser_id) values (1,5000,7500,3);
insert into ad_campaigns (campaign_id, spend, revenue, advertiser_id) values (2,1000,900,1);
insert into ad_campaigns (campaign_id, spend, revenue, advertiser_id) values (3,3000,12000,2);
insert into ad_campaigns (campaign_id, spend, revenue, advertiser_id) values (4,500,2000,4);
insert into ad_campaigns (campaign_id, spend, revenue, advertiser_id) values (5,100,400,4);

with answer as (
select
   advertiser_id,
   ROAS,
   row_number() over (partition by advertiser_id order by ROAS) as r_no
from

(select
    advertiser_id,
    round((revenue/spend),1) as ROAS
from
    ad_campaigns
order by
    advertiser_id) calc_tab)
select
    advertiser_id,
    ROAS
from
    answer
where
    r_no=1;