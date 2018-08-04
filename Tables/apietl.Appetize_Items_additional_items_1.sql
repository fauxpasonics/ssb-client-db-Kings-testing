CREATE TABLE [apietl].[Appetize_Items_additional_items_1]
(
[ETL__Appetize_Items_additional_items_id] [uniqueidentifier] NOT NULL,
[ETL__Appetize_Items_id] [uniqueidentifier] NULL,
[id] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[parentModifierId] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[image] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[need_icon] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[cost] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[calories] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[caloriesLabel] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[status] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[inventory_amount] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[sold_out] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[mark_as_sold_out] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[_sold_out] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[barcode] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[image_url] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [apietl].[Appetize_Items_additional_items_1] ADD CONSTRAINT [PK__Appetize__730F2DA8B32E4766] PRIMARY KEY CLUSTERED  ([ETL__Appetize_Items_additional_items_id])
GO
