CREATE TABLE [apietl].[Appetize_Orders_orders_refunds_NO_COLUMN_NAME_PROVIDED_IN_JSON_3]
(
[ETL__Appetize_Orders_orders_refunds_NO_COLUMN_NAME_PROVIDED_IN_JSON_id] [uniqueidentifier] NOT NULL,
[ETL__Appetize_Orders_orders_refunds_id] [uniqueidentifier] NULL,
[product_id] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_items_id] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [apietl].[Appetize_Orders_orders_refunds_NO_COLUMN_NAME_PROVIDED_IN_JSON_3] ADD CONSTRAINT [PK__Appetize__6A47A45CD72FC3F7] PRIMARY KEY CLUSTERED  ([ETL__Appetize_Orders_orders_refunds_NO_COLUMN_NAME_PROVIDED_IN_JSON_id])
GO
