SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [rpt].[vw_Groups] AS

----Groups

SELECT 
	fts.EventCode, 
	SUM(CAST(issold AS INT)) QtySeat, 
	SUM(CASE WHEN fts.pc3 = 'E' THEN .8 * fts.TotalRevenue ELSE fts.TotalRevenue END) BlockPurchasePrice, 
	fts.PriceCodeDesc, 
	fts.PriceCode, 
	fts.IsGroup, 
	CASE WHEN SUM(fts.PaidAmount) > 0 THEN 'Y' ELSE 'N' END AS Paid, 
	CASE WHEN fts.pc3 = 'E' THEN 1 ELSE 0 END AS [E-Type]
FROM etl.vw_FactTicketSeat fts(NOLOCK)
WHERE fts.EventCode LIKE 'eskb[0-1]%' 
	AND fts.IsGroup = 1
	AND not fts.PriceCode LIKE '__G0'
	AND NOT fts.PriceCode LIKE '___B'
GROUP BY 
	CASE WHEN fts.pc3 = 'E' THEN 1
	ELSE 0
	END ,
	fts.EventCode ,
	fts.PriceCodeDesc ,
	fts.PriceCode ,
	fts.IsGroup


GO
