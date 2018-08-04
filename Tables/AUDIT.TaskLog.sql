CREATE TABLE [AUDIT].[TaskLog]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[BatchID] [int] NOT NULL,
[Created] [datetime] NULL CONSTRAINT [DF__TaskLog__Created__7A36E7F2] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[User] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TaskName] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Target] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SQL] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ExecuteStart] [datetime] NULL,
[ExecuteEnd] [datetime] NULL,
[ExecutionRuntimeSeconds] AS (CONVERT([float],datediff(second,[ExecuteStart],[ExecuteEnd]),(0))),
[RowCountBefore] [int] NULL CONSTRAINT [DF__TaskLog__RowCoun__7B2B0C2B] DEFAULT ((0)),
[RowCountAfter] [int] NULL CONSTRAINT [DF__TaskLog__RowCoun__7C1F3064] DEFAULT ((0)),
[Inserted] [int] NULL CONSTRAINT [DF__TaskLog__Inserte__7D13549D] DEFAULT ((0)),
[Updated] [int] NULL CONSTRAINT [DF__TaskLog__Updated__7E0778D6] DEFAULT ((0)),
[Deleted] [int] NULL CONSTRAINT [DF__TaskLog__Deleted__7EFB9D0F] DEFAULT ((0)),
[Truncated] [int] NULL CONSTRAINT [DF__TaskLog__Truncat__7FEFC148] DEFAULT ((0)),
[IsCommitted] [bit] NULL CONSTRAINT [DF__TaskLog__IsCommi__00E3E581] DEFAULT ((0)),
[IsError] [bit] NULL CONSTRAINT [DF__TaskLog__IsError__01D809BA] DEFAULT ((0)),
[ErrorMessage] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ErrorSeverity] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ErrorState] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
WITH
(
DATA_COMPRESSION = PAGE
)
GO
ALTER TABLE [AUDIT].[TaskLog] ADD CONSTRAINT [PK__TaskLog__3214EC27DA725DC5] PRIMARY KEY CLUSTERED  ([ID]) WITH (DATA_COMPRESSION = PAGE)
GO
CREATE NONCLUSTERED INDEX [NCIX_TaskLog_BatchID_Include] ON [AUDIT].[TaskLog] ([BatchID]) INCLUDE ([IsError]) WITH (DATA_COMPRESSION = PAGE)
GO
