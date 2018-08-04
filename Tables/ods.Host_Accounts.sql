CREATE TABLE [ods].[Host_Accounts]
(
[HostAccountId] [int] NOT NULL IDENTITY(1, 1),
[ETL__CreatedDate] [datetime] NULL,
[ETL__UpdatedDate] [datetime] NULL,
[ETL__DeltaHashKey] [binary] (32) NULL,
[EMAIL] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PREFIX] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FIRSTNAME] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MIDDLEINITIAL] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LASTNAME] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SUFFIX] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ADDRESS1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ADDRESS2] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CITY] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[STATE] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ZIP] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ZIPEXT] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DAYPHONE] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EVENINGPHONE] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [ods].[Host_Accounts] ADD CONSTRAINT [PK__Host_Acc__513AA5150EF89641] PRIMARY KEY CLUSTERED  ([HostAccountId])
GO
CREATE NONCLUSTERED INDEX [IDX_EMAIL] ON [ods].[Host_Accounts] ([EMAIL])
GO
CREATE NONCLUSTERED INDEX [IDX_ETL__DeltaHashKey] ON [ods].[Host_Accounts] ([ETL__DeltaHashKey])
GO
CREATE NONCLUSTERED INDEX [IDX_FIRSTNAME] ON [ods].[Host_Accounts] ([FIRSTNAME])
GO
CREATE NONCLUSTERED INDEX [IDX_LASTNAME] ON [ods].[Host_Accounts] ([LASTNAME])
GO
CREATE NONCLUSTERED INDEX [IDX_ZIP] ON [ods].[Host_Accounts] ([ZIP])
GO
