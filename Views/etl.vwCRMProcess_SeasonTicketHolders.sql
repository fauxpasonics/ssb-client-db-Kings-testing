SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [etl].[vwCRMProcess_SeasonTicketHolders]
AS

SELECT DISTINCT CAST(dc.SSID AS VARCHAR(50)) SSID
, CAST(SeasonYear AS VARCHAR(50)) SeasonYear
, CAST(ds.SeasonYear + '-' + CONVERT(VARCHAR,(CAST(ds.SeasonYear AS INT) + 1)) AS VARCHAR(50)) SeasonYr
       FROM dbo.FactTicketSales f
       INNER JOIN dbo.DimCustomer dc ON dc.DimCustomerId = f.DimCustomerId
	   INNER JOIN dbo.DimTicketType dtt ON dtt.DimTicketTypeId = f.DimTicketTypeId
       INNER JOIN dbo.DimSeason ds ON ds.DimSeasonId = f.DimSeasonId
       WHERE f.[DimTicketTypeId] =  1
       AND ds.SeasonName LIKE '%Kings%'

GO
