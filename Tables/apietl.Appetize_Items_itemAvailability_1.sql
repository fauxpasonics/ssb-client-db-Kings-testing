CREATE TABLE [apietl].[Appetize_Items_itemAvailability_1]
(
[ETL__Appetize_Items_itemAvailability_id] [uniqueidentifier] NOT NULL,
[ETL__Appetize_Items_id] [uniqueidentifier] NULL,
[always_available] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [apietl].[Appetize_Items_itemAvailability_1] ADD CONSTRAINT [PK__Appetize__DB7A61BB06178B56] PRIMARY KEY CLUSTERED  ([ETL__Appetize_Items_itemAvailability_id])
GO
