SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [etl].[Load_ods_LiveAnalytics_Transaction]
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
Date:     07/01/2016
Comments: Initial creation
*************************************************************************************/

DECLARE @RunTime DATETIME = GETDATE()

DECLARE @ExecutionId uniqueidentifier = newid();
DECLARE @ProcedureName NVARCHAR(255) = OBJECT_SCHEMA_NAME(@@PROCID) + '.' + OBJECT_NAME(@@PROCID);
DECLARE @SrcRowCount INT = ISNULL((SELECT CONVERT(VARCHAR, COUNT(*)) FROM stg.LiveAnalytics_Transaction),'0');	
DECLARE @SrcDataSize NVARCHAR(255) = '0'

BEGIN TRY 

PRINT 'Execution Id: ' + CONVERT(NVARCHAR(100),@ExecutionId)

SELECT CAST(NULL AS BINARY(32)) ETL_DeltaHashKey, ult_party_id, party_id, acct_id, la_id, avs_id, event_id, event_id_hex, event_dt, onsale_dt, sale_dt, tran_amt, pmt_submethod_cd, host_sys_cd, ovrrd_tran_opr_type_cd, major_cat_id, major_cat_nm, minor_cat_id, minor_cat_nm, prmy_atrcn_id, prmy_atrcn_nm, secondary_atrcn_id, secondary_atrcn_nm, ven_id, ven_nm, ven_city_nm, ven_state_nm, ven_postal_cd, ven_ctry_nm
INTO #SrcData
FROM stg.LiveAnalytics_Transaction

UPDATE #SrcData
SET ETL_DeltaHashKey = HASHBYTES('sha2_256', ISNULL(RTRIM(acct_id),'DBNULL_TEXT') + ISNULL(RTRIM(avs_id),'DBNULL_TEXT') + ISNULL(RTRIM(event_dt),'DBNULL_TEXT') + ISNULL(RTRIM(event_id),'DBNULL_TEXT') + ISNULL(RTRIM(event_id_hex),'DBNULL_TEXT') + ISNULL(RTRIM(host_sys_cd),'DBNULL_TEXT') + ISNULL(RTRIM(la_id),'DBNULL_TEXT') + ISNULL(RTRIM(major_cat_id),'DBNULL_TEXT') + ISNULL(RTRIM(major_cat_nm),'DBNULL_TEXT') + ISNULL(RTRIM(minor_cat_id),'DBNULL_TEXT') + ISNULL(RTRIM(minor_cat_nm),'DBNULL_TEXT') + ISNULL(RTRIM(onsale_dt),'DBNULL_TEXT') + ISNULL(RTRIM(ovrrd_tran_opr_type_cd),'DBNULL_TEXT') + ISNULL(RTRIM(party_id),'DBNULL_TEXT') + ISNULL(RTRIM(pmt_submethod_cd),'DBNULL_TEXT') + ISNULL(RTRIM(prmy_atrcn_id),'DBNULL_TEXT') + ISNULL(RTRIM(prmy_atrcn_nm),'DBNULL_TEXT') + ISNULL(RTRIM(sale_dt),'DBNULL_TEXT') + ISNULL(RTRIM(secondary_atrcn_id),'DBNULL_TEXT') + ISNULL(RTRIM(secondary_atrcn_nm),'DBNULL_TEXT') + ISNULL(RTRIM(tran_amt),'DBNULL_TEXT') + ISNULL(RTRIM(ult_party_id),'DBNULL_TEXT') + ISNULL(RTRIM(ven_city_nm),'DBNULL_TEXT') + ISNULL(RTRIM(ven_ctry_nm),'DBNULL_TEXT') + ISNULL(RTRIM(ven_id),'DBNULL_TEXT') + ISNULL(RTRIM(ven_nm),'DBNULL_TEXT') + ISNULL(RTRIM(ven_postal_cd),'DBNULL_TEXT') + ISNULL(RTRIM(ven_state_nm),'DBNULL_TEXT'))

CREATE NONCLUSTERED INDEX IDX_Load_Key ON #SrcData (avs_id)
CREATE NONCLUSTERED INDEX IDX_ETL_DeltaHashKey ON #SrcData (ETL_DeltaHashKey)


MERGE ods.LiveAnalytics_Transaction AS myTarget
USING (
	SELECT * FROM #SrcData
) AS mySource
ON myTarget.avs_id = mySource.avs_id

