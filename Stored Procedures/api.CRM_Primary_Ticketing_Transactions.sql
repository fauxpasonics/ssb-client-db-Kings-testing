SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



















--EXEC [API].[CRM_Primary_Ticketing_Transactions] @SSB_CRMSYSTEM_CONTACT_ID = '0011A751-07BD-40B1-AC25-A499DC58DDD4', @DisplayTable = 1

CREATE PROCEDURE [api].[CRM_Primary_Ticketing_Transactions]
    @SSB_CRMSYSTEM_ACCT_ID VARCHAR(50) = 'Test',
	@SSB_CRMSYSTEM_CONTACT_ID VARCHAR(50) = 'Test',
	  @DisplayTable INT = 0,
	  @RowsPerPage  INT = 500, @PageNumber   INT = 0
AS
    BEGIN 

-- Init vars needed for API
DECLARE @totalCount         INT,
		@xmlDataNode        XML,
		@recordsInResponse  INT,
		@remainingCount     INT,
		@rootNodeName       NVARCHAR(100),
		@responseInfoNode   NVARCHAR(MAX),
		@finalXml           XML

	/*
DECLARE @SSB_CRMSYSTEM_CONTACT_ID VARCHAR(50) = '8F98286C-7875-42C1-91BD-196B3A64A112'
DECLARE	@RowsPerPage  INT = 500, @PageNumber   INT = 0
DECLARE @DisplayTable INT = 0
*/


PRINT 'Acct-' + @SSB_CRMSYSTEM_ACCT_ID
PRINT 'Contact-' + @SSB_CRMSYSTEM_CONTACT_ID

DECLARE @GUIDTable TABLE (
GUID VARCHAR(50)
)

IF (@SSB_CRMSYSTEM_ACCT_ID NOT IN ('None','Test'))
BEGIN
	INSERT INTO @GUIDTable
	        ( GUID )
	SELECT DISTINCT z.SSB_CRMSYSTEM_CONTACT_ID
		FROM Kings.dbo.vwDimCustomer_ModAcctId z 
		WHERE z.SSB_CRMSYSTEM_ACCT_ID = @SSB_CRMSYSTEM_ACCT_ID
END

IF (@SSB_CRMSYSTEM_CONTACT_ID NOT IN ('None','Test'))
BEGIN
	INSERT INTO @GUIDTable
	        ( GUID )
	SELECT @SSB_CRMSYSTEM_CONTACT_ID
