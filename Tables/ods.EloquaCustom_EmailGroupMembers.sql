CREATE TABLE [ods].[EloquaCustom_EmailGroupMembers]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__EloquaCus__ETL_C__41C248AF] DEFAULT (getdate()),
[ETL_UpdatedDate] [datetime] NOT NULL CONSTRAINT [DF__EloquaCus__ETL_U__42B66CE8] DEFAULT (getdate()),
[ETL_IsDeleted] [bit] NOT NULL CONSTRAINT [DF__EloquaCus__ETL_I__43AA9121] DEFAULT ((0)),
[ETL_DeletedDate] [datetime] NULL,
[ETL_DeltaHashKey] [binary] (32) NULL,
[EmailGroup] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__EloquaCus__Email__449EB55A] DEFAULT ('Unknown'),
[ContactID] [bigint] NOT NULL,
[EmailAddress] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TSSC_TempField25] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TSSC_TempField2GroupDate] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PURLName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SFDC_OpportunityID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TSSC_TempField04_1127_STMPurchaserName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TSSC_TempField10_1127_Name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FirstName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Company] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Archtics_AccountID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BusinessPhone] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DayPhone] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Zip_or_PostalCode] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[City] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Address1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Address2] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Address3] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Salesperson] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BirthDate] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BirthMonth] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Interest_Kings] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Interest_OtherSportingEvents] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Interest_Concerts] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Interest_FamilyShows] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PURLName_MSETotalAccesscom] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TotalAccessMember] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastWebsiteVisit] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DateCreated] [datetime] NULL,
[AddDate] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DateModified] [datetime] NULL,
[CustomerStatus] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FavoritePlayer] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[State_or_Province] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Title] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Country] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FavoriteMatchUp1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FavoriteMatchUp2] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[zzSFDCAccountID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[zzSFDCContactID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[zzSFDCLeadID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SubAR] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TSSC_TempField53_SPGame] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SAS_RequestTime] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NewCCKReps] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TemporarySegment] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TSSC_TempField5_1127_NumberOfBobbleheads] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FirstAndLastName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PURLName_KingsTicketSavecom] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AccountType] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RenewalPURLLogin] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RenewalPURLID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TSSC_TempField_KNXVoucher] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SourceDescription] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TSSC_TempField_INDV1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TSSC_TempField18_BobbleSelection] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TSSC_TempField_INDV2] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TSSC_TempField19] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TSSC_TempField24_CorpLink] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SFDC_Kingscom_ActivityFlag] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SFDC_ESCcom_ActivityFlag] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SFDC_Last7DayActivityFlag] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EngagementStatus] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[STH_Tracking] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FEP_Time] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NumberOfTickets] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PlanType] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TrackingNumber] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