WHEN MATCHED AND (
     ISNULL(mySource.ETL_DeltaHashKey,-1) <> ISNULL(myTarget.ETL_DeltaHashKey, -1)
	 
)
THEN UPDATE SET
      myTarget.[ETL_UpdatedDate] = @RunTime
     ,myTarget.[ETL_DeltaHashKey] = mySource.[ETL_DeltaHashKey]
     ,myTarget.[ult_party_id] = mySource.[ult_party_id]
     ,myTarget.[party_id] = mySource.[party_id]
     ,myTarget.[acct_id] = mySource.[acct_id]
     ,myTarget.[la_id] = mySource.[la_id]
     ,myTarget.[avs_id] = mySource.[avs_id]
     ,myTarget.[event_id] = mySource.[event_id]
     ,myTarget.[event_id_hex] = mySource.[event_id_hex]
     ,myTarget.[event_dt] = mySource.[event_dt]
     ,myTarget.[onsale_dt] = mySource.[onsale_dt]
     ,myTarget.[sale_dt] = mySource.[sale_dt]
     ,myTarget.[tran_amt] = mySource.[tran_amt]
     ,myTarget.[pmt_submethod_cd] = mySource.[pmt_submethod_cd]
     ,myTarget.[host_sys_cd] = mySource.[host_sys_cd]
     ,myTarget.[ovrrd_tran_opr_type_cd] = mySource.[ovrrd_tran_opr_type_cd]
     ,myTarget.[major_cat_id] = mySource.[major_cat_id]
     ,myTarget.[major_cat_nm] = mySource.[major_cat_nm]
     ,myTarget.[minor_cat_id] = mySource.[minor_cat_id]
     ,myTarget.[minor_cat_nm] = mySource.[minor_cat_nm]
     ,myTarget.[prmy_atrcn_id] = mySource.[prmy_atrcn_id]
     ,myTarget.[prmy_atrcn_nm] = mySource.[prmy_atrcn_nm]
     ,myTarget.[secondary_atrcn_id] = mySource.[secondary_atrcn_id]
     ,myTarget.[secondary_atrcn_nm] = mySource.[secondary_atrcn_nm]
     ,myTarget.[ven_id] = mySource.[ven_id]
     ,myTarget.[ven_nm] = mySource.[ven_nm]
     ,myTarget.[ven_city_nm] = mySource.[ven_city_nm]
     ,myTarget.[ven_state_nm] = mySource.[ven_state_nm]
     ,myTarget.[ven_postal_cd] = mySource.[ven_postal_cd]
     ,myTarget.[ven_ctry_nm] = mySource.[ven_ctry_nm]


WHEN NOT MATCHED BY TARGET
THEN INSERT
     ([ETL_CreatedDate]
     ,[ETL_UpdatedDate]
     ,[ETL_IsDeleted]
     ,[ETL_DeletedDate]
     ,[ETL_DeltaHashKey]
     ,[ult_party_id]
     ,[party_id]
     ,[acct_id]
     ,[la_id]
     ,[avs_id]
     ,[event_id]
     ,[event_id_hex]
     ,[event_dt]
     ,[onsale_dt]
     ,[sale_dt]
     ,[tran_amt]
     ,[pmt_submethod_cd]
     ,[host_sys_cd]
     ,[ovrrd_tran_opr_type_cd]
     ,[major_cat_id]
     ,[major_cat_nm]
     ,[minor_cat_id]
     ,[minor_cat_nm]
     ,[prmy_atrcn_id]
     ,[prmy_atrcn_nm]
     ,[secondary_atrcn_id]
     ,[secondary_atrcn_nm]
     ,[ven_id]
     ,[ven_nm]
     ,[ven_city_nm]
     ,[ven_state_nm]
     ,[ven_postal_cd]
     ,[ven_ctry_nm]
     )
VALUES
     (@RunTime --ETL_CreatedDate
     ,@RunTime --ETL_UpdateddDate
     ,0 --ETL_IsDeleted
     ,NULL --ETL_DeletedDate
     ,mySource.[ETL_DeltaHashKey]
     ,mySource.[ult_party_id]
     ,mySource.[party_id]
     ,mySource.[acct_id]
     ,mySource.[la_id]
     ,mySource.[avs_id]
     ,mySource.[event_id]
     ,mySource.[event_id_hex]
     ,mySource.[event_dt]
     ,mySource.[onsale_dt]
     ,mySource.[sale_dt]
     ,mySource.[tran_amt]
     ,mySource.[pmt_submethod_cd]
     ,mySource.[host_sys_cd]
     ,mySource.[ovrrd_tran_opr_type_cd]
     ,mySource.[major_cat_id]
     ,mySource.[major_cat_nm]
     ,mySource.[minor_cat_id]
     ,mySource.[minor_cat_nm]
     ,mySource.[prmy_atrcn_id]
     ,mySource.[prmy_atrcn_nm]
     ,mySource.[secondary_atrcn_id]
     ,mySource.[secondary_atrcn_nm]
     ,mySource.[ven_id]
     ,mySource.[ven_nm]
     ,mySource.[ven_city_nm]
     ,mySource.[ven_state_nm]
     ,mySource.[ven_postal_cd]
     ,mySource.[ven_ctry_nm]
     )
;



DECLARE @MergeInsertRowCount int = ISNULL((SELECT CONVERT(varchar, COUNT(*)) FROM ods.LiveAnalytics_Transaction WHERE ETL_CreatedDate >= @RunTime AND ETL_UpdatedDate = ETL_CreatedDate),'0');	
DECLARE @MergeUpdateRowCount int = ISNULL((SELECT CONVERT(varchar, COUNT(*)) FROM ods.LiveAnalytics_Transaction WHERE ETL_UpdatedDate >= @RunTime AND ETL_UpdatedDate > ETL_CreatedDate),'0');	


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
