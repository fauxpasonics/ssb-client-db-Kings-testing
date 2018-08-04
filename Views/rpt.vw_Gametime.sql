SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [rpt].[vw_Gametime] AS


-- Gametime

SELECT 
	fts.EventCode, SUM(CAST(issold AS INT)) QtySeat ,  
	fts.TotalRevenue BlockPurchasePrice,
	fts.PriceCodeDesc, 
	fts.PriceCode, 
	fts.IsGroup,
	CASE WHEN paidamount > 0 THEN 'Y' ELSE 'N' END AS Paid
FROM etl.vw_FactTicketSeat fts (NOLOCK)
--INNER JOIN ods.TM_PaySchedule tmj 
--	ON fts.AccountId = tmj.acct_id
WHERE fts.EventCode LIKE 'eskb[0-1]%' 
	AND ( fts.pc3 = 'G' AND PC4 = '0')
GROUP BY 
CASE WHEN paidamount > 0 THEN 'Y'
	ELSE 'N'
	END ,
	fts.EventCode ,
	fts.TotalRevenue ,
	fts.PriceCodeDesc ,
	fts.PriceCode ,
	fts.IsGroup



GO
