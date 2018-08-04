CREATE TABLE [ods].[Snapshot_Eloqua_Audit_SyncResults]
(
[Eloqua_Audit_SyncResultsSK] [int] NOT NULL IDENTITY(1, 1),
[SyncUri] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Logs_totalResults] [int] NULL,
[Logs_limit] [int] NULL,
[Logs_offset] [int] NULL,
[Logs_count] [int] NULL,
[Logs_hasMore] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_Eloqua_Audit_SyncResults] ADD CONSTRAINT [PK__Snapshot__3EB0EDE489033B31] PRIMARY KEY CLUSTERED  ([Eloqua_Audit_SyncResultsSK])
GO
