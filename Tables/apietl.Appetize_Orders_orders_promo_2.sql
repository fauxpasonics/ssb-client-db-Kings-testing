CREATE TABLE [apietl].[Appetize_Orders_orders_promo_2]
(
[ETL__Appetize_Orders_orders_promo_id] [uniqueidentifier] NOT NULL,
[ETL__Appetize_Orders_orders_id] [uniqueidentifier] NULL,
[id] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[code] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [apietl].[Appetize_Orders_orders_promo_2] ADD CONSTRAINT [PK__Appetize__9C3C12146C891713] PRIMARY KEY CLUSTERED  ([ETL__Appetize_Orders_orders_promo_id])
GO
