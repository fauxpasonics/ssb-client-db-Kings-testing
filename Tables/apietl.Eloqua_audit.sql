CREATE TABLE [apietl].[Eloqua_audit]
(
[ETL__session_id] [uniqueidentifier] NOT NULL,
[ETL__insert_datetime] [datetime] NOT NULL CONSTRAINT [DF__Eloqua_au__ETL____04FBF72A] DEFAULT (getutcdate()),
[ETL__multi_query_value_for_audit] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[json_payload] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsLoaded] [bit] NOT NULL CONSTRAINT [DF__Eloqua_au__IsLoa__44425397] DEFAULT ((0)),
[ID] [int] NOT NULL IDENTITY(1, 1)
)
GO
