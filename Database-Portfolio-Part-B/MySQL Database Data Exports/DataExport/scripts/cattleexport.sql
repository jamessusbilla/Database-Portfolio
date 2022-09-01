use stockauction;
select 'auction ID', 'lot', 'Buyer', 'Seller', 'Agent', 'Auctioneer', 'Breed', 'Quantity', 'Selling Price', 'Seller Auction ID', 'Buyer Auction ID', 'PassedIn', 'Buyer Auction Date', 'Seller Auction Date', 'Buyer Auction Time', 'Seller Auction Time'
union all
SELECT L5.auctionID, L5.lotNumber, L5.Buyer, acseller.fullName AS Seller, 
L5.AgentName, L5.AuctioneerName, L5.breed, L5.quantity, L5.lotSellingPrice, 
L5.sellerauctionId, L5.buyerauctionId, L5.passedIn,  adb.auctionDay buyerauctiondate, ads.auctionDay sellerauctiondate, cab.startTime buyerauctiontime, cas.startTime sellerauctiontime FROM 
(SELECT L4.auctionId, L4.lotNumber, L4.bclientID, L4.sclientID, L4.AgentName, L4.AuctioneerName, L4.breed, L4.quantity, L4.lotSellingPrice, L4.passedIn, acbuyer.fullName AS Buyer, L4.sellerauctionId, L4.buyerauctionId FROM
(SELECT L3.auctionId, L3.lotNumber, L3.seller, L3.buyer, L3.AgentName, L3.AuctioneerName, L3.breed, L3.quantity, L3.lotSellingPrice, L3.passedIn, L3.bclientID, acs.clientID as sclientID, acs.auctionId as sellerauctionId, L3.buyerauctionId FROM
(SELECT L2.auctionDay, L2.auctionId, L2.lotNumber, L2.seller, L2.buyer, L2.AgentName, L2.AuctioneerName, L2.breed, L2.quantity, L2.lotSellingPrice, L2.passedIn, aca.clientID as bclientID, aca.auctionId as buyerauctionId FROM
(SELECT L1.auctionDay, L1.auctionId, L1.lotNumber, L1.seller, L1.buyer, L1.AgentName, sau.fullName as AuctioneerName,
L1.breed, L1.quantity, L1.lotSellingPrice, L1.passedIn FROM 
(select cl.auctionDay, cl.auctionId, cl.lotNumber, cl.seller,
cl.buyer, cl.breed, cl.quantity, cl.agent, sag.fullName as AgentName,
cl.auctioneer, cl.lotSellingPrice, cl.passedIn from cattlelot cl
INNER JOIN stockagent sag on sag.id = cl.agent) AS L1 INNER JOIN stockagent sau on sau.id = L1.auctioneer) AS L2
inner JOIN auctionclientatauction as aca ON ( aca.clientNumber = L2.buyer AND aca.auctionId = L2.auctionDay)) AS L3
INNER JOIN auctionclientatauction as acs ON ( acs.clientNumber = L3.seller AND acs.auctionId = L3.auctionDay)) AS L4
inner JOIN auctionclient as acbuyer ON acbuyer.id = L4.bclientID) AS L5
INNER JOIN auctionclient as acseller ON acseller.id = L5.sclientID 
inner JOIN auctionday as adb on adb.id = L5.buyerauctionId
INNER JOIN auctionday as ads on ads.id = L5.sellerauctionId
inner join cattleauction as cab on cab.auctionId = L5.buyerauctionId
inner join cattleauction as cas on cas.auctionId = L5.sellerauctionId
where L5.lotSellingPrice is not null
INTO OUTFILE 'C:/DatabaseBackup/cattles.csv' 
FIELDS ENCLOSED BY '' 
TERMINATED BY ',' 
ESCAPED BY '"' 
LINES TERMINATED BY '\r\n';