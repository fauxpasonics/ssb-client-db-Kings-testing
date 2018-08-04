CREATE TABLE [ods].[Eloqua_Audit_RejectResults]
(
[SyncUri] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Rejects_totalResults] [int] NULL,
[Rejects_limit] [int] NULL,
[Rejects_offset] [int] NULL,
[Rejects_count] [int] NULL,
[Rejects_hasMore] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__Eloqua_Au__ETL_C__26113B84] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__Eloqua_Au__ETL_C__27055FBD] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__Eloqua_Au__ETL_U__27F983F6] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__Eloqua_Au__ETL_U__28EDA82F] DEFAULT (suser_sname())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_Eloqua_Audit_RejectResultsUpdate] ON [ods].[Eloqua_Audit_RejectResults]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[Eloqua_Audit_RejectResults] t
	JOIN inserted i ON  t.[SyncUri] = i.[SyncUri]

INSERT INTO [ods].[Snapshot_Eloqua_Audit_RejectResults] ([SyncUri],[Rejects_totalResults],[Rejects_limit],[Rejects_offset],[Rejects_count],[Rejects_hasMore],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate])
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END
GO
ALTER TABLE [ods].[Eloqua_Audit_RejectResults] ADD CONSTRAINT [PK__Eloqua_A__D47187FD426F12D7] PRIMARY KEY CLUSTERED  ([SyncUri])
GO
