SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE [etl].[TM_LoadFacts]
AS
BEGIN

	--SELECT GETDATE()

	DECLARE @BatchId INT = 0;
	DECLARE @ExecutionId uniqueidentifier = newid();
	DECLARE @ProcedureName nvarchar(255) = OBJECT_SCHEMA_NAME(@@PROCID) + '.' + OBJECT_NAME(@@PROCID);
	DECLARE @LogEventDefault NVARCHAR(255) = 'Processing Status'

	EXEC etl.LogEventRecordDB @Batchid, 'Info', @ProcedureName, 'Dim Load', @LogEventDefault, 'Start', @ExecutionId

	EXEC etl.FactTicketSales_DeleteReturns 

	EXEC etl.TM_LoadFactTicketSales

	EXEC etl.TM_Ticket_Pacing

	EXEC etl.Load_FactInventory
	
	EXEC [etl].[FactAttendance_UpdateAttendance]
	EXEC [etl].[FactAttendance_UpdateAttendanceAPI]
	EXEC [etl].[FactInventory_UpdateResoldSeats]

	truncate table archive.tm_listcode

	--EXECUTE dbo.IndexOptimize
	--@Databases = 'USER_DATABASES',
	--@FragmentationLow = NULL,
	--@FragmentationMedium = 'INDEX_REORGANIZE,INDEX_REBUILD_ONLINE,INDEX_REBUILD_OFFLINE',
	--@FragmentationHigh = 'INDEX_REBUILD_ONLINE,INDEX_REBUILD_OFFLINE',
	--@FragmentationLevel1 = 10,
	--@FragmentationLevel2 = 25

	EXEC etl.LogEventRecordDB @Batchid, 'Info', @ProcedureName, 'Dim Load', @LogEventDefault, 'Complete', @ExecutionId

END


GO
