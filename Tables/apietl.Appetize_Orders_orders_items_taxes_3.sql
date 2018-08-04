CREATE TABLE [apietl].[Appetize_Orders_orders_items_taxes_3]
(
[ETL__Appetize_Orders_orders_items_taxes_id] [uniqueidentifier] NOT NULL,
[ETL__Appetize_Orders_orders_items_id] [uniqueidentifier] NULL,
[inclusive_tax_amount] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [apietl].[Appetize_Orders_orders_items_taxes_3] ADD CONSTRAINT [PK__Appetize__533B80D832F07A52] PRIMARY KEY CLUSTERED  ([ETL__Appetize_Orders_orders_items_taxes_id])
GO
