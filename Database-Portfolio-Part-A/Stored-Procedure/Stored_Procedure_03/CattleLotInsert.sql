use stockauction;

drop temporary table IF EXISTS cattle;
-- Clients Temporary Table
CREATE TEMPORARY TABLE Cattle
(
	auctionId char(5),
	lotNumber smallint,
    auctionDay smallint,
    seller smallint,
    agent char(10),
    breed char(20),
    sex char(1),
    age tinyint,
    quantity tinyint,
    averageWeight decimal(6,2),
    reserve decimal(5,2),
    auctioneer char(10),
    buyer smallint,
    sellingPricePerKg decimal(5,2),
    passedIn bit(1) null,
    PRIMARY KEY(auctionId, lotNumber)
);

-- Load Data
set @auctionID = 'C1621';
load data infile 'C:\\BCDE214Insert\\C1621.csv' 
into table Cattle fields terminated by ','
lines terminated by '\n' ignore 1 lines
(@lotNumber, @seller, @agent, @auctioneer, @breed, @sex, @age, @quantity, @averageWeight, @reserve, @buyer, @sellingPricePerkg, @passedIn) -- Same from file column
set auctionId = @auctionID, lotNumber = @lotNumber, auctionDay = substring(@auctionID,2,4), seller = @seller, 
agent = @agent, auctioneer = @auctioneer, breed = @breed, sex = @sex, age = @age, quantity = @quantity, averageweight = @averageWeight, 
reserve = @reserve, buyer = null, sellingPricePerKg = @sellingPricePerkg, passedIn = null;


DELIMITER //
CREATE PROCEDURE SALESPROC(in ID char(5), in auctionID smallint, in startTime time)
BEGIN
INSERT INTO cattleauction(id, auctionId, startTime) Values(ID, auctionID, startTime);
INSERT INTO cattlelot(auctionId, lotNumber, auctionDay, seller, agent, 
						breed, sex, age, quantity, averageweight, reserve, 
							auctioneer, buyer, sellingPricePerKg, passedIn)
select * from cattle;
END //
set foreign_key_checks = 0;

-- Test
Call SALESPROC(@auctionID, substring(@auctionID,2,4), '11:00:00');

select * from cattlelot


