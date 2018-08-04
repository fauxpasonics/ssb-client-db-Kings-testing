SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [rpt].[vw_ZeroPaidFulls] AS

--Zero Paid Fulls

SELECT 
	fts.AccountId, 
	fts.PlanCode, 
	SUM(CAST(issold AS INT)) QtySeat , 
	SUM(fts.TotalRevenue) BlockPurchasePrice , 
	fts.PriceCodeDesc, 
	fts.PriceCode, 
	SUM(fts.PaidAmount) PaidAmount
FROM etl.vw_FactTicketSeat fts 
WHERE fts.TicketTypeCode = 'FS'
	AND fts.IsComp = 0
	AND fts.SeatTypeCode <> 'STE'
	AND fts.AccountId NOT IN (12571174, 15828988, 14822106)
GROUP BY fts.AccountId ,
         fts.PlanCode ,
         fts.PriceCodeDesc ,
         fts.PriceCode
HAVING SUM(fts.PaidAmount) = 0

GO
