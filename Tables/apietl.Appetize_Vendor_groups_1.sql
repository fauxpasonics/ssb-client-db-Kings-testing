CREATE TABLE [apietl].[Appetize_Vendor_groups_1]
(
[ETL__Appetize_Vendor_groups_id] [uniqueidentifier] NOT NULL,
[ETL__Appetize_Vendor_id] [uniqueidentifier] NULL,
[id] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [apietl].[Appetize_Vendor_groups_1] ADD CONSTRAINT [PK__Appetize__5A71BC8B198FE1DE] PRIMARY KEY CLUSTERED  ([ETL__Appetize_Vendor_groups_id])
GO
