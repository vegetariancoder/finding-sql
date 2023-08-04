drop database online;
create database online;
use online;


create table emp_tree(
    emp_id int,
    reporting_id int
);

insert into emp_tree value (1,null);
insert into emp_tree value (2,1);
insert into emp_tree value (3,1);
insert into emp_tree value (4,2);
insert into emp_tree value (5,2);
insert into emp_tree value (6,3);
insert into emp_tree value (7,3);
insert into emp_tree value (8,4);
insert into emp_tree value (9,4);


select * from emp_tree;


with recursive cte as (
    select
        emp_id,
        emp_id as emp_hierarchy
    from
        emp_tree
    union all
    select
        cte.emp_id,
        emp_tree.emp_id
    from
        cte
            inner join
        emp_tree
    on
        cte.emp_hierarchy = emp_tree.reporting_id
)
select * from cte order by emp_id;
