CREATE TABLE [apietl].[Appetize_Orders_orders_items_2]
(
[ETL__Appetize_Orders_orders_items_id] [uniqueidentifier] NOT NULL,
[ETL__Appetize_Orders_orders_id] [uniqueidentifier] NULL,
[id] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[cost] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[discount] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[promo_code] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[type] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[row_id] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[quantity] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[add_price_override] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[refund_item_quantity] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[refund_item_cost] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[refund_status] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[unique_id] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[original_cost] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[tax] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[sku] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[external_id] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [apietl].[Appetize_Orders_orders_items_2] ADD CONSTRAINT [PK__Appetize__45BB7E7A766992C8] PRIMARY KEY CLUSTERED  ([ETL__Appetize_Orders_orders_items_id])
GO
