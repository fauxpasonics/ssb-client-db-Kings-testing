SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [rpt].[vw_AvailableInventory] AS

-- Available Inventory


SELECT 
	e.EventCode, 
	ds.SectionName, 
	ds.RowName, 
	ds.Seat, 
	SUM(CAST(fts.IsAvailable AS INT)) QtyAvailableSeat, 
	ClassName, 
	DistName, 
	fts.PostedSeatValue, 
	dpc.PC2 PriceLevel,
	(SUM(CAST(fts.IsAvailable AS INT))* fts.PostedSeatValue) BlockfullPrice
FROM rpt.vw_FactInventory fts (NOLOCK)
LEFT JOIN dbo.DimClassTM (NOLOCK)
	ON fts.PostedDimClassTMId = DimClassTMId
INNER JOIN rpt.vw_DimEvent e (NOLOCK)
	ON e.DimEventId = fts.DimEventId
INNER JOIN rpt.vw_DimSeat ds (NOLOCK)
	ON ds.DimSeatId = fts.DimSeatId
LEFT JOIN dbo.DimPriceCode dpc (NOLOCK)
	ON fts.PostedDimPriceCodeId = dpc.DimPriceCodeId
WHERE fts.IsAvailable = 1 
	AND (dpc.PC1 <> 'S' OR DistName = 'OPEN') 
	AND ClassName <> 'AFTERGAMEKILL' 
GROUP BY 
    e.EventCode ,
    ds.SectionName ,
    ds.RowName ,
    ds.Seat ,
    ClassName ,
    DistName ,
    fts.PostedSeatValue ,
    dpc.PC2
	--ORDER BY e.EventCode desc



GO
