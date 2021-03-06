CREATE TABLE [ods].[Formstack_Parsed_CustomerData]
(
[SessionId] [uniqueidentifier] NULL,
[RecordCreateDate] [datetime] NOT NULL,
[Processed] [bit] NOT NULL,
[DynamicData] [xml] NULL,
[SourceSystem] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SubmissonsID] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FirstName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FullName] [nvarchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Email] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AddressLine1] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AddressLine2] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AddressCity] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AddressState] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AddressZip] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PhoneHome] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PhoneCell] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PhoneBusiness] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FormName] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SubmissionDateTime] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BirthDate] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[URL] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Misc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SubmissionID] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Child1Birthday] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Child1Gender] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Child1Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Child2Birthday] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Child2Gender] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Child2Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Child3Birthday] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Child3Gender] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Child3Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Child4Birthday] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Child4Gender] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Child4Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NumberOfChildren] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
