$mysqlpath = "C:\Program Files\MySQL\MySQL Server 8.0\bin"
$backuppath = "C:\DatabaseBackup\"
$username = "root"
$password = "Root1234#" <# Not the Original Password #>
$database = "stockauction"
$Account = "C:\DatabaseBackup\1\FullBackup\UserPasswordConfig\config.cnf"

$date = Get-Date
$timestamp = "" + $date.day + $date.month + $date.year + "_" + $date.hour + $date.minute

$backupfile = $backuppath + $database + "_" + $timestamp +".sql"
$zipfile = $timestamp + ".zip"

cd $mysqlpath
.\mysqldump.exe --user=$username --password=$password --routines --result-file=$backupfile --databases $database

Compress-Archive -Path $backupfile -DestinationPath C:\DatabaseBackup\$zipfile
Remove-Item $backupfile