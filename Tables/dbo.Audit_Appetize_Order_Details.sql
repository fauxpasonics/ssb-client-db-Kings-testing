CREATE TABLE [dbo].[Audit_Appetize_Order_Details]
(
[ACTION] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LOG_DATE] [datetime2] NULL,
[inserted_order_id] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[inserted_id] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[inserted_name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[inserted_cost] [decimal] (13, 4) NULL,
[inserted_type] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[inserted_row_id] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[inserted_quantity] [decimal] (13, 4) NULL,
[inserted_add_price_override] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[inserted_addtional_item_product_id] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[inserted_addtional_item_name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[inserted_addtional_item_cost] [decimal] (13, 4) NULL,
[deleted_order_id] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[deleted_id] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[deleted_name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[deleted_cost] [decimal] (13, 4) NULL,
[deleted_type] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[deleted_row_id] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[deleted_quantity] [decimal] (13, 4) NULL,
[deleted_add_price_override] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[deleted_addtional_item_product_id] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[deleted_addtional_item_name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[deleted_addtional_item_cost] [decimal] (13, 4) NULL
)
GO
