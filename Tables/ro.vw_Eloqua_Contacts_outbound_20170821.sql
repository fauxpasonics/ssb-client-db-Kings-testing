CREATE TABLE [ro].[vw_Eloqua_Contacts_outbound_20170821]
(
[dimcustomerID] [int] NOT NULL,
[emailprimary] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SSB_CRMSYSTEM_CONTACT_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SSB_CRMSYSTEM_ACCT_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ArchticsID] [int] NULL,
[FirstName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MiddleName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Address1] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Address2] [nvarchar] (425) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[address3] [int] NULL,
[address4] [int] NULL,
[Addressprimarycity] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[addressprimarystate] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[addressprimaryzip] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[addressprimarycountry] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[birthday] [date] NULL,
[PhonePrimary] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PhoneHome] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PhoneCell] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PhoneBusiness] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PhoneFax] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Title] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ownerID] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Email] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Name] [nvarchar] (121) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AccountID] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ContactID] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreatedDate] [datetime] NOT NULL,
[UpdatedDate] [datetime] NOT NULL,
[Eloqua Contact ID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Birth Month] [nvarchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Birth Year] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Rep - Group Sales] [nvarchar] (121) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Share Partner Flag] [bit] NULL,
[STM Flag] [nvarchar] (1300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Broker Flag] [int] NOT NULL,
[Group Leader Flag] [int] NOT NULL,
[SFDC Lead Score] [float] NULL,
[Source] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Account Type Description] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO