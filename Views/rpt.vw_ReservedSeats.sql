SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [rpt].[vw_ReservedSeats] AS

-- Reserved Seats


SELECT 
	e.EventCode,
	e.EventDate, 
	ds.SectionName, 
	ds.RowName, 
	ds.Seat, 
	SUM(CAST(fts.Isheld AS INT)) QtyHeldSeat, 
	dpc.PriceCode, 
	dpc.PriceCodeDesc,
	(SUM(CAST(fts.Isheld AS INT)) * fts.HeldSeatValue) BlockPurchasePrice,
	--, datetime, hours held (how to figure this out?),
	CASE WHEN dpc.PC3 IN ('G', 'E') THEN 1 ELSE 0 END AS [Group?]
FROM rpt.vw_FactInventory fts (NOLOCK)
LEFT JOIN dbo.DimClassTM (NOLOCK)
	ON fts.HeldDimClassTMId = DimClassTMId
INNER JOIN rpt.vw_DimEvent e (NOLOCK)
	ON e.DimEventId = fts.DimEventId
INNER JOIN rpt.vw_DimSeat ds (NOLOCK)
	ON ds.DimSeatId = fts.DimSeatId
LEFT JOIN dbo.DimPriceCode dpc (NOLOCK)
	ON fts.HeldDimPriceCodeId = dpc.DimPriceCodeId
WHERE isheld = 1
	AND dpc.PC1 <> 'S'
GROUP BY  fts.HeldSeatValue,
	CASE WHEN dpc.PC3 IN ( 'G', 'E' ) THEN 1
	ELSE 0
	END ,
	e.EventCode ,
	e.EventDate ,
	ds.SectionName ,
	ds.RowName ,
	ds.Seat ,
	dpc.PriceCode ,
	dpc.PriceCodeDesc



GO
