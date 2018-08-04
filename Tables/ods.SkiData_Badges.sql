CREATE TABLE [ods].[SkiData_Badges]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL,
[ETL_UpdatedDate] [datetime] NOT NULL,
[ETL_IsDeleted] [bit] NOT NULL,
[ETL_DeletedDate] [datetime] NULL,
[ETL_DeltaHashKey] [binary] (32) NULL,
[ETL_SourceFileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BadgeId] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Title] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Teaser] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Description] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ProgressMessage] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ProgressCompleteMessage] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[StartDateTime] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EndDateTime] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[VisibilityStartDate] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[VisibilityEndDate] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsVisible] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[InitialQuantity] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RemainingQuantity] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BadgeCriteriaTypeID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsActive] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DateCreated] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DateUpdated] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UpdatedBy] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ProgressMessage1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ProgressCompleteMessage1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BadgeEarnedMessageTemplateID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [ods].[SkiData_Badges] ADD CONSTRAINT [PK__SkiData___1918235C10C5183F] PRIMARY KEY CLUSTERED  ([BadgeId])
GO