END


 SELECT  *
		, CASE WHEN Ticket_Type_Name='Full Season' AND Seat_Type_Name NOT IN('Premium','Suite') THEN CAST(Season_Year AS VARCHAR(10))+' '+'Season Tickets'
			WHEN Ticket_Type_Name='Half Season' AND Seat_Type_Name NOT IN('Premium','Suite') THEN CAST(Season_Year AS VARCHAR(10))+' '+'Half Season Tickets'
			WHEN Ticket_Type_Name='Group' AND Seat_Type_Name NOT IN('Premium','Suite') THEN CAST(Season_Year AS VARCHAR(10))+' '+'Group Tickets'
			WHEN Ticket_Type_Name='Single Game' AND Seat_Type_Name NOT IN('Premium','Suite') THEN CAST(Season_Year AS VARCHAR(10))+' '+'Single Game Tickets'
			WHEN Seat_Type_Name='Premium' THEN CAST(Season_Year AS VARCHAR(10))+' '+'Premium Tickets'
			WHEN Seat_Type_Name='Suite' THEN CAST(Season_Year AS VARCHAR(10))+' '+'Suite Tickets'
			WHEN x.Ticket_Type_Name LIKE '%-TYPE' AND x.Seat_Type_Name IS NULL THEN CAST(x.Season_Year AS VARCHAR(10))+' '+'Retail Sales'
			 ELSE CAST(Season_Year AS VARCHAR(10))+' '+'Unknown' END AS Tier1
		INTO #tmpBase
        FROM    ( SELECT    *
                  FROM      ( SELECT    ssbid.SSB_CRMSYSTEM_CONTACT_ID
                                      , CAST(DimDate.CalDate AS DATE) AS Order_Date
                                      , DimSeason.SeasonYear AS Season_Year
                                      , DimEvent.EventCode AS Event_Code
                                      , DimEvent.EventName AS Event_Name
                                      , DimPriceCode.PriceCode AS Price_Code
                                      , DimPriceCode.PriceCodeDesc AS Price_Code_Description
                                      , DimItem.ItemCode AS Item_Code
                                      , DimTicketType.TicketTypeName AS Ticket_Type_Name
                                      , DimSeatType.SeatTypeName AS Seat_Type_Name
                                      , DimSeat.SectionName AS Section_Name
                                      , DimSeat.RowName AS Row_Name
                                      , fts.QtySeat AS Qty_Seat
									  , CAST(fi.Attended AS VARCHAR(10)) AS Attended
                                      , fts.BlockPurchasePrice AS Block_Purchase_Price
                                      , fts.PaidAmount AS Paid_Amount
                              FROM      dbo.FactTicketSales fts WITH ( NOLOCK )
                                        INNER JOIN rpt.vw_DimPriceCode DimPriceCode
                                        WITH ( NOLOCK ) ON DimPriceCode.DimPriceCodeId = fts.DimPriceCodeId
                                        INNER JOIN rpt.vw_DimTicketType DimTicketType
                                        WITH ( NOLOCK ) ON DimTicketType.DimTicketTypeId = fts.DimTicketTypeId
                                        INNER JOIN rpt.vw_DimSeatType DimSeatType
                                        WITH ( NOLOCK ) ON DimSeatType.DimSeatTypeId = fts.DimSeatTypeId
                                        INNER JOIN dbo.DimCustomer DimCustomer
                                        WITH ( NOLOCK ) ON DimCustomer.DimCustomerId = fts.DimCustomerId
                                                           AND DimCustomer.CustomerType = 'Primary'
                                                           AND DimCustomer.SourceSystem = 'TM'
                                        INNER JOIN rpt.vw_DimDate DimDate WITH ( NOLOCK ) ON DimDate.DimDateId = fts.DimDateId
                                        INNER JOIN rpt.vw_DimSeason DimSeason
                                        WITH ( NOLOCK ) ON DimSeason.DimSeasonId = fts.DimSeasonId
                                        INNER JOIN rpt.vw_DimEvent DimEvent
                                        WITH ( NOLOCK ) ON DimEvent.DimEventId = fts.DimEventId
                                        INNER JOIN dbo.dimcustomerssbid ssbid
                                        WITH ( NOLOCK ) ON ssbid.DimCustomerId = fts.DimCustomerId
                                        INNER JOIN rpt.vw_DimSalesCode DimSaleCode
                                        WITH ( NOLOCK ) ON DimSaleCode.DimSalesCodeId = fts.DimSalesCodeId
                                        INNER JOIN rpt.vw_DimPromo DimPromo
                                        WITH ( NOLOCK ) ON DimPromo.DimPromoID = fts.DimPromoId
                                        INNER JOIN rpt.vw_DimSeat DimSeat WITH ( NOLOCK ) ON DimSeat.DimSeatId = fts.DimSeatIdStart
                                        INNER JOIN rpt.vw_DimItem DimItem WITH ( NOLOCK ) ON DimItem.DimItemId = fts.DimItemId
                                        INNER JOIN rpt.vw_DimPlan DimPlan WITH ( NOLOCK ) ON DimPlan.DimPlanId = fts.DimPlanId
                                        Left JOIN ( SELECT FactTicketSalesId
                                                          , SUM(CAST(IsAttended AS INT)) Attended
                                                     FROM   rpt.vw_FactInventory
                                                     GROUP BY FactTicketSalesId
                                                   ) fi ON fi.FactTicketSalesId = fts.FactTicketSalesId
							   WHERE  DimSeason.SeasonYear >= 2013 
							   --AND DimSeason.DimArenaId IN(1,2,3)
							   
									  AND ssbid.SSB_CRMSYSTEM_CONTACT_ID IN (SELECT GUID FROM @GUIDTable) 
                            ) cy
			UNION ALL
			SELECT * FROM (SELECT ssbid.SSB_CRMSYSTEM_CONTACT_ID
								, MAX(CAST(rtb.transaction_datetime AS DATE)) AS Order_Date
								, YEAR(rtb.event_date) AS Season_Year
								, rtb.retail_event_code AS Event_Code
								, rte.attraction_name AS Event_Name
								, CAST(rtb.retail_price_level AS VARCHAR(10)) AS Price_Code
								, NULL AS Price_Code_Description
								, rtb.retail_event_code AS Item_Code
								, rtb.retail_ticket_type AS Ticket_Type_Name
								, NULL AS Seat_Type_Name
								, rtb.section_name AS Section_Name
								, rtb.row_name AS Row_Name
								, rtb.num_seats AS Qty_Seat
								, NULL AS Attended
								, rtb.retail_purchase_price AS Block_Purchase_Price
								, rtb.retail_purchase_price AS Paid_Amount FROM rpt.vw_RetailTicketBase rtb WITH (NOLOCK)
								INNER JOIN dbo.DimCustomer dc 
								WITH (NOLOCK) ON dc.AccountId=rtb.acct_id
												AND dc.CustomerType='Primary'
												AND dc.SourceSystem='TM'
								INNER JOIN dbo.DimCustomerSSBID ssbid 
								WITH (NOLOCK) ON ssbid.DimCustomerId = dc.DimCustomerId
								INNER JOIN ods.TM_RetailEvent rte
								WITH (NOLOCK) ON rte.host_event_id = rtb.retail_event_id
								WHERE ssbid.SSB_CRMSYSTEM_CONTACT_ID IN (SELECT GUID FROM @GUIDTable)
								GROUP BY YEAR(rtb.event_date) ,
                                         CAST(rtb.retail_price_level AS VARCHAR(10)) ,
                                         ssbid.SSB_CRMSYSTEM_CONTACT_ID ,
                                         rtb.transaction_datetime ,
                                         rtb.retail_event_code ,
                                         rte.attraction_name ,
                                         rtb.retail_event_code ,
                                         rtb.retail_ticket_type ,
                                         rtb.section_name ,
                                         rtb.row_name ,
                                         rtb.num_seats ,
                                         rtb.retail_purchase_price ,
                                         rtb.retail_purchase_price)rts)x
								   WHERE   x.Season_Year >= 2013 
                AND x.SSB_CRMSYSTEM_CONTACT_ID IN (SELECT GUID FROM @GUIDTable)
        ORDER BY x.Season_Year
              , x.Ticket_Type_Name
              --, x.Event_Date

