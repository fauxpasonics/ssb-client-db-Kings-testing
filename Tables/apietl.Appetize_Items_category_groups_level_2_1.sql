CREATE TABLE [apietl].[Appetize_Items_category_groups_level_2_1]
(
[ETL__Appetize_Items_category_groups_level_2_id] [uniqueidentifier] NOT NULL,
[ETL__Appetize_Items_id] [uniqueidentifier] NULL,
[id] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[display_name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[receiptTrailerMessage] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[image] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[image_full_res] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [apietl].[Appetize_Items_category_groups_level_2_1] ADD CONSTRAINT [PK__Appetize__C05CF58E7ECE8A64] PRIMARY KEY CLUSTERED  ([ETL__Appetize_Items_category_groups_level_2_id])
GO
