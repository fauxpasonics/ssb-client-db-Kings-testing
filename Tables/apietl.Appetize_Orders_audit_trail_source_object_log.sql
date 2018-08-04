CREATE TABLE [apietl].[Appetize_Orders_audit_trail_source_object_log]
(
[ETL__audit_id] [uniqueidentifier] NOT NULL,
[ETL__Appetize_Orders_id] [uniqueidentifier] NULL,
[ETL__session_id] [uniqueidentifier] NOT NULL,
[ETL__insert_datetime] [datetime] NOT NULL CONSTRAINT [DF__Appetize___ETL____0ADFEF02] DEFAULT (getutcdate()),
[json_payload] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[raw_response] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [apietl].[Appetize_Orders_audit_trail_source_object_log] ADD CONSTRAINT [PK__Appetize__DB9573BC87F3BB5E] PRIMARY KEY CLUSTERED  ([ETL__audit_id])
GO
