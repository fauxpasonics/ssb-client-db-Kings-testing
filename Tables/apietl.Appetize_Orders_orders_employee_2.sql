CREATE TABLE [apietl].[Appetize_Orders_orders_employee_2]
(
[ETL__Appetize_Orders_orders_employee_id] [uniqueidentifier] NOT NULL,
[ETL__Appetize_Orders_orders_id] [uniqueidentifier] NULL,
[id] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[employee_name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[external_id] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[device_name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [apietl].[Appetize_Orders_orders_employee_2] ADD CONSTRAINT [PK__Appetize__224361FC697F1CAE] PRIMARY KEY CLUSTERED  ([ETL__Appetize_Orders_orders_employee_id])
GO
