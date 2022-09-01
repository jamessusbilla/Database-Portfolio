use stockauction;

-- Run the Provided Auction Number to import clients

-- Run CattleLotInsert
DROP TEMPORARY TABLE IF EXISTS SheepUpdate;
-- Cattle Temporary Table
CREATE TEMPORARY TABLE SheepUpdate
(
	lotNumber smallint primary key,
    buyer smallint null,
    sellingPricePerHead decimal(5,2) null,
    passedIn bit(1) default 0
);


load data infile 'C:\\BCDE214Insert\\S1621Sales.csv' 
into table SheepUpdate fields terminated by ',' enclosed by '\\'
lines terminated by '\r\n' ignore 1 lines
(@lotNumber,@buyer, @sellingPricePerHead, @passedIn) -- Same from file column
set lotNumber = @lotNumber, buyer = @buyer, sellingPricePerHead = @sellingPricePerHead, passedIn = @passedIn;


-- Create Stored Procedure
DELIMITER //
CREATE PROCEDURE UpdateSheepInfo()
BEGIN
SET FOREIGN_KEY_CHECKS=0;
UPDATE sheeplot sl, SheepUpdate su
SET sl.sellingPricePerHead = su.sellingPricePerHead, 
sl.passedIn = su.passedIn, sl.buyer = su.buyer
where su.lotNumber = sl.lotNumber AND sl.auctionId = 'S1621';
SET FOREIGN_KEY_CHECKS=1;
END //

-- Test
CALL UpdateSheepInfo();

-- Test
select * from sheeplot;
