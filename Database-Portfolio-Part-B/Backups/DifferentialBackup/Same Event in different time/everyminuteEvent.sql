use stockauction;

CREATE EVENT IF NOT EXISTS
testingup ON SCHEDULE EVERY 1 minute
STARTS '2020-10-24 01:21:00'
on completion preserve
DO
CALL DIFFERENTIALBACKUP(); 