SELECT 
ISNULL(Order_Date					,'')	Order_Date
, ISNULL(Season_Year				,'')	Season_Year
, ISNULL(Event_Code					,'')	Event_Code
, ISNULL(Event_Name					,'')	Event_Name
--, ISNULL(Event_Date					,'')	Event_Date
, ISNULL(Price_Code					,'')	Price_Code
, ISNULL(Price_Code_Description		,'')	Price_Code_Description
--, ISNULL(Sales_Code					,'')	Sales_Code
--, ISNULL(Sales_Code_Name			,'')	Sales_Code_Name
, ISNULL(Item_Code					,'')	Item_Code
--, ISNULL(Item_Name					,'')	Item_Name
, ISNULL(Ticket_Type_Name			,'')	Ticket_Type_Name
--, ISNULL(Plan_Type_Name				,'')	Plan_Type_Name
, ISNULL(Seat_Type_Name				,'')	Seat_Type_Name
, ISNULL(Section_Name				,'')	Section_Name
, ISNULL(Row_Name					,'')	Row_Name
, ISNULL(Qty_Seat		 			,'')	Qty_Seat
, ISNULL(Attended , '') Qty_Attended
, CASE WHEN SIGN(Block_Purchase_Price)<0 THEN '-' ELSE '' END + '$' + ISNULL(CONVERT(VARCHAR(12),CAST(ABS(Block_Purchase_Price) AS DECIMAL(18,2))), '0.00') AS Block_Purchase_Price
--, ISNULL(Paid_Status		 		,'')	Paid_Status
, CASE WHEN SIGN(Paid_Amount)<0 THEN '-' ELSE '' END + '$' + ISNULL(CONVERT(VARCHAR(12),CAST(ABS(Paid_Amount) AS DECIMAL(18,2))), '0.00') AS Paid_Amount
--, CASE WHEN SIGN(Owed_Amount)<0 THEN '-' ELSE '' END + '$' + ISNULL(CONVERT(VARCHAR(12),CAST(ABS(Owed_Amount) AS DECIMAL(18,2))), '0.00') AS Owed_Amount
, ISNULL(Tier1						,'') Tier
INTO #tmpOutput
FROM #tmpBase
ORDER BY ORDER_DATE DESC
OFFSET (@PageNumber) * @RowsPerPage ROWS
FETCH NEXT @RowsPerPage ROWS ONLY

