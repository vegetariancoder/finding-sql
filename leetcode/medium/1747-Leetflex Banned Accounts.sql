USE leetcode;
DROP TABLE IF EXISTS Views;
CREATE TABLE LogInfo (
  account_id int,
  ip_address int,
  login datetime ,
  logout timestamp
);


INSERT INTO LogInfo
  (account_id, ip_address, login,logout )
VALUES
        (1,1,'2021-02-01 09:00:00','2021-02-01 09:30:00'),
        (1,2,'2021-02-01 08:00:00','2021-02-01 11:30:00'),
       (2,6,'2021-02-01 20:30:00','2021-02-01 22:00:00'),
       (2,7,'2021-02-02 20:30:00','2021-02-02 22:00:00'),
       (3,9,'2021-02-01 16:00:00','2021-02-01 16:59:59'),
       (3,13,'2021-02-01 17:00:00','2021-02-01 17:59:59'),
       (4,10,'2021-02-01 16:00:00','2021-02-01 17:00:00'),
       (4,11,'2021-02-01 17:00:00','2021-02-01 17:59:59');


select * from LogInfo;

select
    distinct L1.account_id
from
    LogInfo as L1
inner join
    LogInfo as L2
on
    L1.account_id = L2.account_id and L1.ip_address != L2.ip_address
where
    not (L1.login>L2.logout or L1.logout < L2.login);


