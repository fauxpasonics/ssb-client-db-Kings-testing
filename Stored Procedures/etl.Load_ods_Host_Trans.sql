SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE [etl].[Load_ods_Host_Trans]
(
	@BatchId UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000000',
	@Options NVARCHAR(MAX) = null
)
AS 

BEGIN

	SELECT DISTINCT ETL__SourceFileName 
	INTO #stgFiles
	FROM stg.Host_Trans

	DELETE t
	FROM ods.Host_Trans t
	INNER JOIN #stgFiles s ON t.ETL__SourceFileName = s.ETL__SourceFileName

	SELECT CAST(HASHBYTES('sha2_256', ISNULL(RTRIM(ADDRESS1),'DBNULL_TEXT') + ISNULL(RTRIM(ADDRESS2),'DBNULL_TEXT') + ISNULL(RTRIM(CITY),'DBNULL_TEXT') + ISNULL(RTRIM(DAYPHONE),'DBNULL_TEXT') + ISNULL(RTRIM(EMAIL),'DBNULL_TEXT') + ISNULL(RTRIM(EVENINGPHONE),'DBNULL_TEXT') + ISNULL(RTRIM(FIRSTNAME),'DBNULL_TEXT') + ISNULL(RTRIM(LASTNAME),'DBNULL_TEXT') + ISNULL(RTRIM(MIDDLEINITIAL),'DBNULL_TEXT') + ISNULL(RTRIM(PREFIX),'DBNULL_TEXT') + ISNULL(RTRIM([STATE]),'DBNULL_TEXT') + ISNULL(RTRIM(SUFFIX),'DBNULL_TEXT') + ISNULL(RTRIM(ZIP),'DBNULL_TEXT') + ISNULL(RTRIM(ZIPEXT),'DBNULL_TEXT')) AS BINARY(32)) HostAccount__DeltaHashKey
	, *
	INTO #stg
	FROM stg.Host_Trans

	INSERT INTO ods.Host_Accounts
	(
		ETL__CreatedDate, ETL__UpdatedDate, ETL__DeltaHashKey, EMAIL, PREFIX, FIRSTNAME, MIDDLEINITIAL, LASTNAME, SUFFIX, ADDRESS1, ADDRESS2, CITY, [STATE], ZIP, ZIPEXT, DAYPHONE, EVENINGPHONE
	)

	SELECT GETDATE() ETL__CreatedDate, GETDATE() ETL__UpdatedDate
		, a.HostAccount__DeltaHashKey ETL__DeltaHashKey
		, a.EMAIL, a.PREFIX, a.FIRSTNAME, a.MIDDLEINITIAL, a.LASTNAME, a.SUFFIX, a.ADDRESS1, a.ADDRESS2, a.CITY, a.[STATE], a.ZIP, a.ZIPEXT, a.DAYPHONE, a.EVENINGPHONE
	FROM (
		SELECT DISTINCT s.HostAccount__DeltaHashKey, s.EMAIL, s.PREFIX, s.FIRSTNAME, s.MIDDLEINITIAL, s.LASTNAME, s.SUFFIX, s.ADDRESS1, s.ADDRESS2, s.CITY, s.[STATE], s.ZIP, s.ZIPEXT, s.DAYPHONE, s.EVENINGPHONE
		FROM #stg s
		LEFT OUTER JOIN ods.Host_Accounts t ON s.HostAccount__DeltaHashKey = t.ETL__DeltaHashKey
		WHERE LEN(ISNULL(s.FIRSTNAME,'')) + LEN(ISNULL(s.LASTNAME,'')) + LEN(ISNULL(s.EMAIL,'')) + LEN(ISNULL(s.ZIP,'')) > 0
		AND t.HostAccountId IS NULL
	) a
	

	INSERT INTO ods.Host_Trans
	( 
		ETL__CreatedDate, ETL__SourceFileName, EMAIL, PREFIX, FIRSTNAME, MIDDLEINITIAL, LASTNAME, SUFFIX, ADDRESS1, ADDRESS2, CITY, [STATE], ZIP, ZIPEXT,
		DAYPHONE, EVENINGPHONE, TM_EVENT_ID, INTERACTION_SOURCE, SALEDATE, TICKETS, TRANSACTION_AMOUNT, ACCOUNT, VOIDED_FLAG, VOIDED_DATE, PAYMENT_SUBMETHOD,
		CAMEFROM_CODE, SEATINFO, QUALIFIERS, FACILITY_FEE, SERVICE_CHARGE, TRANSACTION_NUM, OPTION_DOLLARS, VAXNAME, MOBILEPHONE, DMA, OPCODE, OPLEVEL, EXTRA1,
		EXTRA2, COUNTRY, TICKETS_TRANSFERRED, TICKETS_RECEIVED, TICKETS_SURRENDERED, EVENT_CODE, TM_MAJORCATNAME, TM_MINORCATNAME, VENUENUM, VENUENAME,
		EVENTDATE, ONSALEDATE, PRESALEONDATE, PRESALEOFFDATE, OUTLETDATE, PHONEDATE, CANCELLED, VENUE_CITY, VENUE_STATE, VENUE_ZIP, TICKET_TEXT, PRIMARYACT,
		SECONDARYACT, PERFNAME, OPT_IN_FLAG, Calc_HostAccountId 
	)

	SELECT GETDATE() ETL__CreatedDate, s.ETL__SourceFileName, s.EMAIL, s.PREFIX, s.FIRSTNAME, s.MIDDLEINITIAL, s.LASTNAME, s.SUFFIX, s.ADDRESS1, s.ADDRESS2,
           s.CITY, s.[STATE], s.ZIP, s.ZIPEXT, s.DAYPHONE, s.EVENINGPHONE, s.TM_EVENT_ID, s.INTERACTION_SOURCE, s.SALEDATE, s.TICKETS, s.TRANSACTION_AMOUNT, s.ACCOUNT,
           s.VOIDED_FLAG, s.VOIDED_DATE, s.PAYMENT_SUBMETHOD, s.CAMEFROM_CODE, s.SEATINFO, s.QUALIFIERS, s.FACILITY_FEE, s.SERVICE_CHARGE, s.TRANSACTION_NUM,
           s.OPTION_DOLLARS, s.VAXNAME, s.MOBILEPHONE, s.DMA, s.OPCODE, s.OPLEVEL, s.EXTRA1, s.EXTRA2, s.COUNTRY, s.TICKETS_TRANSFERRED, s.TICKETS_RECEIVED,
           s.TICKETS_SURRENDERED, s.EVENT_CODE, s.TM_MAJORCATNAME, s.TM_MINORCATNAME, s.VENUENUM, s.VENUENAME, s.EVENTDATE, s.ONSALEDATE, s.PRESALEONDATE,
           s.PRESALEOFFDATE, s.OUTLETDATE, s.PHONEDATE, s.CANCELLED, s.VENUE_CITY, s.VENUE_STATE, s.VENUE_ZIP, s.TICKET_TEXT, s.PRIMARYACT, s.SECONDARYACT, s.PERFNAME,
           s.OPT_IN_FLAG
	, a.HostAccountId
	FROM #stg s
	LEFT OUTER JOIN ods.Host_Accounts a ON s.HostAccount__DeltaHashKey = a.ETL__DeltaHashKey



END







GO
