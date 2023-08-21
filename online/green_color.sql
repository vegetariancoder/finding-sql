create database online;


use online;

CREATE TABLE colors (
  id INT,
  color VARCHAR(255)
);
INSERT INTO colors (id, color)
VALUES
  (1, 'green'),
  (1, 'Green-orange'),
  (2, 'Black'),
  (3, 'Blue'),
  (4, 'Red'),
  (5, 'Green'),
  (5, 'Green-Orange'),
  (6, 'Green'),
  (7, 'Green'),
  (8, 'Green'),
  (8, 'Green-Orange'),
  (9, 'Green'),
  (10, 'Green');


select * from colors;


select
    distinct id,
    IF(color = 'Green' and id in (select id from colors where color = 'Green-Orange'), 'Green-Orange', color) as color
from
    colors
where
    color in ('Green-Orange','green');


select
    id,
    max(color) as color
from
    colors
where
    color in ('Green-Orange','green')
group by
    id;


select
    id,
    case
        when count(distinct color) = 2 then 'Green-Orange' else 'Green'
    end as color
from
    colors
where
    color in ('Green-Orange','green')
group by
    id;