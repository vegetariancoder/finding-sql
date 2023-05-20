use leetcode;

drop table users;
-- Create table statement
CREATE TABLE users
(
    id    INT,
    email VARCHAR(255)
);

-- Insert into statement
INSERT INTO users (id, email)
VALUES (1, 'email1@example.com'),
       (2, 'email2@example.com'),
       (3, 'email2@example.com'),
       (4, 'email3@example.com'),
       (5, 'email3@example.com');


# first approach

# Steps to follow :
# 1. first search for max id of each email where count of emails is greater than 1.
# 2. Delete from table where id in max id of duplicate emails.

select *
from users;

delete
from users
where id in (select id
             from (select max(id) as id
                   from users
                   group by email
                   having count(*) > 1) as duplicates);


# second approach

# Steps to follow :
# 1. first join the table using a self join e.g. users u1 join users u2
# 2. Now, we have to find out the id from users u1 table where id is users u1 id is greater than users u2 id e.g. u1.id > u2.id.
# 2. and now, we have to find out the id from users u1 and users u2 where u1.email = u2.email

select *
from users;

delete
from users
where id in (select id
             from (select u1.id
                   from users u1
                            join
                        users u2
                   where u1.id > u2.id
                     and u1.email = u2.email) duplicates);


# third approach

# Steps to follow :
# 1. use the dense rank function to create a column which partition the data by email and order by id
# 2. After using the data will look something like this : 1, 'email1@example.com' - 1, 1, 'email2@example.com'- 1, 1, 'email2@example.com' - 2.
# each duplicate id will assign a value greater than 1
# select all the id where drnk is greater than 1 and just delete those.


select *
from users;


delete
from users
where id in (select id
             from (select *,
                          dense_rank() over (partition by email order by id) as drnk
                   from users) calc
             where drnk > 1);


# fourth approach
# Steps to follow :
# 1. first check for min id of the emails where count(*) > 1.
# 2. For each duplicate email, the above step will provide a minimum id. Select those id and delete them from table.

select *
from users;

delete
from users
where id in (select min_id
             from (select min(id) as min_id
                   from users
                   group by email
                   having count(*) > 1) calc);