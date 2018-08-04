SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE [etl].[Load_ods_SkiData_Rewards]
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
Date:     05/26/2016
Comments: Initial creation
*************************************************************************************/

DECLARE @RunTime DATETIME = GETDATE()

DECLARE @ExecutionId uniqueidentifier = newid();
DECLARE @ProcedureName NVARCHAR(255) = OBJECT_SCHEMA_NAME(@@PROCID) + '.' + OBJECT_NAME(@@PROCID);
DECLARE @SrcRowCount INT = ISNULL((SELECT CONVERT(VARCHAR, COUNT(*)) FROM src.SkiData_Rewards),'0');	
DECLARE @SrcDataSize NVARCHAR(255) = '0'

BEGIN TRY 

PRINT 'Execution Id: ' + CONVERT(NVARCHAR(100),@ExecutionId)

SELECT CAST(NULL AS BINARY(32)) ETL_DeltaHashKey, ETL_SourceFileName, RewardID, PortalID, Title, CostInPoints, NotForSale, RequiredRoleID, AdministratorUserID, RewardRedemptionAdministratorMessageTemplateID, RewardRedemptionMessageTemplateID, AvailableStartDate, AvailableEndDate, QuantityAvailable, QuantityRemaining, DefaultImage, CssClass, IsAuction, AuctionID, Ordinal, IsFeatured, Active, DateCreated, DateUpdated, UpdatedBy, IsShowcased, RewardCategoryID, RewardURL, BuyNowCost, IsVoucher, RedemptionCode, AwardPointActivityID, AwardPointOverride, PerUserCap, LoyaltyProductID
INTO #SrcData
FROM src.SkiData_Rewards

UPDATE #SrcData
SET ETL_DeltaHashKey = HASHBYTES('sha2_256', ISNULL(RTRIM(Active),'DBNULL_TEXT') + ISNULL(RTRIM(AdministratorUserID),'DBNULL_TEXT') + ISNULL(RTRIM(AuctionID),'DBNULL_TEXT') + ISNULL(RTRIM(AvailableEndDate),'DBNULL_TEXT') + ISNULL(RTRIM(AvailableStartDate),'DBNULL_TEXT') + ISNULL(RTRIM(AwardPointActivityID),'DBNULL_TEXT') + ISNULL(RTRIM(AwardPointOverride),'DBNULL_TEXT') + ISNULL(RTRIM(BuyNowCost),'DBNULL_TEXT') + ISNULL(RTRIM(CostInPoints),'DBNULL_TEXT') + ISNULL(RTRIM(CssClass),'DBNULL_TEXT') + ISNULL(RTRIM(DateCreated),'DBNULL_TEXT') + ISNULL(RTRIM(DateUpdated),'DBNULL_TEXT') + ISNULL(RTRIM(DefaultImage),'DBNULL_TEXT') + ISNULL(RTRIM(IsAuction),'DBNULL_TEXT') + ISNULL(RTRIM(IsFeatured),'DBNULL_TEXT') + ISNULL(RTRIM(IsShowcased),'DBNULL_TEXT') + ISNULL(RTRIM(IsVoucher),'DBNULL_TEXT') + ISNULL(RTRIM(LoyaltyProductID),'DBNULL_TEXT') + ISNULL(RTRIM(NotForSale),'DBNULL_TEXT') + ISNULL(RTRIM(Ordinal),'DBNULL_TEXT') + ISNULL(RTRIM(PerUserCap),'DBNULL_TEXT') + ISNULL(RTRIM(PortalID),'DBNULL_TEXT') + ISNULL(RTRIM(QuantityAvailable),'DBNULL_TEXT') + ISNULL(RTRIM(QuantityRemaining),'DBNULL_TEXT') + ISNULL(RTRIM(RedemptionCode),'DBNULL_TEXT') + ISNULL(RTRIM(RequiredRoleID),'DBNULL_TEXT') + ISNULL(RTRIM(RewardCategoryID),'DBNULL_TEXT') + ISNULL(RTRIM(RewardID),'DBNULL_TEXT') + ISNULL(RTRIM(RewardRedemptionAdministratorMessageTemplateID),'DBNULL_TEXT') + ISNULL(RTRIM(RewardRedemptionMessageTemplateID),'DBNULL_TEXT') + ISNULL(RTRIM(RewardURL),'DBNULL_TEXT') + ISNULL(RTRIM(Title),'DBNULL_TEXT') + ISNULL(RTRIM(UpdatedBy),'DBNULL_TEXT'))


CREATE NONCLUSTERED INDEX IDX_Load_Key ON #SrcData (RewardID)
CREATE NONCLUSTERED INDEX IDX_ETL_DeltaHashKey ON #SrcData (ETL_DeltaHashKey)


