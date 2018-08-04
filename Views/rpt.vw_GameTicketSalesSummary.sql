SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE VIEW [rpt].[vw_GameTicketSalesSummary] AS 

SELECT 
	EventName,
	fts.EventCode,
	EventDate,
	CASE
		WHEN fts.IsComp = 1 THEN 'CompQty'  
		WHEN fts.TicketTypeCode = 'FS' AND fts.IsComp = 0 THEN 'Full'
		WHEN dt.TicketTypeDesc = 'Partial Plan' AND fts.IsComp = 0 THEN 'Partial'
		WHEN dt.TicketTypeCode = 'G' THEN 'Group'
		WHEN dt.TicketTypeCode = 'SG' THEN 'Single'
		WHEN fts.TicketTypeCode = 'FS' AND fts.SeatTypeCode = 'STE' THEN 'Full Suite'
		ELSE dt.TicketTypeCode
	END AS TicketType,
	SUM(CAST(fts.issold AS INT)) Qty,
	SUM(fts.TotalRevenue) Rev,
	SUM(fts.PaidAmount) PaidRev
	--SUM(CASE WHEN fts.issold = 1 THEN 1 ELSE 0 END) TotalSoldQty,
	--SUM(CASE WHEN fts.issold = 1 THEN fts.TotalRevenue ELSE 0 END) TotalSoldRev,
	-- Capacity,
	--,PlanCode, PlanName, dt.TicketTypeName, fts.PriceCode, fts.SeatTypeName
FROM etl.vw_FactTicketSeat fts
INNER JOIN [rpt].[vw_DimTicketType] dt
	ON fts.TicketTypeCode = dt.TicketTypeCode
WHERE 1=1 
	--AND fts.IsComp = 0
	--AND fts.SeatTypeCode <> 'STE'
	AND fts.AccountId NOT IN (12571174, 15828988, 14822106)
GROUP BY
	EventName,
	EventCode,
	EventDate,
	CASE
		WHEN fts.IsComp = 1 THEN 'CompQty'  --CHECK WITH ROSS ON TICKETTYPES
		WHEN fts.TicketTypeCode = 'FS' AND fts.IsComp = 0 THEN 'Full'
		WHEN dt.TicketTypeDesc = 'Partial Plan' AND fts.IsComp = 0 THEN 'Partial'
		WHEN dt.TicketTypeCode = 'G' THEN 'Group'
		WHEN dt.TicketTypeCode = 'SG' THEN 'Single'
		WHEN fts.TicketTypeCode = 'FS' AND fts.SeatTypeCode = 'STE' THEN 'Full Suite'
		ELSE dt.TicketTypeCode
	END
	--,PlanCode, PlanName, dt.TicketTypeName, fts.PriceCode, fts.SeatTypeName
--ORDER BY eventdate


GO
