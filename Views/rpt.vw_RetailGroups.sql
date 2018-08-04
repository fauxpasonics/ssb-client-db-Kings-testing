SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [rpt].[vw_RetailGroups] AS

-- Retail Groups


SELECT 
	fts.EventCode, 
	SUM(CAST(issold AS INT)) QtySeat, 
	(SUM(CAST(issold AS INT)) * fts.TotalRevenue) BlockPurchasePrice,
	fts.PriceCodeDesc, fts.PriceCode, fts.RetailQualifiers
FROM etl.vw_FactTicketSeat fts (NOLOCK)
WHERE fts.EventCode LIKE 'eskb[0-1]%' 
	AND (fts.RetailQualifiers LIKE '%lb%' OR fts.RetailQualifiers LIKE '%sc%' OR fts.RetailQualifiers LIKE '%kol%' 
	OR fts.RetailQualifiers LIKE '%shell%' OR fts.RetailQualifiers LIKE '%next%')
GROUP BY fts.EventCode,
    fts.TotalRevenue,
    fts.PriceCodeDesc,
    fts.PriceCode,
    fts.RetailQualifiers
GO
