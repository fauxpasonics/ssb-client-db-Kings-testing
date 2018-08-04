CREATE TABLE [ods].[Snapshot_Eloqua_Audit_RejectItems]
(
[Eloqua_Audit_RejectItemsSK] [int] NOT NULL IDENTITY(1, 1),
[SyncUri] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Logs_items_syncUri] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Logs_items_count] [int] NULL,
[Logs_items_severity] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Logs_items_statusCode] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Logs_items_message] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Logs_items_createdAt] [datetime] NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_Eloqua_Audit_RejectItems] ADD CONSTRAINT [PK__Snapshot__88E67898BDFBC276] PRIMARY KEY CLUSTERED  ([Eloqua_Audit_RejectItemsSK])
GO
