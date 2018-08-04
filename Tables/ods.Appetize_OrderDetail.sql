CREATE TABLE [ods].[Appetize_OrderDetail]
(
[ETL__ID] [int] NOT NULL IDENTITY(1, 1),
[ETL__UpdatedDate] [datetime] NULL,
[ETL__DeltaHashKey] [binary] (32) NULL,
[order_id] [int] NULL,
[id] [int] NULL,
[name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[cost] [decimal] (18, 6) NULL,
[type] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[row_id] [int] NULL,
[quantity] [decimal] (18, 6) NULL,
[add_price_override] [bit] NULL,
[addtional_item_product_id] [int] NULL,
[addtional_item_name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[addtional_item_cost] [decimal] (18, 6) NULL
)
GO
