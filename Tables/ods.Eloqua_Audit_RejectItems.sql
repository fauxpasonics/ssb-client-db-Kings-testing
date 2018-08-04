CREATE TABLE [ods].[Eloqua_Audit_RejectItems]
(
[SyncUri] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Logs_items_syncUri] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Logs_items_count] [int] NULL,
[Logs_items_severity] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Logs_items_statusCode] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Logs_items_message] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Logs_items_createdAt] [datetime] NULL,
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__Eloqua_Au__ETL_C__1C87D14A] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__Eloqua_Au__ETL_C__1D7BF583] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__Eloqua_Au__ETL_U__1E7019BC] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__Eloqua_Au__ETL_U__1F643DF5] DEFAULT (suser_sname())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_Eloqua_Audit_RejectItemsUpdate] ON [ods].[Eloqua_Audit_RejectItems]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[Eloqua_Audit_RejectItems] t
	JOIN inserted i ON  t.[SyncUri] = i.[SyncUri] AND t.[Logs_items_statusCode] = i.[Logs_items_statusCode] AND t.[Logs_items_message] = i.[Logs_items_message]

INSERT INTO [ods].[Snapshot_Eloqua_Audit_RejectItems] ([SyncUri],[Logs_items_syncUri],[Logs_items_count],[Logs_items_severity],[Logs_items_statusCode],[Logs_items_message],[Logs_items_createdAt],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate])
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END
GO
ALTER TABLE [ods].[Eloqua_Audit_RejectItems] ADD CONSTRAINT [PK__Eloqua_A__CE281B2443654E64] PRIMARY KEY CLUSTERED  ([SyncUri], [Logs_items_statusCode], [Logs_items_message])
GO
