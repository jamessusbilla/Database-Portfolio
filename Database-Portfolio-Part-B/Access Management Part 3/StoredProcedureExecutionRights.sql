use stockauction;

-- DailyReporter is given a permission to execute stored procedure where the capability i.e insert, update, delete of stored procedure fits with the user 
GRANT EXECUTE ON procedure stockauction.Auctions TO 'DailyReporter'@'localhost';
GRANT EXECUTE ON procedure stockauction.BUYERVALUE TO 'DailyReporter'@'localhost';
GRANT EXECUTE ON procedure stockauction.SELLERVALUE TO 'DailyReporter'@'localhost';

-- ClientLoader is given a permission to execute a stored procedure where the users permission fits with what the stored procedure should do.
GRANT EXECUTE ON  PROCEDURE stockauction.InsertNewClients TO 'ClientLoader'@'localhost';

-- StockLoader is given a permission to execute some stored procedure on appropriate stored procedures where the user can only load and edit.
GRANT EXECUTE ON PROCEDURE stockauction.UpdateCattleInfo TO 'StockLoader'@'localhost';
GRANT EXECUTE ON PROCEDURE stockauction.UpdateSheepInfo TO 'StockLoader'@'localhost';
GRANT EXECUTE ON PROCEDURE stockauction.SALESPROC TO 'StockLoader'@'localhost';
GRANT EXECUTE ON PROCEDURE stockauction.SheepProcedure TO 'StockLoader'@'localhost';