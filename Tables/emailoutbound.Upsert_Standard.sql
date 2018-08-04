CREATE TABLE [emailoutbound].[Upsert_Standard]
(
[SSB_CRMSYSTEM_CONTACT_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Email] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[First_Name] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Last_Name] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Suffix] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Gender] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Birth_Date] [date] NULL,
[Address_Street] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Address_Suite] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Address_City] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Address_State] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Address_Zip] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Address_County] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Address_Country] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Record_Source] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Is_New_Record] [bit] NULL,
[phone] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Company] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SecondaryEmail] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SourceSystem] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Birthday] [date] NULL,
[Prefix] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MiddleName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PhoneHome] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PhoneCell] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PhoneBusiness] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PhoneFax] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AccountId] [int] NULL,
[AccountType] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SSB_CRMSYSTEM_ACCT_ID] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
