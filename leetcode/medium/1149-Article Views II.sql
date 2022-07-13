USE leetcode;
DROP TABLE IF EXISTS Views;
CREATE TABLE Views (
  article_id int,
  author_id int,
  viewer_id int,
  view_date date
);
INSERT INTO Views
  (article_id, author_id, viewer_id,view_date )
VALUES
  (1,3,5,'2019-08-01'),
  (3,4,5,'2019-08-01'),
  (1,3,6,'2019-08-02'),
(2,7,7,'2019-08-01'),
(2,7,6,'2019-08-02'),
(4,7,1,'2019-07-22'),
(3,4,4,'2019-07-21'),
(3,4,4,'2019-07-21');


select * from Views;


with 1149_leetcode as (
select
    view_date
from
    Views
group by
    view_date
having
    count(distinct article_id) >=2)
select
    viewer_id
from
    Views
where
    view_date in (select view_date from 1149_leetcode)
group by
    viewer_id
having
    count(viewer_id)>=2;