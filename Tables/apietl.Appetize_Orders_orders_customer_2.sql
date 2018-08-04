CREATE TABLE [apietl].[Appetize_Orders_orders_customer_2]
(
[ETL__Appetize_Orders_orders_customer_id] [uniqueidentifier] NOT NULL,
[ETL__Appetize_Orders_orders_id] [uniqueidentifier] NULL,
[id] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[email] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[mobile] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[level] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[section] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[row] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[seat] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [apietl].[Appetize_Orders_orders_customer_2] ADD CONSTRAINT [PK__Appetize__1098D64888BF933A] PRIMARY KEY CLUSTERED  ([ETL__Appetize_Orders_orders_customer_id])
GO
