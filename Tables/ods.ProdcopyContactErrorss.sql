CREATE TABLE [ods].[ProdcopyContactErrorss]
(
[LoadType] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SSB_CRMSYSTEM_ACCT_ID__c] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Name] [nvarchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BillingStreet] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BillingCity] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BillingState] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BillingCountry] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Phone] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BillingPostalCode] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SalesForceId] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RowResult] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ProdErrorCode] [int] NULL,
[ProdErrorColumn] [int] NULL,
[ProdErrorDescription] [nvarchar] (1024) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ResultDateTime] [datetime] NULL
)
GO
