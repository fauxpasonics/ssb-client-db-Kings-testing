CREATE TABLE [src].[Eloqua_visitors]
(
[SK] [bigint] NULL,
[ETL__multi_query_value_for_audit] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[L1_AllData_page] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[L1_AllData_pageSize] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[L1_AllData_total] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[L2_AllData_elements_] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[L3_AllData_elements_type] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[visitorId] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[createdAt] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Browser_Type] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IPAddress] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Total_Pages] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Total_Time] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Total_Visits] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Name] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Current_Visit_Length] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Current_Total_Pages] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FirstVisitDateAndTime] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FirstPageInVisit] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastPageInVisit] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastVisitDateAndTime] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TimeZoneOffsetMin] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TimeZone] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[externalId] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contactId] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[currentStatus] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CountryFromIP] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CompanyNameFromIP1] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ISPFromIP] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ProvinceFromIP] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CityFromIP] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ZipCodeFromIP] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LatitudeFromIP] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LongitudeFromIP] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[HostName] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CompanyDNSName] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CountryName] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
