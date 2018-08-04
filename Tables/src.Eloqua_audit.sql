CREATE TABLE [src].[Eloqua_audit]
(
[SK] [bigint] NULL,
[ETL__multi_query_value_for_audit] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SyncUri] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Logs_totalResults] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Logs_limit] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Logs_offset] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Logs_count] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Logs_hasMore] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Rejects_totalResults] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Rejects_limit] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Rejects_offset] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Rejects_count] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Rejects_hasMore] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Logs_items_] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Logs_items_syncUri] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Logs_items_count] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Logs_items_severity] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Logs_items_statusCode] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Logs_items_message] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Logs_items_createdAt] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