--SELECT * FROM #tmpBase
SELECT Tier1 Ticket_Type
, Season_Year, Ticket_Type_Name
, CASE WHEN SIGN(SUM(Paid_Amount))<0 THEN '-' ELSE '' END + '$' + ISNULL(CONVERT(VARCHAR(12),ABS( CAST(SUM(Paid_Amount) AS DECIMAL(18,2)))), '0.00') AS Paid_Amount
, CASE WHEN SIGN(SUM(Block_Purchase_Price))<0 THEN '-' ELSE '' END + '$' + ISNULL(CONVERT(VARCHAR(12),ABS( CAST(SUM(Block_Purchase_Price) AS DECIMAL(18,2) ))), '0.00') AS Order_Value
, CAST(ISNULL(SUM(Paid_Amount) / NULLIF(CAST(SUM(Block_Purchase_Price) AS FLOAT),0),0)*100 AS VARCHAR(50)) + '%' AS 'Paid'
INTO #tmpParent
FROM #tmpBase
GROUP BY Tier1, Season_Year, Ticket_Type_Name
-- DROP TABLE #tmpParent

-- Pull counts
SELECT @recordsInResponse = COUNT(*) FROM #tmpOutput
SELECT @totalCount = COUNT(*) FROM #tmpBase

SET @xmlDataNode = ( SELECT * ,
                            ( SELECT    a.Order_Date ,
                                        a.Item_Code ,
                                        --a.Item_Name ,
                                        a.Event_Code ,
                                        a.Event_Name ,
                                        --a.Event_Date ,
                                        a.Price_Code ,
                                        a.Price_Code_Description ,
                                        --a.Sales_Code ,
                                        --a.Sales_Code_Name ,
                                        --a.Ticket_Type_Name ,
                                        --a.Plan_Type_Name ,
                                        a.Seat_Type_Name ,
                                        a.Section_Name ,
                                        a.Row_Name ,
                                        a.Qty_Seat ,
										a.Qty_Attended ,
                                        a.Block_Purchase_Price ,
                                        --a.Paid_Status ,
                                        a.Paid_Amount 
                                        --a.Owed_Amount
                              FROM      #tmpOutput a
                              WHERE     a.Season_Year = p.Season_Year
                                        AND a.Ticket_Type_Name = p.Ticket_Type_Name
                              --ORDER BY  a.Event_Date ASC
                            FOR
                              XML PATH('Child') ,
                                  TYPE
                            ) AS 'Children'
                     FROM   #tmpParent p
                     ORDER BY p.Season_Year DESC ,
                            p.Order_Value DESC
                   FOR
                     XML PATH('Parent') ,
                         ROOT('Parents')
                   );

SET @rootNodeName = 'Parents'

-- Calculate remaining count
SET @remainingCount = @totalCount - (@RowsPerPage * (@PageNumber + 1))
IF @remainingCount < 0
BEGIN
	SET @remainingCount = 0
END

-- Create response info node
SET @responseInfoNode = ('<ResponseInfo>'
	+ '<TotalCount>' + CAST(@totalCount AS NVARCHAR(20)) + '</TotalCount>'
	+ '<RemainingCount>' + CAST(@remainingCount AS NVARCHAR(20)) + '</RemainingCount>'
	+ '<RecordsInResponse>' + CAST(@recordsInResponse AS NVARCHAR(20)) + '</RecordsInResponse>'
	+ '<PagedResponse>true</PagedResponse>'
	+ '<RowsPerPage>' + CAST(@RowsPerPage AS NVARCHAR(20)) + '</RowsPerPage>'
	+ '<PageNumber>' + CAST(@PageNumber AS NVARCHAR(20)) + '</PageNumber>'
	+ '<RootNodeName>' + @rootNodeName + '</RootNodeName>'
	+ '</ResponseInfo>')

	PRINT @responseInfoNode
	
-- Wrap response info and data, then return	
IF @xmlDataNode IS NULL
BEGIN
	SET @xmlDataNode = '<' + @rootNodeName + ' />' 
END
		
SET @finalXml = '<Root>' + @responseInfoNode + CAST(@xmlDataNode AS NVARCHAR(MAX)) + '</Root>'

IF @DisplayTable = 1
SELECT * FROM #tmpBase

IF @DisplayTable = 0
SELECT CAST(@finalXml AS XML)

DROP TABLE #tmpBase
DROP TABLE #tmpOutput
DROP TABLE #tmpParent
   END





   















GO
