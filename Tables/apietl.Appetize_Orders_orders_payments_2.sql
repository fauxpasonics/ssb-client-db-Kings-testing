CREATE TABLE [apietl].[Appetize_Orders_orders_payments_2]
(
[ETL__Appetize_Orders_orders_payments_id] [uniqueidentifier] NOT NULL,
[ETL__Appetize_Orders_orders_id] [uniqueidentifier] NULL,
[order_id] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[payment_index] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[payment_type] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[payment_type_name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[subpayment_type] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[payment_status] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[payment_info] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[payment_amount] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[transaction_id] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[voucher_code] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[house_account_id] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[tip] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fee] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[tax] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[promo_id] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[is_card_present] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[card_type] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[last4] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [apietl].[Appetize_Orders_orders_payments_2] ADD CONSTRAINT [PK__Appetize__C54BA3C7E5AAB85C] PRIMARY KEY CLUSTERED  ([ETL__Appetize_Orders_orders_payments_id])
GO
