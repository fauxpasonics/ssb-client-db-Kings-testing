CREATE TABLE [apietl].[Appetize_Orders_orders_items_discounts_applied_3]
(
[ETL__Appetize_Orders_orders_items_discounts_applied_id] [uniqueidentifier] NOT NULL,
[ETL__Appetize_Orders_orders_items_id] [uniqueidentifier] NULL,
[id] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[amount] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [apietl].[Appetize_Orders_orders_items_discounts_applied_3] ADD CONSTRAINT [PK__Appetize__BB2945E02768CC3C] PRIMARY KEY CLUSTERED  ([ETL__Appetize_Orders_orders_items_discounts_applied_id])
GO
