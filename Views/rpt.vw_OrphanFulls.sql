SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [rpt].[vw_OrphanFulls] AS


-- Orphan Fulls

SELECT 
	fts.EventCode, 
	SUM(CAST(issold AS INT)) QtySeat , 
	(SUM(CAST(issold AS INT)) * fts.TotalRevenue) BlockPurchasePrice,
	fts.PriceCodeDesc, 
	fts.PriceCode, 
	fts.IsGroup, 
	CASE WHEN SUM(fts.PaidAmount) > 0 THEN 'Y' ELSE 'N' END AS Paid
FROM etl.vw_FactTicketSeat fts (NOLOCK)
INNER JOIN ods.TM_PaySchedule tmj (NOLOCK)
	ON fts.AccountId = tmj.acct_id
WHERE fts.EventCode LIKE 'eskb[0-1]%' 
	AND ISPLAN = 0 
	AND fts.pc3 IN ('N', 'K', 'L', 'D', 'T', 'R')
GROUP BY  
          fts.EventCode ,
          fts.TotalRevenue ,
          fts.PriceCodeDesc ,
          fts.PriceCode ,
          fts.IsGroup


GO
