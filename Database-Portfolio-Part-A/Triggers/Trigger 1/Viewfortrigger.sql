use stockauction;
CREATE OR REPLACE VIEW VTotal AS 
select l2.buy, l2.BuyerID, l2.Purchases, l2.sell, l2.SellerID, l2.Sold, l2.BuyerAuctionID, acas.clientID as SellerAuctionID from
(select l1.buy, l1.BuyerID, sum(l1.buyersValue) as Purchases, l1.sell, l1.SellerID, sum(l1.sellersValue) as Sold, acaa.clientID as BuyerAuctionID from
(select clb.auctionDay buy, clb.buyer BuyerID, clb.lotsellingprice buyersValue, cls.auctionDay sell, 
cls.seller SellerID, cls.lotSellingPrice sellersValue from cattlelot clb 
inner join cattlelot cls on (clb.auctionId = cls.auctionId AND clb.lotNumber = cls.lotNumber)
union all
select slb.auctionDay, slb.buyer, slb.lotsellingprice, sls.auctionDay,sls.seller, sls.lotSellingPrice from sheeplot slb 
inner join sheeplot sls on (slb.auctionId = sls.auctionId AND slb.lotNumber = sls.lotNumber)) l1, auctionclientatauction acaa
where (acaa.auctionId = l1.buy and acaa.clientNumber = l1.BuyerID) group by l1.buy, l1.sell, l1.BuyerID, l1.SellerID, l1.buyersValue, l1.sellersValue) l2,
auctionclientatauction acas where (acas.auctionId = l2.sell AND acas.clientNumber = l2.SellerID)
group by l2.buy, l2.sell, l2.BuyerID, l2.SellerID, l2.Purchases, l2.Sold;


















