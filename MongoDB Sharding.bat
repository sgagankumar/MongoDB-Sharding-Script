@ECHO OFF
TIMEOUT 1 >nul
cls
ECHO.
ECHO 			MongoDB Sharding
ECHO.
TIMEOUT 1 >nul
ECHO.
ECHO Do you want to create a 3 replica set shard server? (y/n)
SET /P _option= ">"
IF "%_option%"=="y" GOTO:RUN
IF "%_option%"=="Y" GOTO:RUN
IF "%_option%"=="yes" GOTO:RUN
IF "%_option%"=="Yes" GOTO:RUN
ECHO Script Terminated.
TIMEOUT 3 >nul
PAUSE
:RUN
mkdir data
cd data
mkdir configure
mkdir shardServer
cd configure
mkdir configure-a
mkdir configure-b
mkdir configure-c
cd ..
cd shardServer
mkdir replicaSet0
mkdir replicaSet1
mkdir replicaSet2
cd ..
start cmd.exe /c "mongod --logpath ^"set-r0.log^" --dbpath /data/shardServer/replicaSet0 --port 37017 --shardsvr"
TIMEOUT 3 >nul
start cmd.exe /c "mongod --logpath ^"set-r1.log^" --dbpath /data/shardServer/replicaSet1 --port 37018 --shardsvr"
TIMEOUT 3 >nul
start cmd.exe /c "mongod --logpath ^"set-r2.log^" --dbpath /data/shardServer/replicaSet2 --port 37019 --shardsvr"
TIMEOUT 3 >nul
start cmd.exe /c "mongod --replSet cs --logpath ^"cfg-a.log^" --dbpath /data/configure/configure-a --port 57040 --configsvr"
TIMEOUT 3 >nul
start cmd.exe /c "mongod --replSet cs --logpath ^"cfg-b.log^" --dbpath /data/configure/configure-b --port 57041 --configsvr"
TIMEOUT 3 >nul
start cmd.exe /c "mongod --replSet cs --logpath ^"cfg-c.log^" --dbpath /data/configure/configure-c --port 57042 --configsvr"
TIMEOUT 3 >nul
cd ..
move "InitializeReplica.bat" "data\InitializeReplica.bat"
move "SetupDB.bat" "data\SetupDB.bat"
cd data
start cmd.exe /k "InitializeReplica.bat"
TIMEOUT 3 >nul
PAUSE