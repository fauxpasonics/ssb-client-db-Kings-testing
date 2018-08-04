CREATE TABLE [etl].[Task]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[BatchID] [int] NOT NULL CONSTRAINT [DF__Task__BatchID__1D80242F] DEFAULT ((0)),
[ExecutionOrder] [int] NOT NULL CONSTRAINT [DF__Task__ExecutionO__1E744868] DEFAULT ((1)),
[TaskName] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF__Task__TaskName__1F686CA1] DEFAULT ('Not Specified'),
[TaskType] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF__Task__TaskType__205C90DA] DEFAULT ('Not Specified'),
[SQL] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF__Task__SQL__2150B513] DEFAULT (NULL),
[Target] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF__Task__Target__2244D94C] DEFAULT (NULL),
[Source] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF__Task__Source__2338FD85] DEFAULT (NULL),
[CustomMatchOn] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF__Task__CustomMatc__242D21BE] DEFAULT (NULL),
[ExcludeColumns] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF__Task__ExcludeCol__252145F7] DEFAULT (NULL),
[Execute] [bit] NULL CONSTRAINT [DF__Task__Execute__26156A30] DEFAULT ((0)),
[FailBatchOnFailure] [bit] NULL CONSTRAINT [DF__Task__FailBatchO__27098E69] DEFAULT ((1)),
[SuppressResults] [bit] NULL CONSTRAINT [DF__Task__SuppressRe__27FDB2A2] DEFAULT ((0)),
[RunSQL] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Active] [bit] NULL CONSTRAINT [DF__Task__Active__28F1D6DB] DEFAULT ((1)),
[CREATED_DATE] [datetime] NOT NULL CONSTRAINT [DF__Task__CREATED_DA__29E5FB14] DEFAULT ([etl].[ConvertToLocalTime](getdate())),
[LUPDATED_DATE] [datetime] NOT NULL CONSTRAINT [DF__Task__LUPDATED_D__2ADA1F4D] DEFAULT ([etl].[ConvertToLocalTime](getdate()))
)
GO
ALTER TABLE [etl].[Task] ADD CONSTRAINT [PK__Task__3214EC27DDE0F39D] PRIMARY KEY CLUSTERED  ([ID])
GO
