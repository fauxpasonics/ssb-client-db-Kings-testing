SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE PROCEDURE [etl].[Load_ods_Eloqua_ActivityFormSubmit]
(
	@BatchId INT = 0,
	@Options NVARCHAR(MAX) = NULL
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
DECLARE @SrcRowCount INT = ISNULL((SELECT CONVERT(VARCHAR, COUNT(*)) FROM src.Eloqua_ActivityFormSubmit),'0');	
DECLARE @SrcDataSize NVARCHAR(255) = '0'

BEGIN TRY 

PRINT 'Execution Id: ' + CONVERT(NVARCHAR(100),@ExecutionId)

SELECT CAST(NULL AS nvarchar(max)) ETL_DeltaHashKey, ETL_UpdatedDate, ETL_IsDeleted, ETL_DeletedDate, ID, Name, CreatedAt, Type, AssetName, AssetId, AssetType, ContactId, Collection, FormName, FormData, RawData, CampaignId
INTO #SrcData
FROM src.Eloqua_ActivityFormSubmit

-- convert characters from UTF
update #SrcData
set RawData = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(RawData,'%24','$'),'%21','!'),'%27',''''),'%2b','+'),'%7e','~'),'%5e','^'),'%5b','['),'%5d',']'),'%5c','\'),'%3b',';'),'%5f','_'),'%3c','<'),'%3e','>'),'%3d','='),'%3f','?'),'%23','#'),'%26','&'),'%29',')'),'%28','('),'%3a',':'),'%2f','/'),'%40','@'),'%20',' ')


UPDATE #SrcData
SET ETL_DeltaHashKey = HASHBYTES('sha2_256', ISNULL(RTRIM(AssetId),'DBNULL_TEXT') + ISNULL(RTRIM(AssetName),'DBNULL_TEXT')
 + ISNULL(RTRIM(AssetType),'DBNULL_TEXT') + ISNULL(RTRIM(CampaignId),'DBNULL_TEXT') + ISNULL(RTRIM(Collection),'DBNULL_TEXT')
  + ISNULL(RTRIM(ContactId),'DBNULL_TEXT') + ISNULL(RTRIM(CONVERT(varchar(25),CreatedAt)),'DBNULL_DATETIME') 
  + ISNULL(RTRIM(FormData),'DBNULL_TEXT') + ISNULL(RTRIM(FormName),'DBNULL_TEXT') + ISNULL(RTRIM(ID),'DBNULL_TEXT') + ISNULL(RTRIM(Name),'DBNULL_TEXT')
  + ISNULL(RTRIM(Type),'DBNULL_TEXT'));


CREATE NONCLUSTERED INDEX IDX_Load_Key ON #SrcData (ID);


MERGE ods.Eloqua_ActivityFormSubmit AS myTarget
USING #SrcData AS mySource
ON myTarget.ID = mySource.ID

WHEN MATCHED AND (
     ISNULL(mySource.ETL_DeltaHashKey,-1) <> ISNULL(myTarget.ETL_DeltaHashKey, -1)
	 OR myTarget.ETL_IsDeleted = 1
)
THEN UPDATE SET
      myTarget.[ETL_UpdatedDate] = @RunTime
	 ,myTarget.[ETL_IsDeleted] = 0
	 ,myTarget.[ETL_DeletedDate] = NULL
     ,myTarget.[ETL_DeltaHashKey] = mySource.[ETL_DeltaHashKey]
     ,myTarget.[ID] = mySource.[ID]
     ,myTarget.[Name] = mySource.[Name]
     ,myTarget.[CreatedAt] = mySource.[CreatedAt]
     ,myTarget.[Type] = mySource.[Type]
     ,myTarget.[AssetName] = mySource.[AssetName]
     ,myTarget.[AssetId] = mySource.[AssetId]
     ,myTarget.[AssetType] = mySource.[AssetType]
     ,myTarget.[ContactId] = mySource.[ContactId]
     ,myTarget.[Collection] = mySource.[Collection]
     ,myTarget.[FormName] = mySource.[FormName]
     ,myTarget.[FormData] = mySource.[FormData]
     ,myTarget.[RawData] = mySource.[RawData]
     ,myTarget.[CampaignId] = mySource.[CampaignId]

WHEN NOT MATCHED BY SOURCE AND myTarget.ETL_IsDeleted = 0
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
     ,[ID]
     ,[Name]
     ,[CreatedAt]
     ,[Type]
     ,[AssetName]
     ,[AssetId]
     ,[AssetType]
     ,[ContactId]
     ,[Collection]
     ,[FormName]
     ,[FormData]
     ,[RawData]
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
     ,mySource.[Collection]
     ,mySource.[FormName]
     ,mySource.[FormData]
     ,mySource.[RawData]
     ,mySource.[CampaignId]
     )
;


DECLARE @MergeInsertRowCount INT = ISNULL((SELECT CONVERT(VARCHAR, COUNT(*)) FROM ods.Eloqua_ActivityFormSubmit WHERE ETL_CreatedDate >= @RunTime AND ETL_UpdatedDate = ETL_CreatedDate),'0');	
DECLARE @MergeUpdateRowCount INT = ISNULL((SELECT CONVERT(VARCHAR, COUNT(*)) FROM ods.Eloqua_ActivityFormSubmit WHERE ETL_UpdatedDate >= @RunTime AND ETL_UpdatedDate > ETL_CreatedDate),'0');	


END TRY 
BEGIN CATCH 

	DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
	DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
	DECLARE @ErrorState INT = ERROR_STATE();
			
	PRINT @ErrorMessage

	RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)

END CATCH


END
















GO
