CREATE TABLE [src].[Eloqua_ActivityFormSubmit]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__Eloqua_Ac__ETL_C__40C49C62] DEFAULT (getdate()),
[ETL_UpdatedDate] [datetime] NOT NULL CONSTRAINT [DF__Eloqua_Ac__ETL_U__41B8C09B] DEFAULT (getdate()),
[ETL_IsDeleted] [bit] NOT NULL CONSTRAINT [DF__Eloqua_Ac__ETL_I__42ACE4D4] DEFAULT ((0)),
[ETL_DeletedDate] [datetime] NULL,
[ETL_DeltaHashKey] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Name] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreatedAt] [datetime] NULL,
[Type] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AssetName] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AssetId] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AssetType] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ContactId] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Collection] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FormName] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FormData] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RawData] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CampaignId] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [src].[Eloqua_ActivityFormSubmit] ADD CONSTRAINT [PK__Eloqua_A__7EF6BFCD1DED9DC4] PRIMARY KEY CLUSTERED  ([ETL_ID])
GO
