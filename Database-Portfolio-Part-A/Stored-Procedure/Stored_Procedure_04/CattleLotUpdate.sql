use stockauction;

-- Run the Provided Auction Number to import clients

-- Run CattleLotInsert
DROP TEMPORARY TABLE IF EXISTS CattleUpdate;
-- Cattle Temporary Table
CREATE TEMPORARY TABLE CattleUpdate
(
	lotNumber smallint primary key,
    averageWeight decimal(6,2) null,
    buyer smallint null,
    sellingPricePerKg decimal(5,2) null,
    passedIn bit(1) default 0
);

-- Load Data
load data infile 'C:\\BCDE214Insert\\C1621Sales.csv' 
into table CattleUpdate fields terminated by ',' enclosed by '\\'
lines terminated by '\r\n' ignore 1 lines
(@lotNumber, @averageWeight, @sellingPricePerkg, @buyer, @passedIn) -- Same from file column
set lotNumber = @lotNumber, averageweight = @averageWeight, buyer = @buyer, sellingPricePerKg = @sellingPricePerkg, passedIn = @passedIn;


-- Create Stored Procedure
DELIMITER //
CREATE PROCEDURE UpdateCattleInfo()
BEGIN
SET FOREIGN_KEY_CHECKS=0;
UPDATE cattlelot cl, CattleUpdate
SET cl.averageWeight = CattleUpdate.averageWeight, cl.sellingPricePerKg = CattleUpdate.sellingPricePerKg, 
cl.passedIn = CattleUpdate.passedIn, cl.buyer = CattleUpdate.buyer
where CattleUpdate.lotNumber = cl.lotNumber AND cl.auctionId = 'C1621';
SET FOREIGN_KEY_CHECKS=1;
END //

-- Test
CALL UpdateCattleInfo();

-- Test
select * from cattlelot;

