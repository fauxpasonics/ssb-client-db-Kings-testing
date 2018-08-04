CREATE TABLE [etl].[JSON_Meta_Table_Configuration]
(
[JSON_Meta_Table_Configuration_ID] [int] NOT NULL IDENTITY(1, 1),
[JSON_Meta_Table_ID] [int] NOT NULL,
[TargetSchema] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TargetTableName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Active] [bit] NOT NULL CONSTRAINT [DF__JSON_Meta__Activ__0F3204D8] DEFAULT ((1)),
[CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__JSON_Meta__Creat__10262911] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[CreatedBy] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__JSON_Meta__Creat__111A4D4A] DEFAULT (suser_sname()),
[LastUpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__JSON_Meta__LastU__120E7183] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[LastUpdatedBy] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__JSON_Meta__LastU__130295BC] DEFAULT (suser_sname())
)
GO
ALTER TABLE [etl].[JSON_Meta_Table_Configuration] ADD CONSTRAINT [PK__JSON_Met__CA90E604B932A6C5] PRIMARY KEY CLUSTERED  ([JSON_Meta_Table_Configuration_ID])
GO
ALTER TABLE [etl].[JSON_Meta_Table_Configuration] ADD CONSTRAINT [UQ__JSON_Met__BBAAE0D93668D99F] UNIQUE NONCLUSTERED  ([TargetSchema], [TargetTableName])
GO
