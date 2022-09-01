USE stockauction;
-- Seller
DROP PROCEDURE IF EXISTS SELLERVALUE;
DELIMITER $$
CREATE PROCEDURE SELLERVALUE(IN CLIENTNUM SMALLINT, OUT TOTALVALUE INT)
BEGIN
SELECT sum(l2.lotSellingPrice) AS SoldValue FROM
(select acaa.auctionId, acaa.clientNumber, l1.lotNumber, l1.lotSellingPrice, acaa.clientID from
(select cl.auctionDay, cl.seller, cl.lotNumber, cl.lotSellingPrice from cattlelot cl
union distinct
select sl.auctionDay, sl.seller, sl.lotNumber, sl.lotSellingPrice from sheeplot sl) 
l1, auctionclientatauction acaa where (acaa.auctionId = l1.auctionDay and acaa.clientNumber = l1.seller)) l2
where l2.clientNumber = CLIENTNUM and l2.lotSellingPrice is not null;
END $$

-- TESTING
CALL SELLERVALUE(41, @TOTAL);
