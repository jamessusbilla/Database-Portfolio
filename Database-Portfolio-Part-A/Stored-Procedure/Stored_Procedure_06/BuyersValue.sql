use stockauction;

-- Buyer
DROP PROCEDURE IF EXIST BUYERVALUE
DELIMITER $$
CREATE PROCEDURE BUYERVALUE(IN CLIENTNUM SMALLINT, OUT PURCHASES INT)
BEGIN
SELECT sum(l2.lotSellingPrice) AS BuyersValue FROM
(select acaa.auctionId, acaa.clientNumber, l1.lotNumber, l1.lotSellingPrice, acaa.clientID from
(select cl.auctionDay, cl.buyer, cl.lotNumber, cl.lotSellingPrice from cattlelot cl
union distinct
select sl.auctionDay, sl.buyer, sl.lotNumber, sl.lotSellingPrice from sheeplot sl) 
l1, auctionclientatauction acaa where (acaa.auctionId = l1.auctionDay and acaa.clientNumber = l1.buyer)) l2
where l2.clientNumber = CLIENTNUM and l2.lotSellingPrice is not null;
END $$

-- TESTING
CALL BUYERVALUE(61, @TOTALPURCHASES);