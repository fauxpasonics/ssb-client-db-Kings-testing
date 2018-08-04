SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE PROCEDURE [etl].[Load_ods_SkiData_UserInfoAndActivity]
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
DECLARE @SrcRowCount int = ISNULL((SELECT CONVERT(varchar, COUNT(*)) FROM src.SkiData_UserInfoAndActivity),'0');	
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
,  ETL_SourceFileName, TicketAccountID, UserID, Username, FirstName, LastName, Email, DisplayName, Deleted, Authorised, CreateDate, TotalPointsEarned, PointsRemaining, TotalPointsSpent, LastLoginDate, HasLoggedIn, HasRedeemed
INTO #SrcData
FROM (
	SELECT  ETL_SourceFileName, TicketAccountID, UserID, Username, FirstName, LastName, Email, DisplayName, Deleted, Authorised, CreateDate, TotalPointsEarned, PointsRemaining, TotalPointsSpent, LastLoginDate, HasLoggedIn, HasRedeemed
	, ROW_NUMBER() OVER(PARTITION BY UserID ORDER BY ETL_ID) RowRank
	FROM src.SkiData_UserInfoAndActivity
) a
WHERE RowRank = 1

EXEC etl.LogEventRecordDB @Batchid, 'Info', @ProcedureName, 'Merge Load', 'Src Table Setup', 'Temp Table Loaded', @ExecutionId

UPDATE #SrcData
SET ETL_DeltaHashKey = HASHBYTES('sha2_256', ISNULL(RTRIM(Authorised),'DBNULL_TEXT') + ISNULL(RTRIM(CreateDate),'DBNULL_TEXT') + ISNULL(RTRIM(Deleted),'DBNULL_TEXT') + ISNULL(RTRIM(DisplayName),'DBNULL_TEXT') + ISNULL(RTRIM(Email),'DBNULL_TEXT') + ISNULL(RTRIM(FirstName),'DBNULL_TEXT') + ISNULL(RTRIM(HasLoggedIn),'DBNULL_TEXT') + ISNULL(RTRIM(HasRedeemed),'DBNULL_TEXT') + ISNULL(RTRIM(LastLoginDate),'DBNULL_TEXT') + ISNULL(RTRIM(LastName),'DBNULL_TEXT') + ISNULL(RTRIM(PointsRemaining),'DBNULL_TEXT') + ISNULL(RTRIM(TicketAccountID),'DBNULL_TEXT') + ISNULL(RTRIM(TotalPointsEarned),'DBNULL_TEXT') + ISNULL(RTRIM(TotalPointsSpent),'DBNULL_TEXT') + ISNULL(RTRIM(UserID),'DBNULL_TEXT') + ISNULL(RTRIM(Username),'DBNULL_TEXT'))

EXEC etl.LogEventRecordDB @Batchid, 'Info', @ProcedureName, 'Merge Load', 'Src Table Setup', 'ETL_DeltaHashKey Set', @ExecutionId

CREATE NONCLUSTERED INDEX IDX_Load_Key ON #SrcData (UserID)
CREATE NONCLUSTERED INDEX IDX_ETL_DeltaHashKey ON #SrcData (ETL_DeltaHashKey)

EXEC etl.LogEventRecordDB @Batchid, 'Info', @ProcedureName, 'Merge Load', 'Src Table Setup', 'Temp Table Indexes Created', @ExecutionId

EXEC etl.LogEventRecordDB @Batchid, 'Info', @ProcedureName, 'Merge Load', 'Merge Statement Execution', 'Start', @ExecutionId

MERGE ods.SkiData_UserInfoAndActivity AS myTarget
USING (
	SELECT * FROM #SrcData
) AS mySource
ON myTarget.UserID = mySource.UserID

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
     , myTarget.[Username] = mySource.[Username]
     , myTarget.[FirstName] = mySource.[FirstName]
     , myTarget.[LastName] = mySource.[LastName]
     , myTarget.[Email] = mySource.[Email]
     , myTarget.[DisplayName] = mySource.[DisplayName]
     , myTarget.[Deleted] = mySource.[Deleted]
     , myTarget.[Authorised] = mySource.[Authorised]
     , myTarget.[CreateDate] = mySource.[CreateDate]
     , myTarget.[TotalPointsEarned] = mySource.[TotalPointsEarned]
     , myTarget.[PointsRemaining] = mySource.[PointsRemaining]
     , myTarget.[TotalPointsSpent] = mySource.[TotalPointsSpent]
     , myTarget.[LastLoginDate] = mySource.[LastLoginDate]
     , myTarget.[HasLoggedIn] = mySource.[HasLoggedIn]
     , myTarget.[HasRedeemed] = mySource.[HasRedeemed]
 

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
     ,[Username]
     ,[FirstName]
     ,[LastName]
     ,[Email]
     ,[DisplayName]
     ,[Deleted]
     ,[Authorised]
     ,[CreateDate]
     ,[TotalPointsEarned]
     ,[PointsRemaining]
     ,[TotalPointsSpent]
     ,[LastLoginDate]
     ,[HasLoggedIn]
     ,[HasRedeemed]
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
     ,mySource.[Username]
     ,mySource.[FirstName]
     ,mySource.[LastName]
     ,mySource.[Email]
     ,mySource.[DisplayName]
     ,mySource.[Deleted]
     ,mySource.[Authorised]
     ,mySource.[CreateDate]
     ,mySource.[TotalPointsEarned]
     ,mySource.[PointsRemaining]
     ,mySource.[TotalPointsSpent]
     ,mySource.[LastLoginDate]
     ,mySource.[HasLoggedIn]
     ,mySource.[HasRedeemed]
     )
;

EXEC etl.LogEventRecordDB @Batchid, 'Info', @ProcedureName, 'Merge Load', 'Merge Statement Execution', 'Complete', @ExecutionId

DECLARE @MergeInsertRowCount int = ISNULL((SELECT CONVERT(varchar, COUNT(*)) FROM ods.SkiData_UserInfoAndActivity WHERE ETL_CreatedDate >= @RunTime AND ETL_UpdatedDate = ETL_CreatedDate),'0');	
DECLARE @MergeUpdateRowCount int = ISNULL((SELECT CONVERT(varchar, COUNT(*)) FROM ods.SkiData_UserInfoAndActivity WHERE ETL_UpdatedDate >= @RunTime AND ETL_UpdatedDate > ETL_CreatedDate),'0');	

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
