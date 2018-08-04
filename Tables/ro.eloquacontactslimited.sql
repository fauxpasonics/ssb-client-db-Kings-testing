CREATE TABLE [ro].[eloquacontactslimited]
(
[emailprimary] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SSB_CRMSYSTEM_CONTACT_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SSB_CRMSYSTEM_ACCT_ID] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ArchticsID] [int] NULL,
[Comp_FirstName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Comp_MiddleName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Comp_LastName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Comp_Suffix] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Comp_Address1] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Comp_Address2] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Comp_address3] [int] NULL,
[Comp_address4] [int] NULL,
[Comp_Addressprimarycity] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Comp_addressprimarystate] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Comp_addressprimaryzip] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Comp_addressprimarycountry] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Comp_Birthday] [date] NULL,
[Comp_PhonePrimary] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Comp_PhoneHome] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Comp_PhoneCell] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Comp_PhoneBusiness] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Comp_PhoneFax] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Comp_Title] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AccountID] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ContactID] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DateCreated] [datetime] NULL,
[DateModified] [datetime] NULL,
[Source] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Source_FirstName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Source_MiddleName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Source_LastName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Source_Suffix] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Source_Address1] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Source_Address2] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Source_address3] [int] NULL,
[Source_address4] [int] NULL,
[Source_Addressprimarycity] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Source_Addressprimarystate] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Source_Addressprimaryzip] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Source_Addressprimarycountry] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Source_Birthday] [date] NULL,
[Source_PhonePrimary] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Source_PhoneHome] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Source_PhoneCell] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Source_PhoneBusiness] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Source_PhoneFax] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Source_Title] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_DeltaHashKey] [binary] (32) NULL,
[ETL__CreatedDate] [datetime] NULL,
[UnsubscribedWithRecentEngagement] [bit] NULL,
[RepName] [nvarchar] (121) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RepEmail] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RepPhone] [nvarchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BirthMonth] [nvarchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BirthYear] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SharePartnerFlag] [bit] NULL,
[RepGroupSales] [nvarchar] (121) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BrokerFlag] [int] NULL,
[GroupLeaderFlag] [int] NULL,
[SFDCLeadScore] [float] NULL,
[LastEngagementDate] [datetime] NULL,
[LastEngagementType] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AccountTypeDescription] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO