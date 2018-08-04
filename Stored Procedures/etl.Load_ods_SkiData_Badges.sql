SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





CREATE PROCEDURE [etl].[Load_ods_SkiData_Badges]
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
Date:     11/24/2016
Comments: Initial creation
*************************************************************************************/

DECLARE @RunTime DATETIME = GETDATE()

DECLARE @ExecutionId uniqueidentifier = newid();
DECLARE @ProcedureName NVARCHAR(255) = OBJECT_SCHEMA_NAME(@@PROCID) + '.' + OBJECT_NAME(@@PROCID);
DECLARE @SrcRowCount INT = ISNULL((SELECT CONVERT(VARCHAR, COUNT(*)) FROM src.SkiData_Badges),'0');	
DECLARE @SrcDataSize NVARCHAR(255) = '0'

BEGIN TRY 

PRINT 'Execution Id: ' + CONVERT(NVARCHAR(100),@ExecutionId)

SELECT CAST(NULL AS BINARY(32)) ETL_DeltaHashKey, ETL_SourceFileName, BadgeId, Title, Teaser, Description, ProgressMessage, ProgressCompleteMessage, StartDateTime, EndDateTime, VisibilityStartDate, VisibilityEndDate, IsVisible, InitialQuantity, RemainingQuantity, BadgeCriteriaTypeID, IsActive, DateCreated, DateUpdated, UpdatedBy, ProgressMessage1, ProgressCompleteMessage1, BadgeEarnedMessageTemplateID
INTO #SrcData
FROM src.SkiData_Badges

UPDATE #SrcData
SET ETL_DeltaHashKey = HASHBYTES('sha2_256', ISNULL(RTRIM(BadgeCriteriaTypeID),'DBNULL_TEXT') + ISNULL(RTRIM(BadgeEarnedMessageTemplateID),'DBNULL_TEXT') + ISNULL(RTRIM(BadgeId),'DBNULL_TEXT') + ISNULL(RTRIM(DateCreated),'DBNULL_TEXT') + ISNULL(RTRIM(DateUpdated),'DBNULL_TEXT') + ISNULL(RTRIM(Description),'DBNULL_TEXT') + ISNULL(RTRIM(EndDateTime),'DBNULL_TEXT') + ISNULL(RTRIM(InitialQuantity),'DBNULL_TEXT') + ISNULL(RTRIM(IsActive),'DBNULL_TEXT') + ISNULL(RTRIM(IsVisible),'DBNULL_TEXT') + ISNULL(RTRIM(ProgressCompleteMessage),'DBNULL_TEXT') + ISNULL(RTRIM(ProgressCompleteMessage1),'DBNULL_TEXT') + ISNULL(RTRIM(ProgressMessage),'DBNULL_TEXT') + ISNULL(RTRIM(ProgressMessage1),'DBNULL_TEXT') + ISNULL(RTRIM(RemainingQuantity),'DBNULL_TEXT') + ISNULL(RTRIM(StartDateTime),'DBNULL_TEXT') + ISNULL(RTRIM(Teaser),'DBNULL_TEXT') + ISNULL(RTRIM(Title),'DBNULL_TEXT') + ISNULL(RTRIM(UpdatedBy),'DBNULL_TEXT') + ISNULL(RTRIM(VisibilityEndDate),'DBNULL_TEXT') + ISNULL(RTRIM(VisibilityStartDate),'DBNULL_TEXT'))


CREATE NONCLUSTERED INDEX IDX_Load_Key ON #SrcData (BadgeId)
CREATE NONCLUSTERED INDEX IDX_ETL_DeltaHashKey ON #SrcData (ETL_DeltaHashKey)



MERGE ods.SkiData_Badges AS myTarget
USING #SrcData AS mySource
ON myTarget.BadgeId = mySource.BadgeId

