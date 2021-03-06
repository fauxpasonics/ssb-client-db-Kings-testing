CREATE TABLE [emailoutbound].[WorkingSet]
(
[EmailPrimary] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsNewRecord] [bit] NULL,
[RecordSource] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreatedDate] [date] NULL
)
GO
CREATE NONCLUSTERED INDEX [IX_EmailPrimary] ON [emailoutbound].[WorkingSet] ([EmailPrimary])
GO
