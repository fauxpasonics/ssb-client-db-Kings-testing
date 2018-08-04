CREATE TABLE [ods].[Eloqua_Contacts_Outbound]
(
[SSID] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[emailprimary] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SSB_CRMSYSTEM_CONTACT_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SSB_CRMSYSTEM_ACCT_ID] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ArchticsID] [int] NULL,
[FirstName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MiddleName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Suffix] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Address1] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Address2] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address3] [int] NULL,
[address4] [int] NULL,
[Addressprimarycity] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[addressprimarystate] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[addressprimaryzip] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[addressprimarycountry] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Birthday] [date] NULL,
[PhonePrimary] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PhoneHome] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PhoneCell] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PhoneBusiness] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PhoneFax] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Title] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Rep NAME] [nvarchar] (121) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Rep Email] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Rep Phone] [nvarchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AccountID] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ContactID] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DateCreated] [datetime] NULL,
[DateModified] [datetime] NULL,
[Birth Month] [nvarchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Birth Year] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Rep - Group Sales] [nvarchar] (121) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Share Partner Flag] [bit] NULL,
[Broker Flag] [int] NOT NULL,
[Group Leader Flag] [int] NOT NULL,
[SFDC Lead Score] [float] NULL,
[Source] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Last Engagement Date] [datetime] NULL,
[Last Engagement Type] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Account Type Description] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RankedFirstName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RankedMiddleName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RankedLastName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RankedSuffix] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RankedAddress1] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RankedAddress2] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[rankedaddress3] [int] NULL,
[rankedaddress4] [int] NULL,
[RankedAddressprimarycity] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RankedAddressprimarystate] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RankedAddressprimaryzip] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RankedAddressprimarycountry] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RankedBirthday] [date] NULL,
[RankedPhonePrimary] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RankedPhoneHome] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RankedPhoneCell] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RankedPhoneBusiness] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RankedPhoneFax] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RankedTitle] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_DeltaHashKey] [binary] (32) NULL,
[ETL__CreatedDate] [datetime] NULL
)
GO
