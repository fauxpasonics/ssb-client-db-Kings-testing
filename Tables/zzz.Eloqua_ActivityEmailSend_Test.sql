CREATE TABLE [zzz].[Eloqua_ActivityEmailSend_Test]
(
[ETL_ID] [int] NOT NULL,
[ETL_CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__Eloqua_Ac__ETL_C__413A9ACF] DEFAULT (getdate()),
[ETL_UpdatedDate] [datetime] NOT NULL CONSTRAINT [DF__Eloqua_Ac__ETL_U__422EBF08] DEFAULT (getdate()),
[ETL_IsDeleted] [bit] NOT NULL CONSTRAINT [DF__Eloqua_Ac__ETL_I__4322E341] DEFAULT ((0)),
[ETL_DeletedDate] [datetime] NULL,
[ETL_DeltaHashKey] [binary] (32) NULL,
[ID] [bigint] NOT NULL,
[Name] [varchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreatedAt] [datetime] NULL,
[Type] [varchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AssetName] [varchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AssetId] [bigint] NULL,
[AssetType] [varchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ContactId] [bigint] NULL,
[EmailName] [varchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EmailWebLink] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EmailRecipientId] [varchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SubjectLine] [varchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EmailAddress] [varchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CampaignId] [bigint] NULL
)
WITH
(
DATA_COMPRESSION = PAGE
)
GO
ALTER TABLE [zzz].[Eloqua_ActivityEmailSend_Test] ADD CONSTRAINT [PK__Eloqua_A__3214EC271473B3EF] PRIMARY KEY CLUSTERED  ([ID]) WITH (DATA_COMPRESSION = PAGE)
GO
CREATE NONCLUSTERED INDEX [IDX_eloqua_activityemailsend_Test_AssetId] ON [zzz].[Eloqua_ActivityEmailSend_Test] ([AssetId]) INCLUDE ([AssetName], [ContactId], [CreatedAt]) WITH (DATA_COMPRESSION = PAGE)
GO
