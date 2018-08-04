CREATE TABLE [src].[Eloqua_Visitor_20171204]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__Eloqua_Vi__ETL_C__51C6A1E0] DEFAULT (getdate()),
[VisitorId] [int] NULL,
[CreatedAt] [datetime] NULL,
[V_IPAddress] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[V_LastVisitDateAndTime] [datetime] NULL,
[ExternalId] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ContactId] [int] NULL
)
GO
