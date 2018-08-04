CREATE TABLE [ods].[Eloqua_Email_01022016]
(
[ETL_ID] [int] NOT NULL,
[ETL_CreatedDate] [datetime] NOT NULL,
[ETL_UpdatedDate] [datetime] NOT NULL,
[ETL_IsDeleted] [bit] NOT NULL,
[ETL_DeletedDate] [datetime] NULL,
[ETL_DeltaHashKey] [binary] (32) NULL,
[ID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Name] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EmailGroupId] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[HtmlContent] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsPlainTextEditable] [bit] NULL,
[IsTracked] [bit] NULL,
[PlainText] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BouncebackEmail] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ReplyToEmail] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ReplyToName] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SenderEmail] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SenderName] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SenderPlainTextOnly] [bit] NULL,
[Subject] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Description] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FolderId] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Permissions] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreatedAt] [datetime] NULL,
[CreatedBy] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AccessedAt] [datetime] NULL,
[CurrentStatus] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Depth] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UpdatedAt] [datetime] NULL,
[UpdatedBy] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
