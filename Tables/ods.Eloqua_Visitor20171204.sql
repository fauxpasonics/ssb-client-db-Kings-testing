CREATE TABLE [ods].[Eloqua_Visitor20171204]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__Eloqua_Vi__ETL_C__4EEA3535] DEFAULT (getdate()),
[ETL_UpdatedDate] [datetime] NOT NULL CONSTRAINT [DF__Eloqua_Vi__ETL_U__4FDE596E] DEFAULT (getdate()),
[ETL_IsDeleted] [bit] NOT NULL,
[ETL_DeletedDate] [datetime] NULL,
[ETL_DeltaHashKey] [binary] (32) NULL,
[VisitorId] [int] NULL,
[CreatedAt] [datetime] NULL,
[V_IPAddress] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[V_LastVisitDateAndTime] [datetime] NULL,
[ExternalId] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ContactId] [int] NULL
)
GO
