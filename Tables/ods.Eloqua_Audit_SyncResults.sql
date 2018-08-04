CREATE TABLE [ods].[Eloqua_Audit_SyncResults]
(
[SyncUri] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Logs_totalResults] [int] NULL,
[Logs_limit] [int] NULL,
[Logs_offset] [int] NULL,
[Logs_count] [int] NULL,
[Logs_hasMore] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__Eloqua_Au__ETL_C__2F9AA5BE] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__Eloqua_Au__ETL_C__308EC9F7] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__Eloqua_Au__ETL_U__3182EE30] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__Eloqua_Au__ETL_U__32771269] DEFAULT (suser_sname())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_Eloqua_Audit_SyncResultsUpdate] ON [ods].[Eloqua_Audit_SyncResults]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[Eloqua_Audit_SyncResults] t
	JOIN inserted i ON  t.[SyncUri] = i.[SyncUri]

INSERT INTO [ods].[Snapshot_Eloqua_Audit_SyncResults] ([SyncUri],[Logs_totalResults],[Logs_limit],[Logs_offset],[Logs_count],[Logs_hasMore],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate])
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END
GO
ALTER TABLE [ods].[Eloqua_Audit_SyncResults] ADD CONSTRAINT [PK__Eloqua_A__D47187FDC90AD0A8] PRIMARY KEY CLUSTERED  ([SyncUri])
GO
