use stockauction;
DELIMITER $$
CREATE PROCEDURE DIFFERENTIALBACKUP()
BEGIN
set @auctionclient = CONCAT("select * from auctionclient into outfile 'C:/Account/auctionclient", DATE_FORMAT(NOW(), '%d%m%Y'), ".csv'", 
" FIELDS ENCLOSED BY '' TERMINATED BY ',' ", ' ESCAPED BY ''"'' LINES TERMINATED BY ''\\r\\n'''"");
set @auctionclientatauction = CONCAT("select * from auctionclientatauction into outfile 'C:/Account/auctionclientatauction", DATE_FORMAT(NOW(), '%d%m%Y'), ".csv'", 
" FIELDS ENCLOSED BY '' TERMINATED BY ',' ", ' ESCAPED BY ''"'' LINES TERMINATED BY ''\\r\\n'''"");
set @auctionday = CONCAT("select * from auctionday into outfile 'C:/Account/auctionday", DATE_FORMAT(NOW(), '%d%m%Y'), ".csv'", 
" FIELDS ENCLOSED BY '' TERMINATED BY ',' ", ' ESCAPED BY ''"'' LINES TERMINATED BY ''\\r\\n'''"");
set @cattleauction = CONCAT("select * from cattleauction into outfile 'C:/Account/cattleauction", DATE_FORMAT(NOW(), '%d%m%Y'), ".csv'", 
" FIELDS ENCLOSED BY '' TERMINATED BY ',' ", ' ESCAPED BY ''"'' LINES TERMINATED BY ''\\r\\n'''"");
set @cattlelot = CONCAT("select * from cattlelot into outfile 'C:/Account/cattlelot", DATE_FORMAT(NOW(), '%d%m%Y'), ".csv'", 
" FIELDS ENCLOSED BY '' TERMINATED BY ',' ", ' ESCAPED BY ''"'' LINES TERMINATED BY ''\\r\\n'''"");
set @clientattendance = CONCAT("select * from clientattendance into outfile 'C:/Account/clientattendance", DATE_FORMAT(NOW(), '%d%m%Y'), ".csv'", 
" FIELDS ENCLOSED BY '' TERMINATED BY ',' ", ' ESCAPED BY ''"'' LINES TERMINATED BY ''\\r\\n'''"");
set @sheepauction = CONCAT("select * from sheepauction into outfile 'C:/Account/sheepauction", DATE_FORMAT(NOW(), '%d%m%Y'), ".csv'", 
" FIELDS ENCLOSED BY '' TERMINATED BY ',' ", ' ESCAPED BY ''"'' LINES TERMINATED BY ''\\r\\n'''"");
set @sheeplot = CONCAT("select * from sheeplot into outfile 'C:/Account/sheeplot", DATE_FORMAT(NOW(), '%d%m%Y'), ".csv'", 
" FIELDS ENCLOSED BY '' TERMINATED BY ',' ", ' ESCAPED BY ''"'' LINES TERMINATED BY ''\\r\\n'''"");
set @stockagency = CONCAT("select * from stockagency into outfile 'C:/Account/stockagency", DATE_FORMAT(NOW(), '%d%m%Y'), ".csv'", 
" FIELDS ENCLOSED BY '' TERMINATED BY ',' ", ' ESCAPED BY ''"'' LINES TERMINATED BY ''\\r\\n'''"");
set @stockagent = CONCAT("select * from stockagent into outfile 'C:/Account/stockagent", DATE_FORMAT(NOW(), '%d%m%Y'), ".csv'", 
" FIELDS ENCLOSED BY '' TERMINATED BY ',' ", ' ESCAPED BY ''"'' LINES TERMINATED BY ''\\r\\n'''"");
prepare l1 from @auctionclient;
prepare l2 from @auctionclientatauction;
prepare l3 from @auctionday;
prepare l4 from @cattleauction;
prepare l5 from @cattlelot;
prepare l6 from @clientattendance;
prepare l7 from @sheepauction;
prepare l8 from @sheeplot;
prepare l9 from @stockagency;
prepare l10 from @stockagent;
EXECUTE l1;
EXECUTE l2;
EXECUTE l3; 
EXECUTE l4;
EXECUTE l5;
EXECUTE l6; 
EXECUTE l7; 
EXECUTE l8; 
EXECUTE l9; 
EXECUTE l10;
DROP PREPARE l1;
DROP PREPARE l2; 
DROP PREPARE l3; 
DROP PREPARE l4;
DROP PREPARE l5;
DROP PREPARE l6; 
DROP PREPARE l7; 
DROP PREPARE l8; 
DROP PREPARE l9; 
DROP PREPARE l10;
END $$
DELIMITER ;

-- Testing
CALL DIFFERENTIALBACKUP();
