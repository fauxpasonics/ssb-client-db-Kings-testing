CREATE TABLE [apietl].[Appetize_Orders_orders_items_promo_3]
(
[ETL__Appetize_Orders_orders_items_promo_id] [uniqueidentifier] NOT NULL,
[ETL__Appetize_Orders_orders_items_id] [uniqueidentifier] NULL,
[id] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[code] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [apietl].[Appetize_Orders_orders_items_promo_3] ADD CONSTRAINT [PK__Appetize__A35365B1339D560D] PRIMARY KEY CLUSTERED  ([ETL__Appetize_Orders_orders_items_promo_id])
GO
