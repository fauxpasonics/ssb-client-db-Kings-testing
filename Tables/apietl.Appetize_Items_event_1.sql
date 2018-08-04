CREATE TABLE [apietl].[Appetize_Items_event_1]
(
[ETL__Appetize_Items_event_id] [uniqueidentifier] NOT NULL,
[ETL__Appetize_Items_id] [uniqueidentifier] NULL,
[date] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [apietl].[Appetize_Items_event_1] ADD CONSTRAINT [PK__Appetize__95E80BEDB09FE09F] PRIMARY KEY CLUSTERED  ([ETL__Appetize_Items_event_id])
GO
