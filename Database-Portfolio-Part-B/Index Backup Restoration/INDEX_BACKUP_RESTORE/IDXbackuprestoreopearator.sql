use stockauction;

-- create user backup & restore operator + indices rebuilder
CREATE USER 'IDXBackUpRestoreOperator'@'localhost' IDENTIFIED BY 'IDXBackUpRestoreOperator';

-- granting permissions, note: reference is added so user can build foreign keys when restoring
grant select, alter, LOCK TABLES, drop, insert, create,
references on stockauction.* to 'IDXBackUpRestoreOperator'@'localhost';
grant Process, RELOAD on *.* to 'IDXBackUpRestoreOperator'@'localhost';

update mysql.user 
set reload_priv='Y',  select_priv='Y', insert_priv='Y', CREATE_PRIV='Y'
where user = 'IDXBackUpRestoreOperator' and host = 'localhost';

flush privileges;




