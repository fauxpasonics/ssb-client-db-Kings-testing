SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE [etl].[Load_ods_Eloqua_ActivityWebVisit]
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
DECLARE @SrcRowCount INT = ISNULL((SELECT CONVERT(VARCHAR, COUNT(*)) FROM src.Eloqua_ActivityWebVisit),'0');	
DECLARE @SrcDataSize NVARCHAR(255) = '0'

BEGIN TRY 

PRINT 'Execution Id: ' + CONVERT(NVARCHAR(100),@ExecutionId)

SELECT CAST(NULL AS BINARY(32)) ETL_DeltaHashKey, ETL_UpdatedDate, ETL_IsDeleted, ETL_DeletedDate, ID, Name, CreatedAt, Type, AssetId, AssetType, ContactId, Duration, QueryString, QueryStringDisplay, Thread, URL, ReferrerUrl, VisitorExternalId, NumberOfPages, IpAddress, FirstPageViewUrl
INTO #SrcData
FROM src.Eloqua_ActivityWebVisit

UPDATE #SrcData
SET ETL_DeltaHashKey = HASHBYTES('sha2_256', ISNULL(RTRIM(AssetId),'DBNULL_TEXT') + ISNULL(RTRIM(AssetType),'DBNULL_TEXT') + ISNULL(RTRIM(ContactId),'DBNULL_TEXT') + ISNULL(RTRIM(CONVERT(varchar(25),CreatedAt)),'DBNULL_DATETIME') + ISNULL(RTRIM(Duration),'DBNULL_TEXT') + ISNULL(RTRIM(FirstPageViewUrl),'DBNULL_TEXT') + ISNULL(RTRIM(ID),'DBNULL_TEXT') + ISNULL(RTRIM(IpAddress),'DBNULL_TEXT') + ISNULL(RTRIM(Name),'DBNULL_TEXT') + ISNULL(RTRIM(NumberOfPages),'DBNULL_TEXT') + ISNULL(RTRIM(QueryString),'DBNULL_TEXT') + ISNULL(RTRIM(QueryStringDisplay),'DBNULL_TEXT') + ISNULL(RTRIM(ReferrerUrl),'DBNULL_TEXT') + ISNULL(RTRIM(Thread),'DBNULL_TEXT') + ISNULL(RTRIM(Type),'DBNULL_TEXT') + ISNULL(RTRIM(URL),'DBNULL_TEXT') + ISNULL(RTRIM(VisitorExternalId),'DBNULL_TEXT'))

-- convert UTF back to ASCII
update #SrcData
set ReferrerUrl = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(ReferrerUrl,'%2B','+'),'%26','&'),'%5E','^'),'%22','"'),'%3D','='),'%20',' '),'%3F','?'),'%2F','/'),'%3A',':')


CREATE NONCLUSTERED INDEX IDX_Load_Key ON #SrcData (ID)
CREATE NONCLUSTERED INDEX IDX_ETL_DeltaHashKey ON #SrcData (ETL_DeltaHashKey)



MERGE ods.Eloqua_ActivityWebVisit AS myTarget

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
     ,myTarget.[AssetId] = mySource.[AssetId]
     ,myTarget.[AssetType] = mySource.[AssetType]
     ,myTarget.[ContactId] = mySource.[ContactId]
     ,myTarget.[Duration] = mySource.[Duration]
     ,myTarget.[QueryString] = mySource.[QueryString]
     ,myTarget.[QueryStringDisplay] = mySource.[QueryStringDisplay]
     ,myTarget.[Thread] = mySource.[Thread]
     ,myTarget.[URL] = mySource.[URL]
     ,myTarget.[ReferrerUrl] = mySource.[ReferrerUrl]
     ,myTarget.[VisitorExternalId] = mySource.[VisitorExternalId]
     ,myTarget.[NumberOfPages] = mySource.[NumberOfPages]
     ,myTarget.[IpAddress] = mySource.[IpAddress]
     ,myTarget.[FirstPageViewUrl] = mySource.[FirstPageViewUrl]
     
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
     ,[AssetId]
     ,[AssetType]
     ,[ContactId]
     ,[Duration]
     ,[QueryString]
     ,[QueryStringDisplay]
     ,[Thread]
     ,[URL]
     ,[ReferrerUrl]
     ,[VisitorExternalId]
     ,[NumberOfPages]
     ,[IpAddress]
     ,[FirstPageViewUrl]
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
     ,mySource.[AssetId]
     ,mySource.[AssetType]
     ,mySource.[ContactId]
     ,mySource.[Duration]
     ,mySource.[QueryString]
     ,mySource.[QueryStringDisplay]
     ,mySource.[Thread]
     ,mySource.[URL]
     ,mySource.[ReferrerUrl]
     ,mySource.[VisitorExternalId]
     ,mySource.[NumberOfPages]
     ,mySource.[IpAddress]
     ,mySource.[FirstPageViewUrl]
     )
;



DECLARE @MergeInsertRowCount int = ISNULL((SELECT CONVERT(varchar, COUNT(*)) FROM ods.Eloqua_ActivityWebVisit WHERE ETL_CreatedDate >= @RunTime AND ETL_UpdatedDate = ETL_CreatedDate),'0');	
DECLARE @MergeUpdateRowCount int = ISNULL((SELECT CONVERT(varchar, COUNT(*)) FROM ods.Eloqua_ActivityWebVisit WHERE ETL_UpdatedDate >= @RunTime AND ETL_UpdatedDate > ETL_CreatedDate),'0');	


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
