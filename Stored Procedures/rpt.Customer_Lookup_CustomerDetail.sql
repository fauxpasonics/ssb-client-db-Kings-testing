SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



--exec [rpt].[Customer_Lookup_CustomerDetail]  578162

create PROCEDURE  [rpt].[Customer_Lookup_CustomerDetail] 


(
@CustomerId INT
)

AS 

BEGIN 

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED


DECLARE @SP_Customer INT = @CustomerId


SELECT 
case grouping_id(AccountId, FirstName, LastName, SeasonName, EventName, EventDate,Ticket_Type,
PriceCode, PriceCodeDesc) when 479 then 'Summary' else 'Detail' end as RollupType
,AccountId, FirstName, LastName, SeasonName, EventName, EventDate,Ticket_Type,
PriceCode, PriceCodeDesc, sum(Qty) Qty, sum(Rev) Rev
FROM
(
	SELECT
		DimCustomer.AccountId
		, DimCustomer.FirstName
		, DimCustomer.LastName
		, DimSeasonHeader.SeasonName
		, DimEventHeader.EventName
		, DimEventHeader.EventDate
		, dtc.TicketClassName AS Ticket_Type
		, fts.DimTicketClassId
		, PriceCode.PriceCode
		, PriceCode.PriceCodeDesc
		, SUM(fts.QtySeat) Qty
		, SUM(fts.BlockPurchasePrice) Rev
	FROM dbo.FactTicketSales fts
		INNER JOIN dbo.DimTicketClass dtc 
			ON dtc.DimTicketClassId = fts.DimTicketClassId
		INNER JOIN dbo.DimSeason ds 
			ON ds.DimSeasonId = fts.DimSeasonId
		INNER JOIN dbo.DimPriceCode PriceCode
			ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimDate DimDate
			ON DimDate.DimDateId = fts.DimDateId
		INNER JOIN dbo.DimCustomer DimCustomer
			ON DimCustomer.DimCustomerId = fts.DimCustomerId
		LEFT JOIN rpt.vw_DimEvent DimEvent
			ON DimEvent.DimEventId = fts.DimEventId
		LEFT JOIN rpt.vw_DimEventHeader DimEventHeader
			ON DimEventHeader.DimEventHeaderId = DimEvent.DimEventHeaderId
		LEFT JOIN rpt.vw_DimSeasonHeader DimSeasonHeader
			ON DimSeasonHeader.DimSeasonHeaderId = DimEventHeader.DimSeasonHeaderId
		
	WHERE 
		fts.DimTicketClassId NOT IN (18, 19,20)
		AND DimCustomer.DimCustomerId = @SP_Customer
		AND dtc.TicketClassName IS NOT NULL 
	GROUP BY 
		DimCustomer.AccountId
		, DimCustomer.FirstName
		, DimCustomer.LastName
		, DimSeasonHeader.SeasonName
		, DimEventHeader.EventName
		, DimEventHeader.EventDate
		, dtc.TicketClassName 
		, fts.DimTicketClassId
		, PriceCode.PriceCode
		, PriceCode.PriceCodeDesc

	UNION ALL


	SELECT 
		DimCustomer.AccountId
		, DimCustomer.FirstName
		, DimCustomer.LastName	
		, DimSeasonHeader.SeasonName
		, DimEventHeader.EventName
		, DimEventHeader.EventDate
		, dtc.TicketClassName
		, fts.DimTicketClassId 
		, PriceCode.PriceCode
		, PriceCode.PriceCodeDesc 
		, CASE WHEN fts.SSID_row_id = 1 AND fts.SSID_seat_num = 1 AND fts.DimTicketClassId IN (20) THEN COUNT(DISTINCT fts.DimEventID + '' + fts.SSID_Section_id) 
			 WHEN fts.SSID_row_id = 1 AND fts.SSID_seat_num = 1 AND fts.DimTicketClassId IN (18, 19) THEN COUNT(DISTINCT fts.SSID_Section_id) 
			 ELSE 0 END AS QTY
		, fts.BlockPurchasePrice Rev
	FROM dbo.FactTicketSales fts
		INNER JOIN dbo.DimTicketClass dtc 
			ON dtc.DimTicketClassId = fts.DimTicketClassId
		INNER JOIN dbo.DimSeason ds 
			ON ds.DimSeasonId = fts.DimSeasonId
		INNER JOIN dbo.DimPriceCode PriceCode
			ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimDate DimDate
			ON DimDate.DimDateId = fts.DimDateId
		INNER JOIN dbo.DimCustomer DimCustomer
			ON DimCustomer.DimCustomerId = fts.DimCustomerId
		LEFT JOIN rpt.vw_DimEvent DimEvent
			ON DimEvent.DimEventId = fts.DimEventId
		LEFT JOIN rpt.vw_DimEventHeader DimEventHeader
			ON DimEventHeader.DimEventHeaderId = DimEvent.DimEventHeaderId
		LEFT JOIN rpt.vw_DimSeasonHeader DimSeasonHeader
			ON DimSeasonHeader.DimSeasonHeaderId = DimEventHeader.DimSeasonHeaderId
	WHERE 
		fts.DimTicketClassId IN (18, 19, 20)
		AND DimCustomer.DimCustomerId = @SP_Customer
		AND dtc.TicketClassName IS NOT NULL
	GROUP BY 
		dtc.TicketClassName
		, fts.SSID_row_id
		, fts.SSID_seat_num
		, ds.SeasonYear
		, fts.DimTicketClassId
		, fts.SSID_section_id
		, DimDate.CalDate
		, DimCustomer.AccountId
		, DimCustomer.FirstName
		, DimCustomer.LastName
		, fts.BlockPurchasePrice
		, DimSeasonHeader.SeasonName
		, DimEventHeader.EventName
		, DimEventHeader.EventDate
		, PriceCode.PriceCode
		, PriceCode.PriceCodeDesc 
	HAVING 
		CASE WHEN fts.SSID_row_id = 1 AND fts.SSID_seat_num = 1 AND fts.DimTicketClassId IN (20) THEN COUNT(DISTINCT fts.DimEventID + '' + fts.SSID_Section_id) 
			 WHEN fts.SSID_row_id = 1 AND fts.SSID_seat_num = 1 AND fts.DimTicketClassId IN (18, 19) THEN COUNT(DISTINCT fts.SSID_Section_id) 
			 ELSE 0 END <> 0 
)x
group by grouping sets((SeasonName),(AccountId, FirstName, LastName, SeasonName, EventName, EventDate,Ticket_Type,
PriceCode, PriceCodeDesc))

ORDER BY
	x.SeasonName ,
	x.EventName ,
	x.EventDate ,
	x.Ticket_Type ,	
	x.PriceCode ,
	x.PriceCodeDesc

END






GO
