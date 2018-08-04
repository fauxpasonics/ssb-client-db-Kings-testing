CREATE TABLE [ods].[Eloqua_visitors]
(
[visitorId] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[createdAt] [datetime] NULL,
[Browser_Type] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IPAddress] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Total_Pages] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Total_Time] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Total_Visits] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Current_Visit_Length] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Current_Total_Pages] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FirstVisitDateAndTime] [datetime] NULL,
[FirstPageInVisit] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastPageInVisit] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastVisitDateAndTime] [datetime] NULL,
[TimeZoneOffsetMin] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TimeZone] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[externalId] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contactId] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[currentStatus] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CountryFromIP] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CompanyNameFromIP1] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ISPFromIP] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ProvinceFromIP] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CityFromIP] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ZipCodeFromIP] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LatitudeFromIP] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LongitudeFromIP] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[HostName] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CompanyDNSName] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CountryName] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__Eloqua_vi__ETL_C__7D9D6482] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__Eloqua_vi__ETL_C__7E9188BB] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__Eloqua_vi__ETL_U__7F85ACF4] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__Eloqua_vi__ETL_U__0079D12D] DEFAULT (suser_sname())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_Eloqua_visitorsUpdate] ON [ods].[Eloqua_visitors]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[Eloqua_visitors] t
	JOIN inserted i ON  t.[visitorId] = i.[visitorId]

INSERT INTO [ods].[Snapshot_Eloqua_visitors] ([visitorId],[createdAt],[Browser_Type],[IPAddress],[Total_Pages],[Total_Time],[Total_Visits],[Name],[Current_Visit_Length],[Current_Total_Pages],[FirstVisitDateAndTime],[FirstPageInVisit],[LastPageInVisit],[LastVisitDateAndTime],[TimeZoneOffsetMin],[TimeZone],[externalId],[contactId],[currentStatus],[CountryFromIP],[CompanyNameFromIP1],[ISPFromIP],[ProvinceFromIP],[CityFromIP],[ZipCodeFromIP],[LatitudeFromIP],[LongitudeFromIP],[HostName],[CompanyDNSName],[CountryName],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate])
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END
GO
ALTER TABLE [ods].[Eloqua_visitors] ADD CONSTRAINT [PK__Eloqua_v__7D47DF820B16DE09] PRIMARY KEY CLUSTERED  ([visitorId])
GO
