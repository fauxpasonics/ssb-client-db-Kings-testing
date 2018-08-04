SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





CREATE PROCEDURE [etl].[Load_ods_SkiData_UserBadges]
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
Date:     11/09/2016
Comments: Initial creation
*************************************************************************************/

DECLARE @RunTime DATETIME = GETDATE()

DECLARE @ExecutionId uniqueidentifier = newid();
DECLARE @ProcedureName NVARCHAR(255) = OBJECT_SCHEMA_NAME(@@PROCID) + '.' + OBJECT_NAME(@@PROCID);
DECLARE @SrcRowCount INT = ISNULL((SELECT CONVERT(VARCHAR, COUNT(*)) FROM src.SkiData_UserBadges),'0');	
DECLARE @SrcDataSize NVARCHAR(255) = '0'

BEGIN TRY 

PRINT 'Execution Id: ' + CONVERT(NVARCHAR(100),@ExecutionId)

SELECT CAST(NULL AS BINARY(32)) ETL_DeltaHashKey, ETL_SourceFileName, UserBadgeID, Title, Description, UserID, BadgeID, DateCreated, DateUpdated, IsValid, ManuallyAwardedByUserID
INTO #SrcData
FROM src.SkiData_UserBadges
;


UPDATE #SrcData
SET ETL_DeltaHashKey = HASHBYTES('sha2_256', ISNULL(RTRIM(BadgeID),'DBNULL_TEXT') + ISNULL(RTRIM(DateCreated),'DBNULL_TEXT') + ISNULL(RTRIM(DateUpdated),'DBNULL_TEXT') + ISNULL(RTRIM(Description),'DBNULL_TEXT') + ISNULL(RTRIM(IsValid),'DBNULL_TEXT') + + ISNULL(RTRIM(ManuallyAwardedByUserID),'DBNULL_TEXT') + ISNULL(RTRIM(Title),'DBNULL_TEXT') + ISNULL(RTRIM(UserBadgeID),'DBNULL_TEXT') + ISNULL(RTRIM(UserID),'DBNULL_TEXT'))
;

CREATE NONCLUSTERED INDEX IDX_Load_Key ON #SrcData (UserBadgeId)
CREATE NONCLUSTERED INDEX IDX_ETL_DeltaHashKey ON #SrcData (ETL_DeltaHashKey)


MERGE ods.SkiData_UserBadges AS myTarget
USING #SrcData AS mySource
ON myTarget.UserBadgeId = mySource.UserBadgeId

WHEN MATCHED AND (
     ISNULL(mySource.ETL_DeltaHashKey,-1) <> ISNULL(myTarget.ETL_DeltaHashKey, -1)
)
THEN UPDATE SET
      myTarget.[ETL_UpdatedDate] = @RunTime
     ,myTarget.[ETL_DeltaHashKey] = mySource.[ETL_DeltaHashKey]
	 ,myTarget.[ETL_SourceFileName] = mySource.[ETL_SourceFileName]
     ,myTarget.[UserBadgeID] = mySource.[UserBadgeID]
     ,myTarget.[Title] = mySource.[Title]
     ,myTarget.[Description] = mySource.[Description]
     ,myTarget.[UserID] = mySource.[UserID]
     ,myTarget.[BadgeID] = mySource.[BadgeID]
     ,myTarget.[DateCreated] = mySource.[DateCreated]
     ,myTarget.[DateUpdated] = mySource.[DateUpdated]
	 ,myTarget.[IsValid] = mySource.[IsValid]
     ,myTarget.[ManuallyAwardedByUserID] = mySource.[ManuallyAwardedByUserID]

WHEN NOT MATCHED BY TARGET
THEN INSERT
     ([ETL_CreatedDate]
     ,[ETL_UpdatedDate]
     ,[ETL_IsDeleted]
     ,[ETL_DeletedDate]
     ,[ETL_DeltaHashKey]
     ,[ETL_SourceFileName]
     ,[UserBadgeID]
     ,[Title]
     ,[Description]
     ,[UserID]
     ,[BadgeID]
     ,[DateCreated]
     ,[DateUpdated]
	 ,[IsValid]
	 ,[ManuallyAwardedByUserID]
     )
VALUES
     (@RunTime --ETL_CreatedDate
     ,@RunTime --ETL_UpdateddDate
     ,0 --ETL_DeletedDate
     ,NULL --ETL_DeletedDate
     ,mySource.[ETL_DeltaHashKey]
	 ,mySource.[ETL_SourceFileName]
     ,mySource.[UserBadgeID]
     ,mySource.[Title]
     ,mySource.[Description]
     ,mySource.[UserID]
     ,mySource.[BadgeID]
     ,mySource.[DateCreated]
     ,mySource.[DateUpdated]
	 ,mySource.[IsValid]
	 ,mySource.[ManuallyAwardedByUserID]
     )
;



DECLARE @MergeInsertRowCount int = ISNULL((SELECT CONVERT(varchar, COUNT(*)) FROM ods.SkiData_UserBadges WHERE ETL_CreatedDate >= @RunTime AND ETL_UpdatedDate = ETL_CreatedDate),'0');	
DECLARE @MergeUpdateRowCount int = ISNULL((SELECT CONVERT(varchar, COUNT(*)) FROM ods.SkiData_UserBadges WHERE ETL_UpdatedDate >= @RunTime AND ETL_UpdatedDate > ETL_CreatedDate),'0');	


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
