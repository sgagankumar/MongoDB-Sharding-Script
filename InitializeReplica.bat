TIMEOUT 3 >nul
mongo --port 57040
TIMEOUT 3 >nul
rs.initiate();
TIMEOUT 3 >nul
rs.add("localhost:57041")
TIMEOUT 3 >nul
rs.add("localhost:57042")
TIMEOUT 3 >nul
start cmd.exe /k "mongos -logpath ^"mongos-1.log^" -configdb cs/localhost:57040 --port 47019"
TIMEOUT 3 >nul
start cmd.exe /k "SetupDB.bat"
