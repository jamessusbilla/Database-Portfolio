use stockauction;

DROP temporary TABLE IF EXISTS Clients;
-- Clients Temporary Table
CREATE TEMPORARY TABLE Clients
(
	auctionId smallint,
    clientNumber smallint,
    clientID char(10),
    PRIMARY KEY(auctionId, clientNumber)
);


load data infile 'C:\\BCDE214Insert\\1621Clients.csv' 
into table Clients fields terminated by ','
lines terminated by '\n' ignore 1 lines
(@ID, @ClientNumber)
set auctionId = '1625', clientNumber = @ClientNumber, clientID = @ID;

DELIMITER //
CREATE PROCEDURE InsertNewClients(IN aID smallint, in aDay date)
BEGIN
insert into auctionday(id, auctionday) values(aID, aDay);
insert into auctionclientatauction(auctionId, clientNumber, clientID)
select * from Clients;
END //


-- Test
Call InsertNewClients('1621','2018-08-02')