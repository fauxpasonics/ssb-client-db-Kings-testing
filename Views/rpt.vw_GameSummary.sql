SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [rpt].[vw_GameSummary] AS 

SELECT 
	EventName,
	fts.EventCode,
	EventDate,
	SUM(CASE WHEN fts.TicketTypeCode = 'FS' THEN issold  ELSE 0 END) FullQty,
	SUM(CASE WHEN fts.TicketTypeCode = 'FS' THEN fts.TotalRevenue ELSE 0 END) FullRev,
	SUM(CASE WHEN fts.TicketTypeCode = 'FS' AND PaidAmount = 0 THEN issold  ELSE 0 END) FullUnpaidQty,
	SUM(CASE WHEN fts.TicketTypeCode = 'FS' AND PaidAmount = 0 THEN fts.TotalRevenue ELSE 0 END) FullUnpaidRev,
	SUM(CASE WHEN dt.TicketTypeDesc = 'Partial' THEN issold ELSE 0 END) PartialQty,
	SUM(CASE WHEN dt.TicketTypeDesc = 'Partial' THEN fts.TotalRevenue ELSE 0 END) PartialRev,
	SUM(CASE WHEN dt.TicketTypeCode = 'G' THEN issold ELSE 0 END) GroupQty,
	SUM(CASE WHEN dt.TicketTypeCode = 'G' AND PaidAmount = 0 THEN issold ELSE 0 END) GroupUnpaidQty,
	SUM(CASE WHEN dt.TicketTypeCode = 'G' AND PaidAmount > 0 THEN fts.PaidAmount ELSE 0 END) GroupPaidRev,
	SUM(CASE WHEN dt.TicketTypeCode = 'G' AND PaidAmount = 0 THEN fts.TotalRevenue ELSE 0 END) GroupUnpaidRev,
	SUM(CASE WHEN dt.TicketTypeCode = 'SG' THEN issold ELSE 0 END) SingleQty,
	SUM(CASE WHEN dt.TicketTypeCode = 'SG' THEN fts.TotalRevenue ELSE 0 END) SingleRev,
	SUM(CASE WHEN fts.IsComp = 1 THEN issold ELSE 0 END) CompQty,
	SUM(CASE WHEN fts.issold = 1 THEN 1 ELSE 0 END) TotalSoldQty,
	SUM(CASE WHEN fts.issold = 1 THEN fts.TotalRevenue ELSE 0 END) TotalSoldRev,
	-- Capacity,
	SUM(CASE WHEN fts.SeatTypeCode <> 'STE' THEN fts.IsSold ELSE 0 END) SteQty,
	SUM(CASE WHEN fts.TicketTypeCode = 'FS' AND fts.SeatTypeCode = 'STE' THEN fts.IsSold ELSE 0 END) FSSteQty
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
	EventDate
	--,PlanCode, PlanName, dt.TicketTypeName, fts.PriceCode, fts.SeatTypeName
--ORDER BY eventdate

GO
