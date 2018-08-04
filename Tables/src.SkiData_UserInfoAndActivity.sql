CREATE TABLE [src].[SkiData_UserInfoAndActivity]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL,
[ETL_SourceFileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TicketAccountID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UserID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Username] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FirstName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Email] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DisplayName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Deleted] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Authorised] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreateDate] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TotalPointsEarned] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PointsRemaining] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TotalPointsSpent] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastLoginDate] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[HasLoggedIn] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[HasRedeemed] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [src].[SkiData_UserInfoAndActivity] ADD CONSTRAINT [PK__SkiData___7EF6BFCDBA69245] PRIMARY KEY CLUSTERED  ([ETL_ID])
GO
