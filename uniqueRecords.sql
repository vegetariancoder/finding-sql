use online;
CREATE TABLE recipes (
  recipe_id INT NOT NULL,
  recipe_name VARCHAR(30) NOT NULL
);

INSERT INTO recipes
    (recipe_id, recipe_name)
VALUES
    (1,"Tacos"),
    (2,"Tomato Soup"),
    (2,"Tomato"),
    (3,"Grilled Cheese"),
    (3,"Grilled Cheese"),
    (3,"Grilled Cheese");


select * from recipes;

# this is for removing duplicates
select
    recipe_id,
    recipe_name
from
    recipes
group by
    recipe_id, recipe_name
having
    count(*)=1;

with answer as (
select
    recipe_id,
    recipe_name,
    row_number() over (partition by recipe_id,recipe_name) as rno
from
    recipes)
delete from answer where rno>1;




# this is for finding distinct values
select
    distinct recipe_id,recipe_name
from
    recipes;

# this is for finding distinct values
select
    recipe_id,
    recipe_name
from
    recipes
union
select
    recipe_id,
    recipe_name
from
    recipes;


# this is for finding distinct values
select
    recipe_id,
    recipe_name
from
    recipes
intersect
select
    recipe_id,
    recipe_name
from
    recipes;

# this is for finding distinct values
with answer as(
select
    recipe_id,
    recipe_name,
    row_number() over (partition by recipe_id,recipe_name) as rno
from
    recipes)
select recipe_id,recipe_name from answer where rno=1;

# this is for finding distinct values
select
    recipe_id,
    recipe_name
from
    recipes
group by
    recipe_id, recipe_name;



