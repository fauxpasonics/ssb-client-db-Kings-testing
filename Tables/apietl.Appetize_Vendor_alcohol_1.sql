CREATE TABLE [apietl].[Appetize_Vendor_alcohol_1]
(
[ETL__Appetize_Vendor_alcohol_id] [uniqueidentifier] NOT NULL,
[ETL__Appetize_Vendor_id] [uniqueidentifier] NULL,
[isAlcoholLimitPerEventEnabled] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[alcoholLimitPerEvent] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[isAlcoholLimitPerOrderEnabled] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[alcoholLimitPerOrder] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [apietl].[Appetize_Vendor_alcohol_1] ADD CONSTRAINT [PK__Appetize__061602645D1869D1] PRIMARY KEY CLUSTERED  ([ETL__Appetize_Vendor_alcohol_id])
GO
