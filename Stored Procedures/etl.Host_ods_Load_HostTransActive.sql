SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [etl].[Host_ods_Load_HostTransActive]

AS
BEGIN

	SELECT DISTINCT Tm_event_name INTO #EventsRDF
	FROM ods.TM_Evnt
	WHERE [Plan] = 'Y'
	OR Event_id IN (
		SELECT DISTINCT event_id
		FROM ods.TM_Tkt
		WHERE ssbIsHost = 1
	)
	


	SELECT DISTINCT EVENT_CODE INTO #EventsHost
	FROM ods.Host_Trans
	WHERE EVENT_CODE NOT IN (
	SELECT Tm_event_name FROM #EventsRDF
	)

	CREATE NONCLUSTERED INDEX [IX_EVENT_CODE] ON #EventsHost (EVENT_CODE)	
	

	SELECT
	ACCOUNT, ACCOUNT_MODE, EVENT_CODE, SALEDATE, SEATINFO, TICKETS, TRANSACTION_AMOUNT, TRANSACTION_NUM
	, EVENTDATE, PERFNAME, PRIMARYACT, SECONDARYACT, TM_EVENT_ID, TM_MAJORCATNAME, TM_MINORCATNAME, VAXNAME, VENUENAME, VENUENUM
	, CAMEFROM_CODE, DELIVERY_METHOD_DESCRIPTION, EXTRA1, EXTRA2, INTERACTION_SOURCE, OPT_IN_FLAG, PAYMENT_SUBMETHOD, QUALIFIERS
	, ETL__SourceFileName
	, CAST(HASHBYTES('sha2_256', ISNULL(RTRIM(ACCOUNT),'DBNULL_TEXT') + ISNULL(RTRIM(ACCOUNT_MODE),'DBNULL_TEXT') + ISNULL(RTRIM(CAMEFROM_CODE),'DBNULL_TEXT') + ISNULL(RTRIM(DELIVERY_METHOD_DESCRIPTION),'DBNULL_TEXT') + ISNULL(RTRIM(EVENT_CODE),'DBNULL_TEXT') + ISNULL(RTRIM(CONVERT(varchar(25),EVENTDATE)),'DBNULL_DATETIME') + ISNULL(RTRIM(EXTRA1),'DBNULL_TEXT') + ISNULL(RTRIM(EXTRA2),'DBNULL_TEXT') + ISNULL(RTRIM(INTERACTION_SOURCE),'DBNULL_TEXT') + ISNULL(RTRIM(OPT_IN_FLAG),'DBNULL_TEXT') + ISNULL(RTRIM(PAYMENT_SUBMETHOD),'DBNULL_TEXT') + ISNULL(RTRIM(PERFNAME),'DBNULL_TEXT') + ISNULL(RTRIM(PRIMARYACT),'DBNULL_TEXT') + ISNULL(RTRIM(QUALIFIERS),'DBNULL_TEXT') + ISNULL(RTRIM(CONVERT(varchar(25),SALEDATE)),'DBNULL_DATETIME') + ISNULL(RTRIM(SEATINFO),'DBNULL_TEXT') + ISNULL(RTRIM(SECONDARYACT),'DBNULL_TEXT') + ISNULL(RTRIM(CONVERT(varchar(10),TICKETS)),'DBNULL_INT') + ISNULL(RTRIM(TM_EVENT_ID),'DBNULL_TEXT') + ISNULL(RTRIM(TM_MAJORCATNAME),'DBNULL_TEXT') + ISNULL(RTRIM(TM_MINORCATNAME),'DBNULL_TEXT') + ISNULL(RTRIM(CONVERT(varchar(25),TRANSACTION_AMOUNT)),'DBNULL_NUMBER') + ISNULL(RTRIM(CONVERT(varchar(10),TRANSACTION_NUM)),'DBNULL_INT') + ISNULL(RTRIM(VAXNAME),'DBNULL_TEXT') + ISNULL(RTRIM(VENUENAME),'DBNULL_TEXT') + ISNULL(RTRIM(CONVERT(varchar(10),VENUENUM)),'DBNULL_INT')) AS BINARY(32)) ETL_DeltaHashKey
	INTO #Trans
	FROM (
		SELECT ACCOUNT, ACCOUNT_MODE, EVENT_CODE, SALEDATE, SEATINFO, TICKETS, TRANSACTION_AMOUNT, TRANSACTION_NUM
		, EVENTDATE, PERFNAME, PRIMARYACT, SECONDARYACT, TM_EVENT_ID, TM_MAJORCATNAME, TM_MINORCATNAME, VAXNAME, VENUENAME, VENUENUM
		, CAMEFROM_CODE, DELIVERY_METHOD_DESCRIPTION, EXTRA1, EXTRA2, INTERACTION_SOURCE, OPT_IN_FLAG, PAYMENT_SUBMETHOD, QUALIFIERS
		, ETL__SourceFileName, a.Calc_HostAccountId		
		, ROW_NUMBER() OVER(PARTITION BY ACCOUNT, EVENT_CODE, SEATINFO, TICKETS ORDER BY SALEDATE DESC, ETL__SourceFileName DESC, TRANSACTION_NUM desc, ETL__ID desc) AS RowRank
		FROM (
			SELECT t.*
			FROM (SELECT * FROM ods.Host_Trans WHERE VOIDED_FLAG = 0 AND CANCELLED = 0) t
			LEFT OUTER JOIN (SELECT *, CASE WHEN CANCELLED = 1 THEN '3000-01-01' ELSE VOIDED_DATE END ReturnDate  FROM ods.Host_Trans WHERE VOIDED_FLAG = 1 or CANCELLED = 1) r
				ON t.ACCOUNT = r.ACCOUNT AND t.EVENT_CODE = r.EVENT_CODE AND t.SEATINFO = r.SEATINFO AND t.TICKETS = r.TICKETS AND r.ReturnDate > t.SALEDATE
			WHERE r.ACCOUNT IS NULL
			AND t.EVENT_CODE IN (SELECT DISTINCT EVENT_CODE FROM #EventsHost)
		) a
	) a
	WHERE RowRank = 1


	CREATE NONCLUSTERED INDEX [IX_LoadKey] ON #Trans (ACCOUNT)
		INCLUDE (EVENT_CODE, TICKETS, SEATINFO) 

	CREATE NONCLUSTERED INDEX [IX_ETL_DeltaHashKey] ON #Trans (ETL_DeltaHashKey)



	MERGE ods.Host_Trans_ActiveSales AS myTarget

	USING (SELECT * FROM #Trans) mySource

		 ON myTarget.ACCOUNT = mySource.ACCOUNT AND myTarget.EVENT_CODE = mySource.EVENT_CODE AND myTarget.SEATINFO = mySource.SEATINFO AND myTarget.TICKETS = mySource.TICKETS

	WHEN MATCHED AND mySource.ETL_DeltaHashKey <> myTarget.ETL_DeltaHashKey

	THEN UPDATE SET 

		myTarget.ETL_UpdatedDate = GETDATE()
		, myTarget.ETL_DeltaHashKey = mySource.ETL_DeltaHashKey

		, myTarget.ACCOUNT = mySource.ACCOUNT
		, myTarget.ACCOUNT_MODE = mySource.ACCOUNT_MODE
		, myTarget.EVENT_CODE = mySource.EVENT_CODE
		, myTarget.SALEDATE = mySource.SALEDATE
		, myTarget.SEATINFO = mySource.SEATINFO
		, myTarget.TICKETS = mySource.TICKETS
		, myTarget.TRANSACTION_NUM = mySource.TRANSACTION_NUM
		, myTarget.EVENTDATE = mySource.EVENTDATE
		, myTarget.PERFNAME = mySource.PERFNAME
		, myTarget.PRIMARYACT = mySource.PRIMARYACT
		, myTarget.SECONDARYACT = mySource.SECONDARYACT
		, myTarget.TM_EVENT_ID = mySource.TM_EVENT_ID
		, myTarget.TM_MAJORCATNAME = mySource.TM_MAJORCATNAME
		, myTarget.TM_MINORCATNAME = mySource.TM_MINORCATNAME
		, myTarget.VAXNAME = mySource.VAXNAME
		, myTarget.VENUENAME = mySource.VENUENAME
		, myTarget.VENUENUM = mySource.VENUENUM
		, myTarget.CAMEFROM_CODE = mySource.CAMEFROM_CODE
		, myTarget.DELIVERY_METHOD_DESCRIPTION = mySource.DELIVERY_METHOD_DESCRIPTION
		, myTarget.EXTRA1 = mySource.EXTRA1
		, myTarget.EXTRA2 = mySource.EXTRA2
		, myTarget.INTERACTION_SOURCE = mySource.INTERACTION_SOURCE
		, myTarget.OPT_IN_FLAG = mySource.OPT_IN_FLAG
		, myTarget.PAYMENT_SUBMETHOD = mySource.PAYMENT_SUBMETHOD
		, myTarget.QUALIFIERS = mySource.QUALIFIERS
		, myTarget.ETL__SourceFileName = mySource.ETL__SourceFileName
		, myTarget.TRANSACTION_AMOUNT = mySource.TRANSACTION_AMOUNT

		, myTarget.SeatRanking = master.[dbo].[fnGetValueFromDelimitedString](mySource.SEATINFO,'\',1)
		, myTarget.SectionName = LTRIM(RTRIM(master.[dbo].[fnGetValueFromDelimitedString](mySource.SEATINFO,'\',2)))
		, myTarget.RowName = master.[dbo].[fnGetValueFromDelimitedString](mySource.SEATINFO,'\',3)
		, myTarget.SeatStart = ISNULL(TRY_CAST(master.[dbo].[fnGetValueFromDelimitedString](mySource.SEATINFO,'\',4) AS int),0)
		, myTarget.SeatEnd = ISNULL(TRY_CAST(master.[dbo].[fnGetValueFromDelimitedString](mySource.SEATINFO,'\',5) AS int),0)
		, myTarget.PriceType = master.[dbo].[fnGetValueFromDelimitedString](mySource.SEATINFO,'\',6)

	WHEN NOT MATCHED BY SOURCE THEN	DELETE

	WHEN NOT MATCHED BY Target THEN
	INSERT (
		ETL_CreatedDate, ETL_UpdatedDate, ETL_DeltaHashKey, ETL_SSID_AccountKey
		, ACCOUNT, ACCOUNT_MODE, EVENT_CODE, SALEDATE, SEATINFO, TICKETS, TRANSACTION_NUM, EVENTDATE, PERFNAME, PRIMARYACT, SECONDARYACT, TM_EVENT_ID, TM_MAJORCATNAME, TM_MINORCATNAME, VAXNAME, VENUENAME, VENUENUM, CAMEFROM_CODE, DELIVERY_METHOD_DESCRIPTION, EXTRA1, EXTRA2, INTERACTION_SOURCE, OPT_IN_FLAG, PAYMENT_SUBMETHOD, QUALIFIERS, ETL__SourceFileName
		, SeatRanking, SectionName, RowName, SeatStart, SeatEnd, PriceType	
		, TRANSACTION_AMOUNT
	)
		VALUES (
				
			GETDATE() --ETL_CreatedDate
			, GETDATE() --ETL_UpdatedDate
			, mySource.ETL_DeltaHashKey 
			, (mySource.ACCOUNT + ':' + CONVERT(VARCHAR, CAST(mySource.SaleDate AS DATE), 101)) --ETL_SSID_AccountKey

			, mySource.ACCOUNT
			, mySource.ACCOUNT_MODE
			, mySource.EVENT_CODE
			, mySource.SALEDATE
			, mySource.SEATINFO
			, mySource.TICKETS
			, mySource.TRANSACTION_NUM
			, mySource.EVENTDATE
			, mySource.PERFNAME
			, mySource.PRIMARYACT
			, mySource.SECONDARYACT
			, mySource.TM_EVENT_ID
			, mySource.TM_MAJORCATNAME
			, mySource.TM_MINORCATNAME
			, mySource.VAXNAME
			, mySource.VENUENAME
			, mySource.VENUENUM
			, mySource.CAMEFROM_CODE
			, mySource.DELIVERY_METHOD_DESCRIPTION
			, mySource.EXTRA1
			, mySource.EXTRA2
			, mySource.INTERACTION_SOURCE
			, mySource.OPT_IN_FLAG
			, mySource.PAYMENT_SUBMETHOD
			, mySource.QUALIFIERS
			, mySource.ETL__SourceFileName

			, master.[dbo].[fnGetValueFromDelimitedString](mySource.SEATINFO,'\',1) --[SeatRanking]
			, LTRIM(RTRIM(master.[dbo].[fnGetValueFromDelimitedString](mySource.SEATINFO,'\',2))) --[SectionName]
			, master.[dbo].[fnGetValueFromDelimitedString](mySource.SEATINFO,'\',3) --[RowName]
			, ISNULL(TRY_CAST(master.[dbo].[fnGetValueFromDelimitedString](mySource.SEATINFO,'\',4) AS int),0) --[SeatStart]
			, ISNULL(TRY_CAST(master.[dbo].[fnGetValueFromDelimitedString](mySource.SEATINFO,'\',5) AS int),0) --[SeatEnd]
			, master.[dbo].[fnGetValueFromDelimitedString](mySource.SEATINFO,'\',6) --[PriceType]

			, mySource.TRANSACTION_AMOUNT
		);
		



END












































































































GO
