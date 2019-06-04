## List of databases
srvctl config database
## New oratab, list databases with ORACLE_HOME
srvctl config database -v

srvctl stop|start|status database -d <db_name>
srvctl stop|start|status instance -d <db_name> -i <oracle_sid>

srvctl config database -d <db_name>

-- lista services de la bbdd
srvctl config service -d <db_name>
