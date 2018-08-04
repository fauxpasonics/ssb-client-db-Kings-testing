CREATE TABLE [apietl].[Appetize_Vendor_audit_trail_source_object_log]
(
[ETL__audit_id] [uniqueidentifier] NOT NULL,
[ETL__Appetize_Vendor_id] [uniqueidentifier] NULL,
[ETL__session_id] [uniqueidentifier] NOT NULL,
[ETL__insert_datetime] [datetime] NOT NULL CONSTRAINT [DF__Appetize___ETL____688AD6FE] DEFAULT (getutcdate()),
[json_payload] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[raw_response] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [apietl].[Appetize_Vendor_audit_trail_source_object_log] ADD CONSTRAINT [PK__Appetize__DB9573BCA47BE1A4] PRIMARY KEY CLUSTERED  ([ETL__audit_id])
GO
