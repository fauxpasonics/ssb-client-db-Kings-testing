SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE [etl].[Load_ods_SkiData_RewardRedemptions]
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
Date:     12/06/2016
Comments: Initial creation
*************************************************************************************/

DECLARE @RunTime DATETIME = GETDATE()

DECLARE @ExecutionId uniqueidentifier = newid();
DECLARE @ProcedureName NVARCHAR(255) = OBJECT_SCHEMA_NAME(@@PROCID) + '.' + OBJECT_NAME(@@PROCID);
DECLARE @SrcRowCount INT = ISNULL((SELECT CONVERT(VARCHAR, COUNT(*)) FROM src.SkiData_RewardRedemptions),'0');	
DECLARE @SrcDataSize NVARCHAR(255) = '0'

BEGIN TRY 

PRINT 'Execution Id: ' + CONVERT(NVARCHAR(100),@ExecutionId)

--SELECT CAST(NULL AS BINARY(32)) ETL_DeltaHashKey, ETL_SourceFileName, RedemptionID, RewardID, PortalID, UserID, TicketAccountID, PointAuditID, PointsPaid, Quantity, Fulfilled, FulfilledDate, DateCreated, DateUpdated, UpdatedBy, SeatID, VoucherCodeID
--INTO #SrcData
--FROM src.SkiData_RewardRedemptions

SELECT CAST(NULL AS BINARY(32)) ETL_DeltaHashKey, a.ETL_SourceFileName, a.RedemptionID, a.RewardID, a.PortalID, a.UserID, a.TicketAccountID, a.PointAuditID, a.PointsPaid, a.Quantity, a.Fulfilled, a.FulfilledDate, a.DateCreated, a.DateUpdated, a.UpdatedBy, a.SeatID, a.VoucherCodeID, a.RowRank
INTO #SrcData
FROM (
	SELECT *
	, ROW_NUMBER() OVER (PARTITION BY RedemptionID ORDER BY ETL_ID DESC) RowRank
	FROM src.SkiData_RewardRedemptions
) a
WHERE RowRank = 1


UPDATE #SrcData
SET ETL_DeltaHashKey = HASHBYTES('sha2_256', ISNULL(RTRIM(DateCreated),'DBNULL_TEXT') + ISNULL(RTRIM(DateUpdated),'DBNULL_TEXT') + ISNULL(RTRIM(Fulfilled),'DBNULL_TEXT') + ISNULL(RTRIM(FulfilledDate),'DBNULL_TEXT') + ISNULL(RTRIM(PointAuditID),'DBNULL_TEXT') + ISNULL(RTRIM(PointsPaid),'DBNULL_TEXT') + ISNULL(RTRIM(PortalID),'DBNULL_TEXT') + ISNULL(RTRIM(Quantity),'DBNULL_TEXT') + ISNULL(RTRIM(RedemptionID),'DBNULL_TEXT') + ISNULL(RTRIM(RewardID),'DBNULL_TEXT') + ISNULL(RTRIM(SeatID),'DBNULL_TEXT') + ISNULL(RTRIM(TicketAccountID),'DBNULL_TEXT') + ISNULL(RTRIM(UpdatedBy),'DBNULL_TEXT') + ISNULL(RTRIM(UserID),'DBNULL_TEXT') + ISNULL(RTRIM(VoucherCodeID),'DBNULL_TEXT'))

CREATE NONCLUSTERED INDEX IDX_Load_Key ON #SrcData (RedemptionID)
CREATE NONCLUSTERED INDEX IDX_ETL_DeltaHashKey ON #SrcData (ETL_DeltaHashKey)

MERGE ods.SkiData_RewardRedemptions AS myTarget
USING #SrcData AS mySource
ON myTarget.RedemptionID = mySource.RedemptionID

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
     ,myTarget.[RedemptionID] = mySource.[RedemptionID]
     ,myTarget.[RewardID] = mySource.[RewardID]
     ,myTarget.[PortalID] = mySource.[PortalID]
     ,myTarget.[UserID] = mySource.[UserID]
     ,myTarget.[TicketAccountID] = mySource.[TicketAccountID]
     ,myTarget.[PointAuditID] = mySource.[PointAuditID]
     ,myTarget.[PointsPaid] = mySource.[PointsPaid]
     ,myTarget.[Quantity] = mySource.[Quantity]
     ,myTarget.[Fulfilled] = mySource.[Fulfilled]
     ,myTarget.[FulfilledDate] = mySource.[FulfilledDate]
     ,myTarget.[DateCreated] = mySource.[DateCreated]
     ,myTarget.[DateUpdated] = mySource.[DateUpdated]
     ,myTarget.[UpdatedBy] = mySource.[UpdatedBy]
     ,myTarget.[SeatID] = mySource.[SeatID]
     ,myTarget.[VoucherCodeID] = mySource.[VoucherCodeID]
     

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
     ,[RedemptionID]
     ,[RewardID]
     ,[PortalID]
     ,[UserID]
     ,[TicketAccountID]
     ,[PointAuditID]
     ,[PointsPaid]
     ,[Quantity]
     ,[Fulfilled]
     ,[FulfilledDate]
     ,[DateCreated]
     ,[DateUpdated]
     ,[UpdatedBy]
     ,[SeatID]
     ,[VoucherCodeID]
     )
VALUES
     (@RunTime --ETL_CreatedDate
     ,@RunTime --ETL_UpdateddDate
     ,0			--ETL_IsDeleted
     ,NULL		--ETL_DeletedDate
     ,mySource.[ETL_DeltaHashKey]
	 ,mySource.[ETL_SourceFileName]
     ,mySource.[RedemptionID]
     ,mySource.[RewardID]
     ,mySource.[PortalID]
     ,mySource.[UserID]
     ,mySource.[TicketAccountID]
     ,mySource.[PointAuditID]
     ,mySource.[PointsPaid]
     ,mySource.[Quantity]
     ,mySource.[Fulfilled]
     ,mySource.[FulfilledDate]
     ,mySource.[DateCreated]
     ,mySource.[DateUpdated]
     ,mySource.[UpdatedBy]
     ,mySource.[SeatID]
     ,mySource.[VoucherCodeID]
     )
;



DECLARE @MergeInsertRowCount int = ISNULL((SELECT CONVERT(varchar, COUNT(*)) FROM ods.SkiData_RewardRedemptions WHERE ETL_CreatedDate >= @RunTime AND ETL_UpdatedDate = ETL_CreatedDate),'0');	
DECLARE @MergeUpdateRowCount int = ISNULL((SELECT CONVERT(varchar, COUNT(*)) FROM ods.SkiData_RewardRedemptions WHERE ETL_UpdatedDate >= @RunTime AND ETL_UpdatedDate > ETL_CreatedDate),'0');	


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
