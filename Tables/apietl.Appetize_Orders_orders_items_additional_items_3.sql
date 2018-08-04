CREATE TABLE [apietl].[Appetize_Orders_orders_items_additional_items_3]
(
[ETL__Appetize_Orders_orders_items_additional_items_id] [uniqueidentifier] NOT NULL,
[ETL__Appetize_Orders_orders_items_id] [uniqueidentifier] NULL,
[id] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[product_id] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[cost] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[discount] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[refund_quantity] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[refund_cost] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[refund_status] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [apietl].[Appetize_Orders_orders_items_additional_items_3] ADD CONSTRAINT [PK__Appetize__573C5F4F04B03576] PRIMARY KEY CLUSTERED  ([ETL__Appetize_Orders_orders_items_additional_items_id])
GO
