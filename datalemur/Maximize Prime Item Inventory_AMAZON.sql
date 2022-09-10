drop database datalemur;
create database datalemur;
use datalemur;

Create table If Not Exists inventory (item_id int, item_type varchar(100), item_category varchar(100), square_footage float);
insert into inventory (item_id, item_type, item_category, square_footage) values (1374,'prime_eligible','mini refrigerator',68.00);
insert into inventory (item_id, item_type, item_category, square_footage) values (4245,'not_prime','standing lamp',26.40);
insert into inventory (item_id, item_type, item_category, square_footage) values (2452,'prime_eligible','television',85.00);
insert into inventory (item_id, item_type, item_category, square_footage) values (3255,'not_prime','side table',22.60);
insert into inventory (item_id, item_type, item_category, square_footage) values (1672,'prime_eligible','laptop',8.50);



WITH summary
AS (
  SELECT
    item_type,
    SUM(square_footage) AS total_sqft,
    COUNT(*) AS item_count
  FROM inventory
  GROUP BY item_type),
prime_items
AS (
  SELECT
    DISTINCT item_type,
    total_sqft,
    500000/total_sqft AS prime_item_combo,
    500000/total_sqft * item_count AS prime_item_count
  FROM summary
  WHERE item_type = 'prime_eligible'),
non_prime_items
AS (
  SELECT
    DISTINCT item_type,
    total_sqft,
      (500000 - (SELECT prime_item_combo * total_sqft FROM prime_items))
      / total_sqft
      * item_count AS non_prime_item_count
  FROM summary
  WHERE item_type = 'not_prime')

SELECT
  item_type,
  prime_item_count AS item_count
FROM prime_items
UNION ALL
SELECT
  item_type,
  non_prime_item_count AS item_count
FROM non_prime_items;

