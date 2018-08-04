CREATE TABLE [apietl].[Appetize_Orders_orders_discounts_applied_2]
(
[ETL__Appetize_Orders_orders_discounts_applied_id] [uniqueidentifier] NOT NULL,
[ETL__Appetize_Orders_orders_id] [uniqueidentifier] NULL,
[id] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[amount] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [apietl].[Appetize_Orders_orders_discounts_applied_2] ADD CONSTRAINT [PK__Appetize__27DD1FB24CF58224] PRIMARY KEY CLUSTERED  ([ETL__Appetize_Orders_orders_discounts_applied_id])
GO
