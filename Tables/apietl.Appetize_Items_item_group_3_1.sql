CREATE TABLE [apietl].[Appetize_Items_item_group_3_1]
(
[ETL__Appetize_Items_item_group_3_id] [uniqueidentifier] NOT NULL,
[ETL__Appetize_Items_id] [uniqueidentifier] NULL,
[id] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[venue_id] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[type] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[category_image] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CorporateItemCategoriesId] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [apietl].[Appetize_Items_item_group_3_1] ADD CONSTRAINT [PK__Appetize__84646984EA79FE07] PRIMARY KEY CLUSTERED  ([ETL__Appetize_Items_item_group_3_id])
GO
