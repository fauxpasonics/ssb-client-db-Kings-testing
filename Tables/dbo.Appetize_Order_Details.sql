CREATE TABLE [dbo].[Appetize_Order_Details]
(
[order_id] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[id] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[cost] [numeric] (13, 4) NULL,
[type] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[row_id] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[quantity] [numeric] (13, 4) NULL,
[add_price_override] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[addtional_item_product_id] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[addtional_item_name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[addtional_item_cost] [numeric] (13, 4) NULL
)
GO
