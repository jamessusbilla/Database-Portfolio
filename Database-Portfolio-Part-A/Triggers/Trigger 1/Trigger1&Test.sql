use stockauction;

-- run the VTotal View script in the attached file

-- Adding columns to the auctionclientatauction entity
alter table auctionclientatauction
add column totalValue int,
add column soldValue int;

-- Adding new columns to auctionclient entity
alter table auctionclient
add column total int;

-- creating a trigger in cattlelot which will update the attributes of auctionclientatauction, that is totalValue & soldValue
DELIMITER $$
CREATE TRIGGER cattlelot_au
AFTER UPDATE ON cattlelot
FOR EACH ROW
BEGIN
	IF OLD.lotSellingPrice != NEW.lotSellingPrice then
        UPDATE auctionclientatauction acaa
			INNER JOIN auctionclient ac on ac.id = acaa.clientId
			SET acaa.totalValue = (select sum(ifnull(Purchases,0)) Purchases from VTotal where BuyerID = New.buyer group by BuyerID), ac.total = acaa.totalValue
		WHERE (acaa.auctionId = New.auctionday AND acaa.clientNumber = New.buyer);
            
        UPDATE auctionclientatauction acas
			set soldValue = (select sum(ifnull(Sold,0)) Sold from VTotal where SellerID = New.seller group by SellerID)
			WHERE(acas.auctionId = OLD.auctionday AND acas.clientNumber = OLD.seller);
	END IF;
END$$

-- creating a trigger in sheeplot which will update the attributes of auctionclientatauction, that is totalValue & soldValue
DELIMITER $$
CREATE TRIGGER sheeplot_au
AFTER UPDATE ON sheeplot
FOR EACH ROW
BEGIN
	IF OLD.lotSellingPrice != NEW.lotSellingPrice then
        UPDATE auctionclientatauction acaa
			INNER JOIN auctionclient ac on ac.id = acaa.clientId
			SET acaa.totalValue = (select sum(ifnull(Purchases,0)) Purchases from VTotal where BuyerID = New.buyer group by BuyerID), ac.total = acaa.totalValue
		WHERE (acaa.auctionId = New.auctionday AND acaa.clientNumber = New.buyer);
            
        UPDATE auctionclientatauction acas
			set soldValue = (select sum(ifnull(Sold,0)) Sold from VTotal where SellerID = New.seller group by SellerID)
			WHERE(acas.auctionId = OLD.auctionday AND acas.clientNumber = OLD.seller);
	END IF;
END$$


-- Testing

-- Mass Updates
-- Configure(input new auction id) & Run the stored procedures from the Stored_Procedure_03 to do bulk insert
-- First Run both scripts in Stored Procedure #4, then call the stored procedure, i.e below.
-- Updating Sheep & Cattle
CALL UpdateSheepInfo();
CALL UpdateCattleInfo();


-- Updating a single record in cattlelot
-- Insert Data
insert into cattlelot(auctionId,lotNumber,auctionDay,seller,agent,breed,sex,age,quantity,reserve,auctioneer) 
values('C1620', '265', '1620', '41', 'F_Don', 'Angus X', 'S', '3', '17', '0.00', 'F_Don');

-- Update Data
update cattlelot
set averageWeight = '100.90', sellingPricePerKg = '8.9', buyer = 78
where auctionId = 'C1620' and lotNumber = '265'

-- Updating a single record in sheeplot
update sheeplot
set sellingPricePerHead = '8.9', buyer = 78
where auctionId = 'S1621' and lotNumber = '368'


-- View the auctionclientatauction table totalvalue of buyers and soldValue of sellers
select * from auctionclientatauction;

-- View the auctionclient total
select * from auctionclient
