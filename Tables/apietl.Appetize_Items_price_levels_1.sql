CREATE TABLE [apietl].[Appetize_Items_price_levels_1]
(
[ETL__Appetize_Items_price_levels_id] [uniqueidentifier] NOT NULL,
[ETL__Appetize_Items_id] [uniqueidentifier] NULL,
[price_level_id] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[price_level_name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[price] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [apietl].[Appetize_Items_price_levels_1] ADD CONSTRAINT [PK__Appetize__15C95D4E41EE2FF3] PRIMARY KEY CLUSTERED  ([ETL__Appetize_Items_price_levels_id])
GO
