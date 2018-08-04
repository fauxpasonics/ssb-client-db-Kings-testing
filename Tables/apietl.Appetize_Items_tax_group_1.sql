CREATE TABLE [apietl].[Appetize_Items_tax_group_1]
(
[ETL__Appetize_Items_tax_group_id] [uniqueidentifier] NOT NULL,
[ETL__Appetize_Items_id] [uniqueidentifier] NULL,
[id] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[venue_id] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[layout_id] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[status] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[type] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[value] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[is_active] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[is_exclusive] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [apietl].[Appetize_Items_tax_group_1] ADD CONSTRAINT [PK__Appetize__3F72DC52DE0137C8] PRIMARY KEY CLUSTERED  ([ETL__Appetize_Items_tax_group_id])
GO
