use stockauction;
-- User Creation
CREATE USER 'AuctionCreator'@'localhost' IDENTIFIED BY 'AuctionCreator';
CREATE USER 'ClientLoader'@'localhost' IDENTIFIED BY 'ClientLoader';
CREATE USER 'StockLoader'@'localhost' IDENTIFIED BY 'StockLoader';
CREATE USER 'AuctionDayDataEntry'@'localhost' IDENTIFIED BY 'AuctionDayDataEntry';
CREATE USER 'AuctionDaySupervisor'@'localhost' IDENTIFIED BY 'AuctionDaySupervisor';
CREATE USER 'SaleDayAdmin'@'localhost' IDENTIFIED BY 'SaleDayAdmin';
CREATE USER 'Reporter'@'localhost' IDENTIFIED BY 'Reporter';
CREATE USER 'DailyReporter'@'localhost' IDENTIFIED BY 'DailyReporter';

-- User Rights Grants => AuctionCreator
GRANT SELECT, INSERT, UPDATE ON stockauction.auctionDay TO 'AuctionCreator'@'localhost';
GRANT SELECT, INSERT, UPDATE ON stockauction.cattleauction TO 'AuctionCreator'@'localhost';
GRANT SELECT, INSERT, UPDATE ON stockauction.sheepauction TO 'AuctionCreator'@'localhost';

-- User Rights Grants => ClientLoader
GRANT SELECT, INSERT, UPDATE ON stockauction.auctionclientatauction TO 'ClientLoader'@'localhost';
GRANT SELECT, INSERT, UPDATE ON stockauction.auctionclient TO 'ClientLoader'@'localhost';

-- User Rights Grants => StockLoader
GRANT SELECT, INSERT, UPDATE ON stockauction.sheeplot TO 'StockLoader'@'localhost';
GRANT SELECT, INSERT, UPDATE ON stockauction.cattlelot TO 'StockLoader'@'localhost';

-- User Rights Grants => AuctionDayDataEntry
GRANT SELECT, UPDATE ON stockauction.sheeplot TO 'AuctionDayDataEntry'@'localhost';
GRANT SELECT, UPDATE ON stockauction.cattlelot TO 'AuctionDayDataEntry'@'localhost';

-- User Rights Grants => AuctionDaySupervisor
GRANT SELECT, INSERT, UPDATE ON stockauction.auctionclientatauction TO 'AuctionDaySupervisor'@'localhost';
GRANT SELECT, INSERT, UPDATE ON stockauction.auctionclient TO 'AuctionDaySupervisor'@'localhost';

GRANT SELECT, INSERT, UPDATE ON stockauction.sheeplot TO 'AuctionDaySupervisor'@'localhost';
GRANT SELECT, INSERT, UPDATE ON stockauction.cattlelot TO 'AuctionDaySupervisor'@'localhost';


-- User Rights Grants => SalesDayAdmin
GRANT ALL PRIVILEGEs ON stockauction.* TO 'SaleDayAdmin'@'localhost';

-- User Rights Grants => Reporter
GRANT SELECT ON stockauction.auctionclient TO 'Reporter'@'localhost';
GRANT SELECT ON stockauction.auctionclientatauction TO 'Reporter'@'localhost';
GRANT SELECT ON stockauction.auctionday TO 'Reporter'@'localhost';
GRANT SELECT ON stockauction.cattleauction TO 'Reporter'@'localhost';
GRANT SELECT ON stockauction.cattlelot TO 'Reporter'@'localhost';
GRANT SELECT ON stockauction.clientattendance TO 'Reporter'@'localhost';
GRANT SELECT ON stockauction.sheepauction TO 'Reporter'@'localhost';
GRANT SELECT ON stockauction.sheeplot TO 'Reporter'@'localhost';
GRANT SELECT ON stockauction.stockagency TO 'Reporter'@'localhost';
GRANT SELECT ON stockauction.stockagent TO 'Reporter'@'localhost';


-- User Rights Grants => DailyReporter
GRANT SELECT ON stockauction.vcattlelot TO 'DailyReporter'@'localhost';
GRANT SELECT ON stockauction.vsheeplot TO 'DailyReporter'@'localhost';

flush privileges;
