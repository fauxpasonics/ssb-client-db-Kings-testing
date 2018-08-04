CREATE TABLE [src].[SkiData_DailyActivity]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL,
[ETL_SourceFileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UserID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PageViews] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IPAddress] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FirstView] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastView] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [src].[SkiData_DailyActivity] ADD CONSTRAINT [PK__SkiData___7EF6BFCDBA69247] PRIMARY KEY CLUSTERED  ([ETL_ID])
GO
