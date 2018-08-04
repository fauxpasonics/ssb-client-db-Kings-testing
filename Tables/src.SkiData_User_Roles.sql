CREATE TABLE [src].[SkiData_User_Roles]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL,
[ETL_SourceFileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UserRoleID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RoleGroupID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RoleGroupName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RoleID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RoleName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UserID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TicketAccountID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ExpiryDate] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EffectiveDate] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [src].[SkiData_User_Roles] ADD CONSTRAINT [PK__SkiData___7EF6BFCDBA69244] PRIMARY KEY CLUSTERED  ([ETL_ID])
GO
