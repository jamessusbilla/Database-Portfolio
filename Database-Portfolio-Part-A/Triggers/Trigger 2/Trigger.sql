use stockauction;
-- adding attendance table at auctionclient entity
alter table auctionclient
add column attendance decimal(5,0);

-- Creating trigger in auctionclientatauction for insert data
delimiter $$
create trigger auctionclientatauction_ai 
after insert 
on auctionclientatauction
for each row
begin
update auctionclient ac
set attendance = (select count(auctionId) from auctionclientatauction where clientNumber = New.clientNumber group by clientNumber)
where ac.id = new.clientId;
end $$


-- Creating trigger in auctionclientatauction for delete
delimiter $$
create trigger auctionclientatauction_ad
after delete
on auctionclientatauction
for each row
begin
update auctionclient ac
set attendance = (select count(auctionId) from auctionclientatauction where clientNumber = old.clientNumber group by clientNumber)
where ac.id = old.clientId;
end $$

-- Testing

-- Insert Data
insert into auctionclientatauction(auctionId,clientNumber,clientID) VALUES('1619','156','MAD86');

-- Delete data
set foreign_key_checks = 0;
delete from auctionclientatauction where auctionId = '1619' and clientID = 'MAD86';