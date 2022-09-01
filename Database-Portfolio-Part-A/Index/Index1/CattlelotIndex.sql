use stockauction;

-- Index
CREATE INDEX IDX_AgentCattleLot on Cattlelot(agent,seller, auctionId);



-- Rebuilding Index
ALTER TABLE cattlelot drop index IDX_AgentCattleLot;
ALTER TABLE cattlelot ADD INDEX IDX_AgentCattleLot(agent, seller, auctionId);



-- Test
-- Query
select agent,seller, sum(lotSellingPrice) from cattlelot
group by agent, seller
having sum(lotSellingPrice) > '500000';