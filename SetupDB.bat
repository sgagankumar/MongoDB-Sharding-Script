TIMEOUT 3 >nul
mongo --host localhost --port 47019
TIMEOUT 3 >nul
use admin
TIMEOUT 3 >nul
db.runCommand( { addshard : "localhost:37017" } );
TIMEOUT 3 >nul
db.runCommand( { addshard : "localhost:37018" } );
TIMEOUT 3 >nul
db.runCommand( { addshard : "localhost:37019" } );
ECHO Do you want to create a sample test shard server? (y/n)
SET /P _option= ">"
IF "%_option%"=="y" GOTO:RUN
IF "%_option%"=="Y" GOTO:RUN
IF "%_option%"=="yes" GOTO:RUN
IF "%_option%"=="Yes" GOTO:RUN
ECHO Setup Completed!!
TIMEOUT 3 >nul
PAUSE
TIMEOUT 3 >nul
:RUN
TIMEOUT 3 >nul
db.runCommand({enableSharding: "zovia"})
TIMEOUT 3 >nul
use zovia
TIMEOUT 3 >nul
db.createCollection('Items')
TIMEOUT 3 >nul
db.Items.ensureIndex({ItemID: "hashed"})
TIMEOUT 3 >nul
sh.shardCollection("zovia.Items", {"ItemID": "hashed"})
TIMEOUT 3 >nul
for(var i=1; i<200; i++){ db.Items.insert({ItemID: i})}
TIMEOUT 3 >nul
db.Items.count()
TIMEOUT 3 >nul
db.Items.getShardDistribution()
