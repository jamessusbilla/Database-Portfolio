use stockauction;

DELIMITER //
CREATE PROCEDURE Auctions(in codingNum char(5), in auctionDay date, OUT entrypnt CHAR(5), OUT ID SMALLINT, OUT AUCTDAY DATE, OUT RESULT VARCHAR(10))
BEGIN
select l2.Code, l2.auctionId, l2.startTime, l2.auctionDay, 
CASE WHEN substring(l2.Code,1,1) = 'S' THEN 'Sheep' 
	 WHEN substring(l2.Code,1,1) = 'C' THEN 'Cattle'
	 END AS WhatAuctions_isthere
from
(select l1.id as Code, l1.auctionId, l1.startTime, ad.id, ad.auctionDay from
(select ca.id, ca.auctionId, ca.startTime from cattleauction ca
union all
select sa.id, sa.auctionId, sa.startTime from sheepauction sa) l1, auctionday ad where ad.id = l1.auctionId) l2
where l2.auctionId = codingNum and l2.auctionDay = auctionDay;
END //

-- Testing
-- when there is 2 results
CALL Auctions('1620', '2019-08-10',@CODING,@ID,@STARTTIME,@AUCTIONDAY);

-- when there is one result
CALL Auctions('1621', '2018-08-02',@CODING,@ID,@STARTTIME,@AUCTIONDAY);

-- When No result
CALL Auctions('1622', '2019-08-10',@CODING,@ID,@STARTTIME,@AUCTIONDAY);