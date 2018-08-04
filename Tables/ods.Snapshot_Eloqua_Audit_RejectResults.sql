CREATE TABLE [ods].[Snapshot_Eloqua_Audit_RejectResults]
(
[Eloqua_Audit_RejectResultsSK] [int] NOT NULL IDENTITY(1, 1),
[SyncUri] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Rejects_totalResults] [int] NULL,
[Rejects_limit] [int] NULL,
[Rejects_offset] [int] NULL,
[Rejects_count] [int] NULL,
[Rejects_hasMore] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_Eloqua_Audit_RejectResults] ADD CONSTRAINT [PK__Snapshot__010596C41F2B740F] PRIMARY KEY CLUSTERED  ([Eloqua_Audit_RejectResultsSK])
GO
