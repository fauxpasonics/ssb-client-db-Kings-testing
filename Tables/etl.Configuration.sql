CREATE TABLE [etl].[Configuration]
(
[ConfigurationID] [int] NOT NULL,
[Name] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Value] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Active] [bit] NULL,
[CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__Configura__Creat__45D82E4C] DEFAULT (getdate()),
[CreatedBy] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__Configura__Creat__46CC5285] DEFAULT (suser_sname()),
[LastUpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__Configura__LastU__47C076BE] DEFAULT (getdate()),
[LastUpdatedBy] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__Configura__LastU__48B49AF7] DEFAULT (suser_sname())
)
GO
ALTER TABLE [etl].[Configuration] ADD CONSTRAINT [PK__Configur__95AA539B844B8DD6] PRIMARY KEY CLUSTERED  ([ConfigurationID])
GO
