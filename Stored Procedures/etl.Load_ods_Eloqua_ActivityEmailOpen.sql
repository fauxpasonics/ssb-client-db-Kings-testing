SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [etl].[Load_ods_Eloqua_ActivityEmailOpen]
(
	@BatchId INT = 0,
	@Options NVARCHAR(MAX) = null
)
AS 

BEGIN
/**************************************Comments***************************************
**************************************************************************************
Mod #:  1
Name:     svcETL
Date:     01/23/2016
Comments: Initial creation
*************************************************************************************/

DECLARE @RunTime DATETIME = GETDATE()

DECLARE @ExecutionId uniqueidentifier = newid();
DECLARE @ProcedureName NVARCHAR(255) = OBJECT_SCHEMA_NAME(@@PROCID) + '.' + OBJECT_NAME(@@PROCID);
DECLARE @SrcRowCount INT = ISNULL((SELECT CONVERT(VARCHAR, COUNT(*)) FROM src.Eloqua_ActivityEmailOpen),'0');	
DECLARE @SrcDataSize NVARCHAR(255) = '0'

BEGIN TRY 

PRINT 'Execution Id: ' + CONVERT(NVARCHAR(100),@ExecutionId)

SELECT CAST(NULL AS BINARY(32)) ETL_DeltaHashKey, ETL_UpdatedDate, ETL_IsDeleted, ETL_DeletedDate, ID, Name, CreatedAt, Type, AssetName, AssetId, AssetType, ContactId, EmailName, EmailWebLink, EmailRecipientId, IPAddress, SubjectLine, CampaignId
INTO #SrcData
FROM src.Eloqua_ActivityEmailOpen

UPDATE #SrcData
SET ETL_DeltaHashKey = HASHBYTES('sha2_256', ISNULL(RTRIM(AssetId),'DBNULL_TEXT') + ISNULL(RTRIM(AssetName),'DBNULL_TEXT') + ISNULL(RTRIM(AssetType),'DBNULL_TEXT') + ISNULL(RTRIM(CampaignId),'DBNULL_TEXT') + ISNULL(RTRIM(ContactId),'DBNULL_TEXT') + ISNULL(RTRIM(CONVERT(varchar(25),CreatedAt)),'DBNULL_DATETIME') + ISNULL(RTRIM(EmailName),'DBNULL_TEXT') + ISNULL(RTRIM(EmailRecipientId),'DBNULL_TEXT') + ISNULL(RTRIM(EmailWebLink),'DBNULL_TEXT') + ISNULL(RTRIM(ID),'DBNULL_TEXT') + ISNULL(RTRIM(IPAddress),'DBNULL_TEXT') + ISNULL(RTRIM(Name),'DBNULL_TEXT') + ISNULL(RTRIM(SubjectLine),'DBNULL_TEXT') + ISNULL(RTRIM(Type),'DBNULL_TEXT'))


CREATE NONCLUSTERED INDEX IDX_Load_Key ON #SrcData (ID)
CREATE NONCLUSTERED INDEX IDX_ETL_DeltaHashKey ON #SrcData (ETL_DeltaHashKey)



MERGE ods.Eloqua_ActivityEmailOpen AS myTarget

USING (
	SELECT * FROM #SrcData
) AS mySource
    
	ON myTarget.ID = mySource.ID

WHEN MATCHED AND (
     ISNULL(mySource.ETL_DeltaHashKey,-1) <> ISNULL(myTarget.ETL_DeltaHashKey, -1)
	 
)
THEN UPDATE SET
      myTarget.[ETL_UpdatedDate] = @RunTime
     ,myTarget.[ETL_DeltaHashKey] = mySource.[ETL_DeltaHashKey]
     ,myTarget.[ID] = mySource.[ID]
     ,myTarget.[Name] = mySource.[Name]
     ,myTarget.[CreatedAt] = mySource.[CreatedAt]
     ,myTarget.[Type] = mySource.[Type]
     ,myTarget.[AssetName] = mySource.[AssetName]
     ,myTarget.[AssetId] = mySource.[AssetId]
     ,myTarget.[AssetType] = mySource.[AssetType]
     ,myTarget.[ContactId] = mySource.[ContactId]
     ,myTarget.[EmailName] = mySource.[EmailName]
     ,myTarget.[EmailWebLink] = mySource.[EmailWebLink]
     ,myTarget.[EmailRecipientId] = mySource.[EmailRecipientId]
     ,myTarget.[IPAddress] = mySource.[IPAddress]
     ,myTarget.[SubjectLine] = mySource.[SubjectLine]
     ,myTarget.[CampaignId] = mySource.[CampaignId]
     
WHEN NOT MATCHED BY TARGET
THEN INSERT
     ([ETL_CreatedDate]
     ,[ETL_UpdatedDate]
     ,[ETL_IsDeleted]
     ,[ETL_DeletedDate]
     ,[ETL_DeltaHashKey]
     ,[ID]
     ,[Name]
     ,[CreatedAt]
     ,[Type]
     ,[AssetName]
     ,[AssetId]
     ,[AssetType]
     ,[ContactId]
     ,[EmailName]
     ,[EmailWebLink]
     ,[EmailRecipientId]
     ,[IPAddress]
     ,[SubjectLine]
     ,[CampaignId]
     )
VALUES
     (@RunTime --ETL_CreatedDate
     ,@RunTime --ETL_UpdateddDate
     ,0 --ETL_DeletedDate
     ,NULL --ETL_DeletedDate
     ,mySource.[ETL_DeltaHashKey]
     ,mySource.[ID]
     ,mySource.[Name]
     ,mySource.[CreatedAt]
     ,mySource.[Type]
     ,mySource.[AssetName]
     ,mySource.[AssetId]
     ,mySource.[AssetType]
     ,mySource.[ContactId]
     ,mySource.[EmailName]
     ,mySource.[EmailWebLink]
     ,mySource.[EmailRecipientId]
     ,mySource.[IPAddress]
     ,mySource.[SubjectLine]
     ,mySource.[CampaignId]
     )
;



DECLARE @MergeInsertRowCount int = ISNULL((SELECT CONVERT(varchar, COUNT(*)) FROM ods.Eloqua_ActivityEmailOpen WHERE ETL_CreatedDate >= @RunTime AND ETL_UpdatedDate = ETL_CreatedDate),'0');	
DECLARE @MergeUpdateRowCount int = ISNULL((SELECT CONVERT(varchar, COUNT(*)) FROM ods.Eloqua_ActivityEmailOpen WHERE ETL_UpdatedDate >= @RunTime AND ETL_UpdatedDate > ETL_CreatedDate),'0');	


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
