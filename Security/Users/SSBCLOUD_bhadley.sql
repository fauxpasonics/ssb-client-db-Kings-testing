IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'SSBCLOUD\bhadley')
CREATE LOGIN [SSBCLOUD\bhadley] FROM WINDOWS
GO
CREATE USER [SSBCLOUD\bhadley] FOR LOGIN [SSBCLOUD\bhadley] WITH DEFAULT_SCHEMA=[SSBCLOUD\bhadley]
GO
REVOKE CONNECT TO [SSBCLOUD\bhadley]