CREATE TABLE [apietl].[Appetize_Orders_0]
(
[ETL__Appetize_Orders_id] [uniqueidentifier] NOT NULL,
[ETL__session_id] [uniqueidentifier] NOT NULL,
[ETL__insert_datetime] [datetime] NOT NULL CONSTRAINT [DF__Appetize___ETL____0DBC5BAD] DEFAULT (getutcdate()),
[ETL__multi_query_value_for_audit] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [apietl].[Appetize_Orders_0] ADD CONSTRAINT [PK__Appetize__1ECB6C305C18DCA4] PRIMARY KEY CLUSTERED  ([ETL__Appetize_Orders_id])
GO
