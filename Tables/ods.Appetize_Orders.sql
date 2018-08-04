CREATE TABLE [ods].[Appetize_Orders]
(
[ETL__ID] [int] NOT NULL IDENTITY(1, 1),
[ETL__UpdatedDate] [datetime] NULL,
[ETL__DeltaHashKey] [binary] (32) NULL,
[order_id] [int] NULL,
[id] [int] NULL,
[name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[email] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[mobile] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[level] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[section] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[row] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[seat] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[user_seat_id] [int] NULL,
[order_source] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[total] [decimal] (18, 6) NULL,
[original_subtotal] [decimal] (18, 6) NULL,
[tip] [decimal] (18, 6) NULL,
[fee] [decimal] (18, 6) NULL,
[tax] [decimal] (18, 6) NULL,
[status] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[vendor_id] [int] NULL,
[vendor_name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_mode] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[payment_type] [int] NULL,
[timezone] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_date] [datetime] NULL,
[date_modified] [datetime] NULL,
[date_completed] [datetime] NULL,
[offline_mode] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[device_token] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[card_type] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO