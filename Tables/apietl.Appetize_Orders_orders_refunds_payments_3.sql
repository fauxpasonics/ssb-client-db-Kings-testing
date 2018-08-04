CREATE TABLE [apietl].[Appetize_Orders_orders_refunds_payments_3]
(
[ETL__Appetize_Orders_orders_refunds_payments_id] [uniqueidentifier] NOT NULL,
[ETL__Appetize_Orders_orders_refunds_id] [uniqueidentifier] NULL,
[payment_index] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[payment_type] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[payment_type_name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[subpayment_type] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[payment_status] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[amount] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[subtotal] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[tip] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[tax] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[status] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[type] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[date_created] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[date_completed] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[transaction_id] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[last_four_credit] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [apietl].[Appetize_Orders_orders_refunds_payments_3] ADD CONSTRAINT [PK__Appetize__7012ABCF88E47B96] PRIMARY KEY CLUSTERED  ([ETL__Appetize_Orders_orders_refunds_payments_id])
GO
