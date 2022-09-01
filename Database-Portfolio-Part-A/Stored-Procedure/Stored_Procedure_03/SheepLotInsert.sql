use stockauction;

drop temporary table IF EXISTS Sheep;
-- Clients Temporary Table
CREATE TEMPORARY TABLE Sheep
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
    reserve decimal(5,2),
    auctioneer char(10),
    PRIMARY KEY(auctionId, lotNumber)
);

-- Load Data
set @auctionID = 'S1621';
load data infile 'C:\\BCDE214Insert\\S1621.csv' 
into table Sheep fields terminated by ','
lines terminated by '\n' ignore 1 lines
(@lotNumber, @seller, @agent, @auctioneer, @breed, @sex, @age, @quantity, @reserve) -- Same from file column
set auctionId = @auctionID, lotNumber = @lotNumber, auctionDay = substring(@auctionID,2,4), seller = @seller, 
agent = @agent, auctioneer = @auctioneer, breed = @breed, sex = @sex, age = @age, quantity = @quantity, reserve = @reserve;


-- Stored Procedure
DELIMITER //
CREATE PROCEDURE SheepProcedure(in ID char(5), in auctionID smallint, in startTime time)
BEGIN
INSERT INTO sheepauction(id, auctionId, startTime) Values(ID, auctionID, startTime);
INSERT INTO sheeplot(auctionId,lotNumber,auctionDay,seller,agent,breed,sex,age,quantity,reserve,auctioneer)
select * from sheep;
END //

-- Test
Call SheepProcedure(@auctionID, substring(@auctionID,2,4), '11:00:00');

select * from sheeplot