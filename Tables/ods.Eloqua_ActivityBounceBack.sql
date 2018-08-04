CREATE TABLE [ods].[Eloqua_ActivityBounceBack]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__Eloqua_Ac__ETL_C__12C8C788] DEFAULT (getdate()),
[ETL_UpdatedDate] [datetime] NOT NULL CONSTRAINT [DF__Eloqua_Ac__ETL_U__13BCEBC1] DEFAULT (getdate()),
[ETL_IsDeleted] [bit] NOT NULL CONSTRAINT [DF__Eloqua_Ac__ETL_I__14B10FFA] DEFAULT ((0)),
[ETL_DeletedDate] [datetime] NULL,
[ETL_DeltaHashKey] [binary] (32) NULL,
[ID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreatedAt] [datetime] NULL,
[Type] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AssetName] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AssetId] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AssetType] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CampaignId] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EmailAddress] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [ods].[Eloqua_ActivityBounceBack] ADD CONSTRAINT [PK__Eloqua_A__3214EC275A7AF051] PRIMARY KEY CLUSTERED  ([ID])
GO
