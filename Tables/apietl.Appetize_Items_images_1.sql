CREATE TABLE [apietl].[Appetize_Items_images_1]
(
[ETL__Appetize_Items_images_id] [uniqueidentifier] NOT NULL,
[ETL__Appetize_Items_id] [uniqueidentifier] NULL,
[image] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[image_full_res] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [apietl].[Appetize_Items_images_1] ADD CONSTRAINT [PK__Appetize__A8DECFC3FF826CCD] PRIMARY KEY CLUSTERED  ([ETL__Appetize_Items_images_id])
GO
