SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO









CREATE PROCEDURE [etl].[DimCustomer_MasterLoad]

AS
BEGIN

SELECT 1


	--post prodcopy
--Placed in Masterload sproc
INSERT INTO KingsCI_Integration.dbo.RecordTypeFlipping
SELECT GETDATE() AS [timestamp]
, flip.id
, pca.Name AS [Name] 
, CASE WHEN rt.Name LIKE '%business%' THEN pca.name  END AS companyname
, rt.Name AS RecordTYpe
, 'Post_Prodcopy' AS Step
, CASE WHEN ISNULL(pca.[BillingStreet],'') = '' THEN pcc.MailingStreet ELSE pca.[BillingStreet] END   AS AddressPrimaryStreet
, NULL AS AddressClean
, pca.loaddate AS copyloaddate
, u.Name AS lastmodifiedby
, pca.LastModifiedDate
, pca.SSB_CRMSYSTEM_ACCT_ID__c AS ssbcrmsystemacctid
, NULL AS acctprimaryflag
FROM KingsCI_Integration.dbo.vw_RecordTypeFlipping flip WITH (NOLOCK)
INNER JOIN KingsCI_Reporting.prodcopy.Account pca WITH (NOLOCK)
ON pca.Id = flip.Id
INNER JOIN KingsCI_Reporting.prodcopy.[User] u WITH (NOLOCK)
ON pca.LastModifiedById = u.Id
LEFT JOIN KingsCI_Reporting.prodcopy.Contact pcc WITH (NOLOCK)
ON pca.Primary_Contact__c = pcc.id
INNER JOIN KingsCI_Reporting.prodcopy.RecordType rt WITH (NOLOCK)
ON pca.RecordTypeId = rt.id

-- TM
--EXEC mdm.etl.LoadDimCustomer @ClientDB = 'Kings', @LoadView = '[etl].[vw_Load_DimCustomer_TM]', @LogLevel = '0', @DropTemp = '1', @IsDataUploaderSource = '0'

-- LiveA
EXEC mdm.etl.LoadDimCustomer @ClientDB = 'Kings', @LoadView = '[etl].[vw_Load_DimCustomer_LA_Cust]', @LogLevel = '0', @DropTemp = '1', @IsDataUploaderSource = '0'

-- Eloqua
EXEC mdm.etl.LoadDimCustomer @ClientDB = 'Kings', @LoadView = '[etl].[vw_Load_DimCustomer_Eloqua]', @LogLevel = '0', @DropTemp = '1', @IsDataUploaderSource = '0'

--SFDC Contact
EXEC mdm.etl.LoadDimCustomer @ClientDB = 'Kings', @LoadView = '[etl].[vw_Load_DimCustomer_SFDCContact]', @LogLevel = '0', @DropTemp = '1', @IsDataUploaderSource = '0'

--SFDC Account
EXEC mdm.etl.LoadDimCustomer @ClientDB = 'Kings', @LoadView = '[etl].[vw_Load_DimCustomer_SFDCAccount]', @LogLevel = '0', @DropTemp = '1', @IsDataUploaderSource = '0'

--SkiData
EXEC mdm.etl.LoadDimCustomer @ClientDB = 'Kings', @LoadView = '[etl].[vw_Load_DimCustomer_SKIDATA]', @LogLevel = '0', @DropTemp = '1', @IsDataUploaderSource = '0'

--Host
EXEC mdm.etl.LoadDimCustomer @ClientDB = 'Kings', @LoadView = '[etl].[vw_Load_DimCustomer_Host]', @LogLevel = '0', @DropTemp = '1', @IsDataUploaderSource = '0'

--Appetize
EXEC mdm.etl.LoadDimCustomer @ClientDB = 'Kings', @LoadView = '[etl].[vw_Load_DimCustomer_Appetize]', @LogLevel = '0', @DropTemp = '1', @IsDataUploaderSource = '0'

--FormStack
EXEC mdm.etl.LoadDimCustomer @ClientDB = 'Kings', @LoadView = '[etl].[vw_Load_DimCustomer_FormStack]', @LogLevel = '0', @DropTemp = '1', @IsDataUploaderSource = '0'

--FormStack Historical
--EXEC mdm.etl.LoadDimCustomer @ClientDB = 'Kings', @LoadView = '[etl].[vw_Load_DimCustomer_FormStack_Historical]', @LogLevel = '0', @DropTemp = '1', @IsDataUploaderSource = '0'

--Facebook
EXEC mdm.etl.LoadDimCustomer @ClientDB = 'Kings', @LoadView = '[etl].[vw_Load_DimCustomer_Facebook]', @LogLevel = '0', @DropTemp = '1', @IsDataUploaderSource = '0'

--NBA Fan Sharing Data
--EXEC mdm.etl.LoadDimCustomer @ClientDB = 'Kings', @LoadView = '[etl].[vw_Load_DimCustomer_NBA_FanData_Sharing]', @LogLevel = '0', @DropTemp = '1', @IsDataUploaderSource = '0'

	UPDATE b
	SET b.IsDeleted = a.IsDeleted
	,deletedate = GETDATE()
	--SELECT a.IsDeleted
	--SELECT COUNT(*) 
	FROM KingsCI_Reporting.ProdCopy.Account a 
	INNER JOIN dbo.DimCustomer b ON a.id = b.SSID AND b.SourceSystem = 'Kings PC_SFDC Account'
	WHERE a.IsDeleted <> b.IsDeleted

	UPDATE b
	SET b.IsDeleted = a.IsDeleted
	,deletedate = GETDATE()
	--SELECT a.IsDeleted
	--SELECT COUNT(*) 
	FROM KingsCI_Reporting.ProdCopy.Contact a 
	INNER JOIN dbo.DimCustomer b ON a.id = b.SSID AND b.SourceSystem = 'Kings PC_SFDC Contact'
	WHERE a.IsDeleted <> b.IsDeleted



--post Masterload
--Placed in Masterload sproc
INSERT INTO KingsCI_Integration.dbo.RecordTypeFlipping
SELECT GETDATE() AS [timestamp]
, flip.id
, dc.FullName AS [Name] 
, dc.CompanyName AS companyname
, NULL AS RecordTYpe
, 'Post_Masterload' AS Step
, dc.AddressPrimaryStreet AS AddressPrimaryStreet
, dc.AddressPrimaryIsCleanStatus AS AddressClean
, NULL AS copyloaddate
, dc.SSUpdatedBy
, dc.SSUpdatedDate
, dc.SSB_CRMSYSTEM_ACCT_ID AS ssbcrmsystemacctid
, dc.SSB_CRMSYSTEM_ACCT_PRIMARY_FLAG AS acctprimaryflag
FROM KingsCI_Integration.dbo.vw_RecordTypeFlipping flip WITH (NOLOCK)
INNER JOIN kings.dbo.vwDimCustomer_ModAcctId dc WITH (NOLOCK)
ON flip.id = dc.SSID  AND dc.SourceSystem = 'Kings PC_SFDC Account'

END









GO
