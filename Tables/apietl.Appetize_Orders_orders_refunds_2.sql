CREATE TABLE [apietl].[Appetize_Orders_orders_refunds_2]
(
[ETL__Appetize_Orders_orders_refunds_id] [uniqueidentifier] NOT NULL,
[ETL__Appetize_Orders_orders_id] [uniqueidentifier] NULL,
[product_id] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_items_id] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [apietl].[Appetize_Orders_orders_refunds_2] ADD CONSTRAINT [PK__Appetize__87F98D46A92F558B] PRIMARY KEY CLUSTERED  ([ETL__Appetize_Orders_orders_refunds_id])
GO
