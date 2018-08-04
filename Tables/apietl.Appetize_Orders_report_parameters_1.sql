CREATE TABLE [apietl].[Appetize_Orders_report_parameters_1]
(
[ETL__Appetize_Orders_report_parameters_id] [uniqueidentifier] NOT NULL,
[ETL__Appetize_Orders_id] [uniqueidentifier] NULL,
[venue_id] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[timezone] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[start_date] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[end_date] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[updated_since] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[updated_before] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[status] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[page] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[per_page] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [apietl].[Appetize_Orders_report_parameters_1] ADD CONSTRAINT [PK__Appetize__7A6D8A88634E76E7] PRIMARY KEY CLUSTERED  ([ETL__Appetize_Orders_report_parameters_id])
GO
