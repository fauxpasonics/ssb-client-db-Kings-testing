CREATE TABLE [etl].[Batch]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[ParentID] [int] NULL,
[SortOrder] [int] NULL,
[BatchName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BatchRefID] [int] NULL,
[SourceSchema] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TargetSchema] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SourceQuery] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TaskType] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SQL] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ExecuteInParallel] [bit] NULL CONSTRAINT [DF__Batch__ExecuteIn__02CC2DF3] DEFAULT ((0)),
[CustomMatchOn] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ExcludeColumns] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Execute] [bit] NULL CONSTRAINT [DF__Batch__Execute__03C0522C] DEFAULT ((1)),
[FailBatchOnFailure] [bit] NULL CONSTRAINT [DF__Batch__FailBatch__04B47665] DEFAULT ((0)),
[SuppressResults] [bit] NULL CONSTRAINT [DF__Batch__SuppressR__05A89A9E] DEFAULT ((0)),
[FKTables] [bit] NULL CONSTRAINT [DF__Batch__FKTables__069CBED7] DEFAULT ((0)),
[AddID] [bit] NULL CONSTRAINT [DF__Batch__AddID__0790E310] DEFAULT ((0)),
[SnapshotTables] [bit] NULL CONSTRAINT [DF__Batch__SnapshotT__08850749] DEFAULT ((0)),
[AzureTier] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Active] [bit] NULL CONSTRAINT [DF__Batch__Active__09792B82] DEFAULT ((1))
)
GO
ALTER TABLE [etl].[Batch] ADD CONSTRAINT [PK__Batch__3214EC27DBD491E2] PRIMARY KEY CLUSTERED  ([ID])
GO
ALTER TABLE [etl].[Batch] ADD CONSTRAINT [uc_BatchName] UNIQUE NONCLUSTERED  ([BatchName])
GO
