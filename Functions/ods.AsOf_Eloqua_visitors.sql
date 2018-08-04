SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_Eloqua_visitors] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_Eloqua_visitors] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[visitorId] [nvarchar](255) NULL,
[createdAt] [datetime] NULL,
[Browser_Type] [nvarchar](max) NULL,
[IPAddress] [nvarchar](max) NULL,
[Total_Pages] [nvarchar](max) NULL,
[Total_Time] [nvarchar](max) NULL,
[Total_Visits] [nvarchar](max) NULL,
[Name] [nvarchar](max) NULL,
[Current_Visit_Length] [nvarchar](max) NULL,
[Current_Total_Pages] [nvarchar](max) NULL,
[FirstVisitDateAndTime] [datetime] NULL,
[FirstPageInVisit] [nvarchar](max) NULL,
[LastPageInVisit] [nvarchar](max) NULL,
[LastVisitDateAndTime] [datetime] NULL,
[TimeZoneOffsetMin] [nvarchar](max) NULL,
[TimeZone] [nvarchar](max) NULL,
[externalId] [nvarchar](max) NULL,
[contactId] [nvarchar](max) NULL,
[currentStatus] [nvarchar](max) NULL,
[CountryFromIP] [nvarchar](max) NULL,
[CompanyNameFromIP1] [nvarchar](max) NULL,
[ISPFromIP] [nvarchar](max) NULL,
[ProvinceFromIP] [nvarchar](max) NULL,
[CityFromIP] [nvarchar](max) NULL,
[ZipCodeFromIP] [nvarchar](max) NULL,
[LatitudeFromIP] [nvarchar](max) NULL,
[LongitudeFromIP] [nvarchar](max) NULL,
[HostName] [nvarchar](max) NULL,
[CompanyDNSName] [nvarchar](max) NULL,
[CountryName] [nvarchar](max) NULL,
[ETL_CreatedOn] [datetime] NOT NULL,
[ETL_CreatedBy] NVARCHAR(400) NOT NULL,
[ETL_UpdatedOn] [datetime] NOT NULL,
[ETL_UpdatedBy] NVARCHAR(400) NOT NULL
)

AS
BEGIN

DECLARE @EndDate DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS datetime2(0))))
SET @AsOfDate = (SELECT CAST(@AsOfDate AS datetime2(0)))

INSERT INTO @Results
SELECT [visitorId],[createdAt],[Browser_Type],[IPAddress],[Total_Pages],[Total_Time],[Total_Visits],[Name],[Current_Visit_Length],[Current_Total_Pages],[FirstVisitDateAndTime],[FirstPageInVisit],[LastPageInVisit],[LastVisitDateAndTime],[TimeZoneOffsetMin],[TimeZone],[externalId],[contactId],[currentStatus],[CountryFromIP],[CompanyNameFromIP1],[ISPFromIP],[ProvinceFromIP],[CityFromIP],[ZipCodeFromIP],[LatitudeFromIP],[LongitudeFromIP],[HostName],[CompanyDNSName],[CountryName],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [visitorId],[createdAt],[Browser_Type],[IPAddress],[Total_Pages],[Total_Time],[Total_Visits],[Name],[Current_Visit_Length],[Current_Total_Pages],[FirstVisitDateAndTime],[FirstPageInVisit],[LastPageInVisit],[LastVisitDateAndTime],[TimeZoneOffsetMin],[TimeZone],[externalId],[contactId],[currentStatus],[CountryFromIP],[CompanyNameFromIP1],[ISPFromIP],[ProvinceFromIP],[CityFromIP],[ZipCodeFromIP],[LatitudeFromIP],[LongitudeFromIP],[HostName],[CompanyDNSName],[CountryName],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[Eloqua_visitors] t
	UNION ALL
	SELECT [visitorId],[createdAt],[Browser_Type],[IPAddress],[Total_Pages],[Total_Time],[Total_Visits],[Name],[Current_Visit_Length],[Current_Total_Pages],[FirstVisitDateAndTime],[FirstPageInVisit],[LastPageInVisit],[LastVisitDateAndTime],[TimeZoneOffsetMin],[TimeZone],[externalId],[contactId],[currentStatus],[CountryFromIP],[CompanyNameFromIP1],[ISPFromIP],[ProvinceFromIP],[CityFromIP],[ZipCodeFromIP],[LatitudeFromIP],[LongitudeFromIP],[HostName],[CompanyDNSName],[CountryName],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_Eloqua_visitors]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
