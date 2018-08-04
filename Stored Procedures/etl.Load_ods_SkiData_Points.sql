SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





CREATE PROCEDURE [etl].[Load_ods_SkiData_Points]
(
	@BatchId INT = 0,
	@Options NVARCHAR(MAX) = null
)
AS 

BEGIN
/**************************************Comments***************************************
**************************************************************************************
Mod #:  1
Name:     SSBCLOUD\dhorstman
Date:     05/13/2016
Comments: Initial creation
*************************************************************************************/

DECLARE @RunTime DATETIME = GETDATE()

DECLARE @ExecutionId uniqueidentifier = newid();
DECLARE @ProcedureName nvarchar(255) = OBJECT_SCHEMA_NAME(@@PROCID) + '.' + OBJECT_NAME(@@PROCID);
DECLARE @SrcRowCount int = ISNULL((SELECT CONVERT(varchar, COUNT(*)) FROM src.SkiData_Points),'0');	
DECLARE @SrcDataSize NVARCHAR(255) = '0'

/*Load Options into a temp table*/
SELECT Col1 AS OptionKey, Col2 as OptionValue INTO #Options FROM [dbo].[SplitMultiColumn](@Options, '=', ';')

/*Extract Options, default values set if the option is not specified*/	
DECLARE @DisableInsert nvarchar(5) = ISNULL((SELECT OptionValue FROM #Options WHERE OptionKey = 'DisableInsert'),'false')
DECLARE @DisableUpdate nvarchar(5) = ISNULL((SELECT OptionValue FROM #Options WHERE OptionKey = 'DisableUpdate'),'false')
DECLARE @DisableDelete nvarchar(5) = ISNULL((SELECT OptionValue FROM #Options WHERE OptionKey = 'DisableDelete'),'true')


BEGIN TRY 

PRINT 'Execution Id: ' + CONVERT(NVARCHAR(100),@ExecutionId)

EXEC etl.LogEventRecordDB @Batchid, 'Info', @ProcedureName, 'Merge Load', 'Procedure Processing', 'Start', @ExecutionId
EXEC etl.LogEventRecordDB @Batchid, 'Info', @ProcedureName, 'Merge Load', 'Src Row Count', @SrcRowCount, @ExecutionId
EXEC etl.LogEventRecordDB @Batchid, 'Info', @ProcedureName, 'Merge Load', 'Src DataSize', @SrcDataSize, @ExecutionId

SELECT CAST(NULL AS BINARY(32)) ETL_DeltaHashKey
,  ETL_SourceFileName, TicketAccountID, UserID, PointAuditID, SeatID, PointActivityTypeName, PointActivityTypeId, PointActivityTitle, PointActivityID, PointsAwarded, AwardDate, AwardedBy, Valid, ContentType, ContentID, DateCreated
INTO #SrcData
FROM (
	SELECT  ETL_SourceFileName, TicketAccountID, UserID, PointAuditID, SeatID, PointActivityTypeName, PointActivityTypeId, PointActivityTitle, PointActivityID, PointsAwarded, AwardDate, AwardedBy, Valid, ContentType, ContentID, DateCreated
	, ROW_NUMBER() OVER(PARTITION BY PointAuditID ORDER BY ETL_ID) RowRank
	FROM src.SkiData_Points
) a
WHERE RowRank = 1

EXEC etl.LogEventRecordDB @Batchid, 'Info', @ProcedureName, 'Merge Load', 'Src Table Setup', 'Temp Table Loaded', @ExecutionId

UPDATE #SrcData
SET ETL_DeltaHashKey = HASHBYTES('sha2_256', ISNULL(RTRIM(AwardDate),'DBNULL_TEXT') + ISNULL(RTRIM(AwardedBy),'DBNULL_TEXT') + ISNULL(RTRIM(ContentID),'DBNULL_TEXT') + ISNULL(RTRIM(ContentType),'DBNULL_TEXT') + ISNULL(RTRIM(DateCreated),'DBNULL_TEXT') + ISNULL(RTRIM(PointActivityID),'DBNULL_TEXT') + ISNULL(RTRIM(PointActivityTitle),'DBNULL_TEXT') + ISNULL(RTRIM(PointActivityTypeId),'DBNULL_TEXT') + ISNULL(RTRIM(PointActivityTypeName),'DBNULL_TEXT') + ISNULL(RTRIM(PointAuditID),'DBNULL_TEXT') + ISNULL(RTRIM(PointsAwarded),'DBNULL_TEXT') + ISNULL(RTRIM(SeatID),'DBNULL_TEXT') + ISNULL(RTRIM(TicketAccountID),'DBNULL_TEXT') + ISNULL(RTRIM(UserID),'DBNULL_TEXT') + ISNULL(RTRIM(Valid),'DBNULL_TEXT'))

EXEC etl.LogEventRecordDB @Batchid, 'Info', @ProcedureName, 'Merge Load', 'Src Table Setup', 'ETL_DeltaHashKey Set', @ExecutionId

CREATE NONCLUSTERED INDEX IDX_Load_Key ON #SrcData (PointAuditID)
CREATE NONCLUSTERED INDEX IDX_ETL_DeltaHashKey ON #SrcData (ETL_DeltaHashKey)

EXEC etl.LogEventRecordDB @Batchid, 'Info', @ProcedureName, 'Merge Load', 'Src Table Setup', 'Temp Table Indexes Created', @ExecutionId

EXEC etl.LogEventRecordDB @Batchid, 'Info', @ProcedureName, 'Merge Load', 'Merge Statement Execution', 'Start', @ExecutionId


MERGE ods.SkiData_Points AS myTarget
USING #SrcData AS mySource
ON myTarget.PointAuditID = mySource.PointAuditID

WHEN MATCHED AND (
     ISNULL(mySource.ETL_DeltaHashKey,-1) <> ISNULL(myTarget.ETL_DeltaHashKey, -1)
	 OR myTarget.ETL_IsDeleted = 1
)
THEN UPDATE SET
       myTarget.[ETL_UpdatedDate] = @RunTime
	 , myTarget.[ETL_IsDeleted] = 0
	 , myTarget.[ETL_DeletedDate] = NULL
     , myTarget.[ETL_DeltaHashKey] = mySource.[ETL_DeltaHashKey]
     , myTarget.[ETL_SourceFileName] = mySource.[ETL_SourceFileName]
     , myTarget.[TicketAccountID] = mySource.[TicketAccountID]
     , myTarget.[UserID] = mySource.[UserID]
     , myTarget.[PointAuditID] = mySource.[PointAuditID]
     , myTarget.[SeatID] = mySource.[SeatID]
     , myTarget.[PointActivityTypeName] = mySource.[PointActivityTypeName]
     , myTarget.[PointActivityTypeId] = mySource.[PointActivityTypeId]
     , myTarget.[PointActivityTitle] = mySource.[PointActivityTitle]
     , myTarget.[PointActivityID] = mySource.[PointActivityID]
     , myTarget.[PointsAwarded] = mySource.[PointsAwarded]
     , myTarget.[AwardDate] = mySource.[AwardDate]
     , myTarget.[AwardedBy] = mySource.[AwardedBy]
     , myTarget.[Valid] = mySource.[Valid]
     , myTarget.[ContentType] = mySource.[ContentType]
     , myTarget.[ContentID] = mySource.[ContentID]
     , myTarget.[DateCreated] = mySource.[DateCreated]
     

WHEN NOT MATCHED BY SOURCE AND ETL_IsDeleted = 0
THEN UPDATE SET
	 myTarget.[ETL_UpdatedDate] = @RunTime
	,myTarget.[ETL_IsDeleted] = 1
	,myTarget.[ETL_DeletedDate] = @RunTime


WHEN NOT MATCHED BY Target
THEN INSERT
     ([ETL_CreatedDate]
     ,[ETL_UpdatedDate]
     ,[ETL_IsDeleted]
     ,[ETL_DeletedDate]
     ,[ETL_DeltaHashKey]
     ,[ETL_SourceFileName]
     ,[TicketAccountID]
     ,[UserID]
     ,[PointAuditID]
     ,[SeatID]
     ,[PointActivityTypeName]
     ,[PointActivityTypeId]
     ,[PointActivityTitle]
     ,[PointActivityID]
     ,[PointsAwarded]
     ,[AwardDate]
     ,[AwardedBy]
     ,[Valid]
     ,[ContentType]
     ,[ContentID]
     ,[DateCreated]
     )
VALUES
     (@RunTime --ETL_CreatedDate
     ,@RunTime --ETL_UpdateddDate
     ,0 --ETL_DeletedDate
     ,NULL --ETL_DeletedDate
     ,mySource.[ETL_DeltaHashKey]
     ,mySource.[ETL_SourceFileName]
     ,mySource.[TicketAccountID]
     ,mySource.[UserID]
     ,mySource.[PointAuditID]
     ,mySource.[SeatID]
     ,mySource.[PointActivityTypeName]
     ,mySource.[PointActivityTypeId]
     ,mySource.[PointActivityTitle]
     ,mySource.[PointActivityID]
     ,mySource.[PointsAwarded]
     ,mySource.[AwardDate]
     ,mySource.[AwardedBy]
     ,mySource.[Valid]
     ,mySource.[ContentType]
     ,mySource.[ContentID]
     ,mySource.[DateCreated]
     )
;

EXEC etl.LogEventRecordDB @Batchid, 'Info', @ProcedureName, 'Merge Load', 'Merge Statement Execution', 'Complete', @ExecutionId

DECLARE @MergeInsertRowCount int = ISNULL((SELECT CONVERT(varchar, COUNT(*)) FROM ods.SkiData_Points WHERE ETL_CreatedDate >= @RunTime AND ETL_UpdatedDate = ETL_CreatedDate),'0');	
DECLARE @MergeUpdateRowCount int = ISNULL((SELECT CONVERT(varchar, COUNT(*)) FROM ods.SkiData_Points WHERE ETL_UpdatedDate >= @RunTime AND ETL_UpdatedDate > ETL_CreatedDate),'0');	

EXEC etl.LogEventRecordDB @Batchid, 'Info', @ProcedureName, 'Merge Load', 'Merge Insert Row Count', @MergeInsertRowCount, @ExecutionId
EXEC etl.LogEventRecordDB @Batchid, 'Info', @ProcedureName, 'Merge Load', 'Merge Update Row Count', @MergeUpdateRowCount, @ExecutionId


END TRY 
BEGIN CATCH 

	DECLARE @ErrorMessage nvarchar(4000) = ERROR_MESSAGE();
	DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
	DECLARE @ErrorState INT = ERROR_STATE();
			
	PRINT @ErrorMessage
	EXEC etl.LogEventRecordDB @Batchid, 'Error', @ProcedureName, 'Merge Load', 'Merge Error', @ErrorMessage, @ExecutionId
	EXEC etl.LogEventRecordDB @Batchid, 'Info', @ProcedureName, 'Merge Load', 'Procedure Processing', 'Complete', @ExecutionId

	RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)

END CATCH

EXEC etl.LogEventRecordDB @Batchid, 'Info', @ProcedureName, 'Merge Load', 'Procedure Processing', 'Complete', @ExecutionId


END






GO
