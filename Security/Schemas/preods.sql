CREATE SCHEMA [preods]
AUTHORIZATION [ssbcloud\ssales]
GO
GRANT ALTER ON SCHEMA:: [preods] TO [db_apiETL]
GO
GRANT SELECT ON SCHEMA:: [preods] TO [db_apiETL]
GO
GRANT UPDATE ON SCHEMA:: [preods] TO [db_apiETL]
GO
GRANT VIEW DEFINITION ON SCHEMA:: [preods] TO [db_apiETL]
GO
