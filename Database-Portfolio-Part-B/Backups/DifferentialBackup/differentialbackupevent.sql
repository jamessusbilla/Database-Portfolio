use stockauction;

CREATE EVENT IF NOT EXISTS
B4THURSDAYAUCTION ON SCHEDULE EVERY 1 WEEK
STARTS '2020-10-22 03:00:00'
on completion preserve
DO
CALL DIFFERENTIALBACKUP(); 

SHOW EVENTS FROM stockauction;