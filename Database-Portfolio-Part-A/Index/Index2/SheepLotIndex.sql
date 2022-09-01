use stockauction;

-- Index
CREATE INDEX IDX_AgentSheepLot on Sheeplot(agent,seller, auctionId);



-- Rebuilding Index
ALTER TABLE sheeplot drop index IDX_AgentSheepLot;
ALTER TABLE sheeplot ADD INDEX IDX_AgentSheepLot(agent, seller, auctionId);


-- Test
-- Query
select agent,seller, sum(lotSellingPrice) from sheeplot
group by agent, seller
having sum(lotSellingPrice) > '50000';