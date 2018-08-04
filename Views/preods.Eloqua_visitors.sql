SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [preods].[Eloqua_visitors]
AS

SELECT DISTINCT

	CONVERT(nvarchar(255),[visitorId]) [visitorId_K]
	,DATEADD(s,(CONVERT(BIGINT,createdat)),'1970-01-01') [createdAt]
	,CONVERT(NVARCHAR(MAX),[Browser_Type]) [Browser_Type]
	,CONVERT(NVARCHAR(MAX),[IPAddress]) [IPAddress]
	,CONVERT(NVARCHAR(MAX),[Total_Pages]) [Total_Pages]
	,CONVERT(NVARCHAR(MAX),[Total_Time]) [Total_Time]
	,CONVERT(NVARCHAR(MAX),[Total_Visits]) [Total_Visits]
	,CONVERT(NVARCHAR(MAX),[Name]) [Name]
	,CONVERT(NVARCHAR(MAX),[Current_Visit_Length]) [Current_Visit_Length]
	,CONVERT(NVARCHAR(MAX),[Current_Total_Pages]) [Current_Total_Pages]
	,DATEADD(s,(CONVERT(BIGINT,FirstVisitDateAndTime)),'1970-01-01') [FirstVisitDateAndTime]
	,CONVERT(NVARCHAR(MAX),[FirstPageInVisit]) [FirstPageInVisit]
	,CONVERT(NVARCHAR(MAX),[LastPageInVisit]) [LastPageInVisit]
	,DATEADD(s,(CONVERT(BIGINT,LastVisitDateAndTime)),'1970-01-01') [LastVisitDateAndTime]
	,CONVERT(NVARCHAR(MAX),[TimeZoneOffsetMin]) [TimeZoneOffsetMin]
	,CONVERT(NVARCHAR(MAX),[TimeZone]) [TimeZone]
	,CONVERT(NVARCHAR(MAX),[externalId]) [externalId]
	,CONVERT(NVARCHAR(MAX),[contactId]) [contactId]
	,CONVERT(NVARCHAR(MAX),[currentStatus]) [currentStatus]
	,CONVERT(NVARCHAR(MAX),[CountryFromIP]) [CountryFromIP]
	,CONVERT(NVARCHAR(MAX),[CompanyNameFromIP1]) [CompanyNameFromIP1]
	,CONVERT(NVARCHAR(MAX),[ISPFromIP]) [ISPFromIP]
	,CONVERT(NVARCHAR(MAX),[ProvinceFromIP]) [ProvinceFromIP]
	,CONVERT(NVARCHAR(MAX),[CityFromIP]) [CityFromIP]
	,CONVERT(NVARCHAR(MAX),[ZipCodeFromIP]) [ZipCodeFromIP]
	,CONVERT(NVARCHAR(MAX),[LatitudeFromIP]) [LatitudeFromIP]
	,CONVERT(NVARCHAR(MAX),[LongitudeFromIP]) [LongitudeFromIP]
	,CONVERT(NVARCHAR(MAX),[HostName]) [HostName]
	,CONVERT(NVARCHAR(MAX),[CompanyDNSName]) [CompanyDNSName]
	,CONVERT(NVARCHAR(MAX),[CountryName]) [CountryName]
FROM [src].[Eloqua_visitors] WITH (NOLOCK)
GO
