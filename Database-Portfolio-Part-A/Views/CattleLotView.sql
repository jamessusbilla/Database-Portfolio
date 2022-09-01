use stockauction;
CREATE OR REPLACE VIEW VCattleLot AS
SELECT L5.auctionID, L5.lotNumber, L5.Buyer, acseller.fullName AS Seller, L5.AgentName, L5.AuctioneerName, L5.breed, L5.quantity, L5.lotSellingPrice, L5.passedIn FROM 
(SELECT L4.auctionId, L4.lotNumber, L4.bclientID, L4.sclientID, L4.AgentName, L4.AuctioneerName, L4.breed, L4.quantity, L4.lotSellingPrice, L4.passedIn, acbuyer.fullName AS Buyer FROM
(SELECT L3.auctionId, L3.lotNumber, L3.seller, L3.buyer, L3.AgentName, L3.AuctioneerName, L3.breed, L3.quantity, L3.lotSellingPrice, L3.passedIn, L3.bclientID, acs.clientID as sclientID FROM
(SELECT L2.auctionDay, L2.auctionId, L2.lotNumber, L2.seller, L2.buyer, L2.AgentName, L2.AuctioneerName, L2.breed, L2.quantity, L2.lotSellingPrice, L2.passedIn, aca.clientID as bclientID FROM
(SELECT L1.auctionDay, L1.auctionId, L1.lotNumber, L1.seller, L1.buyer, L1.AgentName, sau.fullName as AuctioneerName,
		L1.breed, L1.quantity, L1.lotSellingPrice, L1.passedIn FROM 
		(select cl.auctionDay, cl.auctionId, cl.lotNumber, cl.seller,
			cl.buyer, cl.breed, cl.quantity, cl.agent, sag.fullName as AgentName,
				cl.auctioneer, cl.lotSellingPrice, cl.passedIn from cattlelot cl
					INNER JOIN stockagent sag on sag.id = cl.agent) AS L1 INNER JOIN stockagent sau on sau.id = L1.auctioneer) AS L2
                    INNER JOIN auctionclientatauction as aca ON ( aca.clientNumber = L2.buyer AND aca.auctionId = L2.auctionDay)) AS L3
                    INNER JOIN auctionclientatauction as acs ON ( acs.clientNumber = L3.seller AND acs.auctionId = L3.auctionDay)) AS L4
                    INNER JOIN auctionclient as acbuyer ON acbuyer.id = L4.bclientID) AS L5
                    INNER JOIN auctionclient as acseller ON acseller.id = L5.sclientID WHERE L5.lotSellingPrice is not null;
                    
                    
                    
-- Testing 
use stockauction;

-- selecting data
select auctionId, lotNumber, Buyer, Seller, AgentName, AuctioneerName, breed, quantity, lotSellingPrice, passedIn from VCattleLot;


-- Inserting Data
INSERT INTO `stockauction`.`cattlelot` (`auctionId`, `lotNumber`, `auctionDay`, `seller`, `agent`, `breed`, `sex`, `age`, `quantity`, `averageWeight`, `reserve`, `auctioneer`) 
VALUES ('C1621', '247', '1621', '74', 'F_Dav', 'Angus', 'B', '2', '12', '1.34', '0.00', 'F_Don');


-- Updating Data
update cattlelot
set buyer = 78, sellingpriceperkg = '4.56', passedIn = default
where auctionID = 'C1621' and lotnumber = 247;


-- Checking if data exists
select auctionId, lotNumber, Buyer, Seller, AgentName, AuctioneerName, breed, quantity, lotSellingPrice, passedIn from VCattleLot
where auctionId = 'C1621' and lotnumber = 247;