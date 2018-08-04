SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE [etl].[Load_ods_Host_Audit]
(
	@BatchId UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000000',
	@Options NVARCHAR(MAX) = null
)
AS 

BEGIN

	SELECT DISTINCT ETL__SourceFileName 
	INTO #stgFiles
	FROM stg.Host_Audit

	DELETE t
	FROM ods.Host_Audit t
	INNER JOIN #stgFiles s ON t.ETL__SourceFileName = s.ETL__SourceFileName


	INSERT INTO ods.Host_Audit
	( 
		ETL__CreatedDate, ETL__SourceFileName, [System], HexVaxEVID, EvCode, EventName, MajorCategory, MinorCategory, ActName, SecondActName, VenueName, EPDate,
	    EPTime, Sdate, OpType, PriceLevel, PriceLevelName, TicketTypeID, TicketTypeName, QualifierString, AuditEntry, SeriesMaster, DailyTickets, TotalTickets,
	    SoldFaceValue, ServiceCharge, FacilityFee, ServiceTax, VATTax, AdultPrice, PremiumAmount, QualifierMaskName, Calc_EPDateTime 
	)			

	SELECT GETDATE() ETL__CreatedDate, ETL__SourceFileName
		, [System], HexVaxEVID, EvCode, EventName, MajorCategory, MinorCategory, ActName, SecondActName, VenueName, EPDate,
	    EPTime, Sdate, OpType, PriceLevel, PriceLevelName, TicketTypeID, TicketTypeName, QualifierString, AuditEntry, SeriesMaster, DailyTickets, TotalTickets,
	    SoldFaceValue, ServiceCharge, FacilityFee, ServiceTax, VATTax, AdultPrice, PremiumAmount, QualifierMaskName
		, ( CAST(EPDate AS DATETIME) +  CAST(EPTime AS DATETIME) ) Calc_EPDateTime
	FROM stg.Host_Audit


	--ALTER INDEX ALL ON ods.Host_Audit REBUILD


END






GO
