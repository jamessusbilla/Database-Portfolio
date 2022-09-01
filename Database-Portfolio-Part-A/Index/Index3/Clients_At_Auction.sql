use stockauction;

-- Creating index
CREATE INDEX IDX_auctionclientatauction using hash ON auctionclientatauction(clientId, clientNumber);



-- Rebuilding index
ALTER TABLE auctionclientatauction drop index IDX_auctionclientatauction;
ALTER TABLE auctionclientatauction ADD INDEX IDX_auctionclientatauction(clientId, clientNumber) using hash;



-- Test
-- Query
select acaa.clientId, acaa.clientNumber
from auctionclientatauction acaa
where clientNumber between 70 and 80
group by acaa.clientId, acaa.clientNumber;