MERGE ods.SkiData_Rewards AS myTarget
USING #SrcData AS mySource
ON myTarget.RewardID = mySource.RewardID

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
     ,myTarget.[RewardID] = mySource.[RewardID]
     ,myTarget.[PortalID] = mySource.[PortalID]
     ,myTarget.[Title] = mySource.[Title]
     ,myTarget.[CostInPoints] = mySource.[CostInPoints]
     ,myTarget.[NotForSale] = mySource.[NotForSale]
     ,myTarget.[RequiredRoleID] = mySource.[RequiredRoleID]
     ,myTarget.[AdministratorUserID] = mySource.[AdministratorUserID]
     ,myTarget.[RewardRedemptionAdministratorMessageTemplateID] = mySource.[RewardRedemptionAdministratorMessageTemplateID]
     ,myTarget.[RewardRedemptionMessageTemplateID] = mySource.[RewardRedemptionMessageTemplateID]
     ,myTarget.[AvailableStartDate] = mySource.[AvailableStartDate]
     ,myTarget.[AvailableEndDate] = mySource.[AvailableEndDate]
     ,myTarget.[QuantityAvailable] = mySource.[QuantityAvailable]
     ,myTarget.[QuantityRemaining] = mySource.[QuantityRemaining]
     ,myTarget.[DefaultImage] = mySource.[DefaultImage]
     ,myTarget.[CssClass] = mySource.[CssClass]
     ,myTarget.[IsAuction] = mySource.[IsAuction]
     ,myTarget.[AuctionID] = mySource.[AuctionID]
     ,myTarget.[Ordinal] = mySource.[Ordinal]
     ,myTarget.[IsFeatured] = mySource.[IsFeatured]
     ,myTarget.[Active] = mySource.[Active]
     ,myTarget.[DateCreated] = mySource.[DateCreated]
     ,myTarget.[DateUpdated] = mySource.[DateUpdated]
     ,myTarget.[UpdatedBy] = mySource.[UpdatedBy]
     ,myTarget.[IsShowcased] = mySource.[IsShowcased]
     ,myTarget.[RewardCategoryID] = mySource.[RewardCategoryID]
     ,myTarget.[RewardURL] = mySource.[RewardURL]
     ,myTarget.[BuyNowCost] = mySource.[BuyNowCost]
     ,myTarget.[IsVoucher] = mySource.[IsVoucher]
     ,myTarget.[RedemptionCode] = mySource.[RedemptionCode]
     ,myTarget.[AwardPointActivityID] = mySource.[AwardPointActivityID]
     ,myTarget.[AwardPointOverride] = mySource.[AwardPointOverride]
     ,myTarget.[PerUserCap] = mySource.[PerUserCap]
     ,myTarget.[LoyaltyProductID] = mySource.[LoyaltyProductID]
      

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
     ,[RewardID]
     ,[PortalID]
     ,[Title]
     ,[CostInPoints]
     ,[NotForSale]
     ,[RequiredRoleID]
     ,[AdministratorUserID]
     ,[RewardRedemptionAdministratorMessageTemplateID]
     ,[RewardRedemptionMessageTemplateID]
     ,[AvailableStartDate]
     ,[AvailableEndDate]
     ,[QuantityAvailable]
     ,[QuantityRemaining]
     ,[DefaultImage]
     ,[CssClass]
     ,[IsAuction]
     ,[AuctionID]
     ,[Ordinal]
     ,[IsFeatured]
     ,[Active]
     ,[DateCreated]
     ,[DateUpdated]
     ,[UpdatedBy]
     ,[IsShowcased]
     ,[RewardCategoryID]
     ,[RewardURL]
     ,[BuyNowCost]
     ,[IsVoucher]
     ,[RedemptionCode]
     ,[AwardPointActivityID]
     ,[AwardPointOverride]
     ,[PerUserCap]
     ,[LoyaltyProductID]
     )
VALUES
     (@RunTime --ETL_CreatedDate
     ,@RunTime --ETL_UpdateddDate
     ,0 --ETL_DeletedDate
     ,NULL --ETL_DeletedDate
     ,mySource.[ETL_DeltaHashKey]
	 ,mySource.[ETL_SourceFileName]
     ,mySource.[RewardID]
     ,mySource.[PortalID]
     ,mySource.[Title]
     ,mySource.[CostInPoints]
     ,mySource.[NotForSale]
     ,mySource.[RequiredRoleID]
     ,mySource.[AdministratorUserID]
     ,mySource.[RewardRedemptionAdministratorMessageTemplateID]
     ,mySource.[RewardRedemptionMessageTemplateID]
     ,mySource.[AvailableStartDate]
     ,mySource.[AvailableEndDate]
     ,mySource.[QuantityAvailable]
     ,mySource.[QuantityRemaining]
     ,mySource.[DefaultImage]
     ,mySource.[CssClass]
     ,mySource.[IsAuction]
     ,mySource.[AuctionID]
     ,mySource.[Ordinal]
     ,mySource.[IsFeatured]
     ,mySource.[Active]
     ,mySource.[DateCreated]
     ,mySource.[DateUpdated]
     ,mySource.[UpdatedBy]
     ,mySource.[IsShowcased]
     ,mySource.[RewardCategoryID]
     ,mySource.[RewardURL]
     ,mySource.[BuyNowCost]
     ,mySource.[IsVoucher]
     ,mySource.[RedemptionCode]
     ,mySource.[AwardPointActivityID]
     ,mySource.[AwardPointOverride]
     ,mySource.[PerUserCap]
     ,mySource.[LoyaltyProductID]
     )
;



DECLARE @MergeInsertRowCount int = ISNULL((SELECT CONVERT(varchar, COUNT(*)) FROM ods.SkiData_Rewards WHERE ETL_CreatedDate >= @RunTime AND ETL_UpdatedDate = ETL_CreatedDate),'0');	
DECLARE @MergeUpdateRowCount int = ISNULL((SELECT CONVERT(varchar, COUNT(*)) FROM ods.SkiData_Rewards WHERE ETL_UpdatedDate >= @RunTime AND ETL_UpdatedDate > ETL_CreatedDate),'0');	


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
