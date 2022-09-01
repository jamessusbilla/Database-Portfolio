-- CREATING ROLES
CREATE ROLE 'AppClientLoader';
CREATE ROLE 'AppAuctionDayDataEntry';
CREATE ROLE 'AppReporter';

-- GRANTING PERMISSIONS ON ROLES

-- User Rights Grants => AppClientLoader
GRANT SELECT, INSERT, UPDATE ON stockauction.auctionclientatauction TO 'AppClientLoader';
GRANT SELECT, INSERT, UPDATE ON stockauction.auctionclient TO 'AppClientLoader';

-- User Rights Grants => AppAuctionDayDataEntry
GRANT SELECT, UPDATE ON stockauction.sheeplot TO 'AppAuctionDayDataEntry';
GRANT SELECT, UPDATE ON stockauction.cattlelot TO 'AppAuctionDayDataEntry';

-- User Rights Grants => AppReporter
GRANT SELECT ON stockauction.auctionclient TO 'AppReporter';
GRANT SELECT ON stockauction.auctionclientatauction TO 'AppReporter';
GRANT SELECT ON stockauction.auctionday TO 'AppReporter';
GRANT SELECT ON stockauction.cattleauction TO 'AppReporter';
GRANT SELECT ON stockauction.cattlelot TO 'AppReporter';
GRANT SELECT ON stockauction.clientattendance TO 'AppReporter';
GRANT SELECT ON stockauction.sheepauction TO 'AppReporter';
GRANT SELECT ON stockauction.sheeplot TO 'AppReporter';
GRANT SELECT ON stockauction.stockagency TO 'AppReporter';
GRANT SELECT ON stockauction.stockagent TO 'AppReporter';

-- CREATE NEW USERS
CREATE USER 'AppClientLoader'@'localhost' IDENTIFIED BY 'AppClientLoader';
CREATE USER 'AppAuctionDayDataEntry'@'localhost' IDENTIFIED BY 'AppAuctionDayDataEntry';
CREATE USER 'AppReporter'@'localhost' IDENTIFIED BY 'AppReporter';

-- GRANT USERS A ROLE
GRANT 'AppClientLoader' TO 'AppClientLoader'@'localhost';
GRANT 'AppAuctionDayDataEntry' TO 'AppAuctionDayDataEntry'@'localhost';
GRANT 'AppReporter' TO 'AppReporter'@'localhost';

-- TO MAKE ROLES ALL ACTIVE
SET DEFAULT ROLE ALL TO 'AppClientLoader'@'localhost', 'AppAuctionDayDataEntry'@'localhost','AppReporter'@'localhost';