WHEN MATCHED AND (
     ISNULL(mySource.ETL_DeltaHashKey,-1) <> ISNULL(myTarget.ETL_DeltaHashKey, -1)
	 OR myTarget.ETL_IsDeleted = 1
)
THEN UPDATE SET
      myTarget.[ETL_UpdatedDate] = @RunTime
	 ,myTarget.[ETL_IsDeleted] = 0
	 ,myTarget.[ETL_DeletedDate] = NULL
     ,myTarget.[ETL_DeltaHashKey] = mySource.[ETL_DeltaHashKey]
	 ,myTarget.[ETL_SourceFileName] = mySource.[ETL_SourceFileName]
     ,myTarget.[BadgeId] = mySource.[BadgeId]
     ,myTarget.[Title] = mySource.[Title]
     ,myTarget.[Teaser] = mySource.[Teaser]
     ,myTarget.[Description] = mySource.[Description]
     ,myTarget.[ProgressMessage] = mySource.[ProgressMessage]
     ,myTarget.[ProgressCompleteMessage] = mySource.[ProgressCompleteMessage]
     ,myTarget.[StartDateTime] = mySource.[StartDateTime]
     ,myTarget.[EndDateTime] = mySource.[EndDateTime]
     ,myTarget.[VisibilityStartDate] = mySource.[VisibilityStartDate]
     ,myTarget.[VisibilityEndDate] = mySource.[VisibilityEndDate]
     ,myTarget.[IsVisible] = mySource.[IsVisible]
     ,myTarget.[InitialQuantity] = mySource.[InitialQuantity]
     ,myTarget.[RemainingQuantity] = mySource.[RemainingQuantity]
     ,myTarget.[BadgeCriteriaTypeID] = mySource.[BadgeCriteriaTypeID]
     ,myTarget.[IsActive] = mySource.[IsActive]
     ,myTarget.[DateCreated] = mySource.[DateCreated]
     ,myTarget.[DateUpdated] = mySource.[DateUpdated]
     ,myTarget.[UpdatedBy] = mySource.[UpdatedBy]
     ,myTarget.[ProgressMessage1] = mySource.[ProgressMessage1]
     ,myTarget.[ProgressCompleteMessage1] = mySource.[ProgressCompleteMessage1]
     ,myTarget.[BadgeEarnedMessageTemplateID] = mySource.[BadgeEarnedMessageTemplateID]


WHEN NOT MATCHED BY SOURCE AND ETL_IsDeleted = 0
THEN UPDATE SET
	 myTarget.[ETL_UpdatedDate] = @RunTime
	,myTarget.[ETL_IsDeleted] = 1
	,myTarget.[ETL_DeletedDate] = @RunTime

     
WHEN NOT MATCHED BY TARGET
THEN INSERT
     ([ETL_CreatedDate]
     ,[ETL_UpdatedDate]
     ,[ETL_IsDeleted]
     ,[ETL_DeletedDate]
     ,[ETL_DeltaHashKey]
     ,[ETL_SourceFileName]
     ,[BadgeId]
     ,[Title]
     ,[Teaser]
     ,[Description]
     ,[ProgressMessage]
     ,[ProgressCompleteMessage]
     ,[StartDateTime]
     ,[EndDateTime]
     ,[VisibilityStartDate]
     ,[VisibilityEndDate]
     ,[IsVisible]
     ,[InitialQuantity]
     ,[RemainingQuantity]
     ,[BadgeCriteriaTypeID]
     ,[IsActive]
     ,[DateCreated]
     ,[DateUpdated]
     ,[UpdatedBy]
     ,[ProgressMessage1]
     ,[ProgressCompleteMessage1]
     ,[BadgeEarnedMessageTemplateID]
     )
VALUES
     (@RunTime --ETL_CreatedDate
     ,@RunTime --ETL_UpdateddDate
     ,0 --ETL_DeletedDate
     ,NULL --ETL_DeletedDate
     ,mySource.[ETL_DeltaHashKey]
	 ,mySource.[ETL_SourceFileName]
     ,mySource.[BadgeId]
     ,mySource.[Title]
     ,mySource.[Teaser]
     ,mySource.[Description]
     ,mySource.[ProgressMessage]
     ,mySource.[ProgressCompleteMessage]
     ,mySource.[StartDateTime]
     ,mySource.[EndDateTime]
     ,mySource.[VisibilityStartDate]
     ,mySource.[VisibilityEndDate]
     ,mySource.[IsVisible]
     ,mySource.[InitialQuantity]
     ,mySource.[RemainingQuantity]
     ,mySource.[BadgeCriteriaTypeID]
     ,mySource.[IsActive]
     ,mySource.[DateCreated]
     ,mySource.[DateUpdated]
     ,mySource.[UpdatedBy]
     ,mySource.[ProgressMessage1]
     ,mySource.[ProgressCompleteMessage1]
     ,mySource.[BadgeEarnedMessageTemplateID]
     )
;



DECLARE @MergeInsertRowCount int = ISNULL((SELECT CONVERT(varchar, COUNT(*)) FROM ods.SkiData_Badges WHERE ETL_CreatedDate >= @RunTime AND ETL_UpdatedDate = ETL_CreatedDate),'0');	
DECLARE @MergeUpdateRowCount int = ISNULL((SELECT CONVERT(varchar, COUNT(*)) FROM ods.SkiData_Badges WHERE ETL_UpdatedDate >= @RunTime AND ETL_UpdatedDate > ETL_CreatedDate),'0');	


END TRY 
BEGIN CATCH 

	DECLARE @ErrorMessage nvarchar(4000) = ERROR_MESSAGE();
	DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
	DECLARE @ErrorState INT = ERROR_STATE();
			
	PRINT @ErrorMessage

	RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)

END CATCH


END






GO
