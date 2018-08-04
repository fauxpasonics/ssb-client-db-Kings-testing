CREATE TABLE [src].[SkiData_UserBadges]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL,
[ETL_SourceFileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UserBadgeID] [int] NOT NULL,
[Title] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Description] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UserID] [int] NULL,
[BadgeID] [int] NULL,
[DateCreated] [datetime] NULL,
[DateUpdated] [datetime] NULL,
[IsValid] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ManuallyAwardedByUserID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
