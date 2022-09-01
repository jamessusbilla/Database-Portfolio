use stockauction;
select 'Auction ID', 'Client ID', 'Client Name', 'Address 1', 'Address 2', 'Address 3', 'Province', 'Contact Person', 'Phone', 'Phone 2', 'Email', 'Preferred Number', 'Total Value', 'Attendance'
union all
select acaa.auctionId, ac.id, ac.fullName, ac.address1, ac.address2,ac.address3, ac.province, ac.contactPerson,
ac.phone, ac.phone2, ac.email, ac.preferredNumber, ac.total, ac.attendance from auctionclientatauction acaa inner join auctionclient ac on ac.id = acaa.clientID
INTO OUTFILE 'C:/DatabaseBackup/clients.csv' 
FIELDS ENCLOSED BY '' 
TERMINATED BY ',' 
ESCAPED BY '"' 
LINES TERMINATED BY '\r\n';
