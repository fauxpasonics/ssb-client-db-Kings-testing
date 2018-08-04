SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



---select * from [etl].[vw_SFDCNew_LoadDimCustomer_Raiders] 

/*****Hash Rules for Reference******
WHEN 'int' THEN 'ISNULL(RTRIM(CONVERT(varchar(10),' + COLUMN_NAME + ')),''DBNULL_INT'')'
WHEN 'bigint' THEN 'ISNULL(RTRIM(CONVERT(varchar(10),' + COLUMN_NAME + ')),''DBNULL_BIGINT'')'
WHEN 'datetime' THEN 'ISNULL(RTRIM(CONVERT(varchar(25),' + COLUMN_NAME + ')),''DBNULL_DATETIME'')'  
WHEN 'datetime2' THEN 'ISNULL(RTRIM(CONVERT(varchar(25),' + COLUMN_NAME + ')),''DBNULL_DATETIME'')'
WHEN 'date' THEN 'ISNULL(RTRIM(CONVERT(varchar(10),' + COLUMN_NAME + ',112)),''DBNULL_DATE'')' 
WHEN 'bit' THEN 'ISNULL(RTRIM(CONVERT(varchar(10),' + COLUMN_NAME + ')),''DBNULL_BIT'')'  
WHEN 'decimal' THEN 'ISNULL(RTRIM(CONVERT(varchar(25),'+ COLUMN_NAME + ')),''DBNULL_NUMBER'')' 
WHEN 'numeric' THEN 'ISNULL(RTRIM(CONVERT(varchar(25),'+ COLUMN_NAME + ')),''DBNULL_NUMBER'')' 
ELSE 'ISNULL(RTRIM(' + COLUMN_NAME + '),''DBNULL_TEXT'')'
*****/
--drop view ods.vw_TM_LoadDimCustomer
CREATE VIEW [etl].[vw_SFDCContact_Load_DimCustomer_ConversionOnly] AS (

	SELECT *
	/*Name*/
	, HASHBYTES('sha2_256',
							ISNULL(RTRIM([FullName]),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(Prefix),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(FirstName),'DBNULL_TEXT')
							+ ISNULL(RTRIM(MiddleName),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(LastName),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(Suffix),'DBNULL_TEXT')
							+ ISNULL(RTRIM(CompanyName),'DBNULL_TEXT')
							) AS [NameDirtyHash]
	, NULL AS [NameIsCleanStatus]
	, NULL AS [NameMasterId]

	/*Address*/
	, HASHBYTES('sha2_256', ISNULL(RTRIM(AddressPrimaryStreet),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(AddressPrimaryCity),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressPrimaryState),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(AddressPrimaryZip),'DBNULL_TEXT') ) AS [AddressPrimaryDirtyHash]
	, NULL AS [AddressPrimaryIsCleanStatus]
	, NULL AS [AddressPrimaryMasterId]
	, HASHBYTES('sha2_256', ISNULL(RTRIM(AddressOneStreet),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(AddressOneCity),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressOneState),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(AddressOneZip),'DBNULL_TEXT') ) AS [AddressOneDirtyHash]
							
	, NULL AS [AddressOneIsCleanStatus]
	, NULL AS [AddressOneMasterId]
	, NULL AS [AddressTwoDirtyHash]
	, NULL AS [AddressTwoIsCleanStatus]
	, NULL AS [AddressTwoMasterId]
	, NULL AS [AddressThreeDirtyHash]
	, NULL AS [AddressThreeIsCleanStatus]
	, NULL AS [AddressThreeMasterId]
	, NULL AS [AddressFourDirtyHash]
	, NULL AS [AddressFourIsCleanStatus]
	, NULL AS [AddressFourMasterId]

	/*Contact*/
	, HASHBYTES('sha2_256', ISNULL(RTRIM([FullName]),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(Prefix),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(FirstName),'DBNULL_TEXT')
							+ ISNULL(RTRIM(MiddleName),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(LastName),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(Suffix),'DBNULL_TEXT')
							+ ISNULL(RTRIM(CompanyName),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressPrimaryStreet),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(AddressPrimaryCity),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressPrimaryState),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(AddressPrimaryZip),'DBNULL_TEXT') ) AS [ContactDirtyHash]
	, NULL AS [ContactGuid]

	/*Phone*/
	, HASHBYTES('sha2_256',	ISNULL(RTRIM(PhonePrimary),'DBNULL_TEXT')) AS [PhonePrimaryDirtyHash]
	, NULL AS [PhonePrimaryIsCleanStatus]
	, NULL AS [PhonePrimaryMasterId]
	, HASHBYTES('sha2_256',	ISNULL(RTRIM(PhoneHome),'DBNULL_TEXT')) AS [PhoneHomeDirtyHash]
	, NULL AS [PhoneHomeIsCleanStatus]
	, NULL AS [PhoneHomeMasterId]
	, HASHBYTES('sha2_256',	ISNULL(RTRIM(PhoneCell),'DBNULL_TEXT')) AS [PhoneCellDirtyHash]
	, NULL AS [PhoneCellIsCleanStatus]
	, NULL AS [PhoneCellMasterId]
	, NULL AS [PhoneBusinessDirtyHash]
	, NULL AS [PhoneBusinessIsCleanStatus]
	, NULL AS [PhoneBusinessMasterId]
	, NULL AS [PhoneFaxDirtyHash]
	, NULL AS [PhoneFaxIsCleanStatus]
	, NULL AS [PhoneFaxMasterId]
	, HASHBYTES('sha2_256',	ISNULL(RTRIM(PhoneOther),'DBNULL_TEXT')) AS [PhoneOtherDirtyHash]
	, NULL AS [PhoneOtherIsCleanStatus]
	, NULL AS [PhoneOtherMasterId]

	/*Email*/
	, HASHBYTES('sha2_256',	ISNULL(RTRIM(EmailPrimary),'DBNULL_TEXT')) AS [EmailPrimaryDirtyHash]
	, NULL AS [EmailPrimaryIsCleanStatus]
	, NULL AS [EmailPrimaryMasterId]
	, NULL AS [EmailOneDirtyHash]
	, NULL AS [EmailOneIsCleanStatus]
	, NULL AS [EmailOneMasterId]
	, NULL AS [EmailTwoDirtyHash]
	, NULL AS [EmailTwoIsCleanStatus]
	, NULL AS [EmailTwoMasterId]


	FROM (
--base set
/*
SELECT TOP 100 *
FROM ods.TI_PatronMDM
*/

		SELECT
			'Kings SFDC' SourceDB
			,'Kings PC_SFDC Contact' SourceSystem
			, 0 AS [SourceSystemPriority]

			/*Standard Attributes*/
			, p.Id SSID
			, NULL AS [CustomerType]
			, NULL AS [CustomerStatus]
			, CAST(NULL AS NVARCHAR(50)) AS [AccountType] 
			, CAST(NULL AS NVARCHAR(50)) AS [AccountRep] 
			, act.CompanyName AS CompanyName
			, NULL AS [SalutationName]
			, NULL AS [DonorMailName]
			, NULL AS [DonorFormalName]
			, CAST(NULL AS DATE) AS [Birthday]
			, NULL AS [Gender] 
			, 0 [MergedRecordFlag]
			, NULL [MergedIntoSSID]

			/**ENTITIES**/
			/*Name*/			
			, p.Name AS FullName
			, p.Salutation AS [Prefix]
			, p.firstname AS [FirstName]
		
			, NULL AS [MiddleName]
			, p.LastName AS [LastName]
			
			, NULL AS [Suffix]
			--, c.name_title as [Title]

			/*AddressPrimary*/
			, CASE	WHEN act.Isbusiness = 1 THEN act.[AddressPrimaryStreet]
					WHEN ISNULL(MailingStreet,'') = '' THEN act.[AddressPrimaryStreet] ELSE ISNULL(MailingStreet, act.[AddressPrimaryStreet]) END AS [AddressPrimaryStreet]
			, CASE  WHEN act.Isbusiness = 1 THEN act.[AddressPrimaryCity]
					WHEN ISNULL(MailingStreet,'') = '' THEN act.[AddressPrimaryCity] ELSE ISNULL(MailingCity, act.[AddressPrimaryCity]) END AS [AddressPrimaryCity] 
			, CASE	WHEN act.Isbusiness = 1 THEN act.[AddressPrimaryState]
					WHEN ISNULL(MailingStreet,'') = '' THEN act.[AddressPrimaryState] ELSE ISNULL(MailingState, act.[AddressPrimaryState])	END AS [AddressPrimaryState] 
			, CASE  WHEN act.Isbusiness = 1 THEN act.[AddressPrimaryZip]
					WHEN ISNULL(MailingStreet,'') = '' THEN act.[AddressPrimaryZip] ELSE ISNULL(MailingPostalCode, act.[AddressPrimaryZip]) END	AS [AddressPrimaryZip] 
			, NULL AS [AddressPrimaryCounty]
			, CASE	WHEN act.Isbusiness = 1 THEN act.[AddressPrimaryCountry]
					WHEN ISNULL(MailingStreet,'') = '' THEN act.[AddressPrimaryCountry] ELSE ISNULL([MailingCountry], act.[AddressPrimaryCountry]) END AS [AddressPrimaryCountry] 
			
			, NULL AS [AddressOneStreet]
			, NULL AS [AddressOneCity] 
			, NULL AS [AddressOneState] 
			, NULL AS [AddressOneZip] 
			, NULL AS [AddressOneCounty] 
			, NULL AS [AddressOneCountry] 

			, NULL AS [AddressTwoStreet]
			, NULL AS [AddressTwoCity] 
			, NULL AS [AddressTwoState] 
			, NULL AS [AddressTwoZip] 
			, NULL AS [AddressTwoCounty] 
			, NULL AS [AddressTwoCountry] 

			, NULL AS [AddressThreeStreet]
			, NULL AS [AddressThreeCity] 
			, NULL AS [AddressThreeState] 
			, NULL AS [AddressThreeZip] 
			, NULL AS [AddressThreeCounty] 
			, NULL AS [AddressThreeCountry] 
			
			, NULL AS [AddressFourStreet]
			, NULL AS [AddressFourCity] 
			, NULL AS [AddressFourState] 
			, NULL AS [AddressFourZip] 
			, NULL AS [AddressFourCounty]
			, NULL AS [AddressFourCountry] 

			/*Phone*/
			, CAST([p].[Phone] AS NVARCHAR(25)) AS [PhonePrimary]
			, CAST(p.HomePhone AS NVARCHAR(25)) AS [PhoneHome]
			, CAST(p.MobilePhone AS NVARCHAR(25)) AS [PhoneCell]
			, CAST(NULL AS NVARCHAR(25)) AS [PhoneBusiness]
			, CAST(p.Fax AS NVARCHAR(25)) AS [PhoneFax]
			, CAST(p.OtherPhone AS NVARCHAR(25)) AS [PhoneOther]

			/*Email*/
			, CASE	WHEN act.Isbusiness = 1 THEN p.Email ELSE ISNULL(p.Email,Act.EmailPrimary) END  AS [EmailPrimary]
			, NULL AS [EmailOne]
			, NULL AS [EmailTwo]

			/*Extended Attributes*/
			, NULL AS[ExtAttribute1] --nvarchar(100)
			, NULL AS[ExtAttribute2] 
			, NULL AS[ExtAttribute3] 
			, p.AccountID AS[ExtAttribute4] 
			, act.[ExtAttribute5] AS [ExtAttribute5] 
			, NULL AS[ExtAttribute6] 
			, NULL AS[ExtAttribute7] 
			, NULL AS[ExtAttribute8] 
			, NULL AS[ExtAttribute9] 
			, NULL AS[ExtAttribute10] 

			, NULL AS [ExtAttribute11] 
			, NULL AS [ExtAttribute12] 
			, NULL AS [ExtAttribute13] 
			, NULL AS [ExtAttribute14] 
			, NULL AS [ExtAttribute15] 
			, NULL AS [ExtAttribute16] 
			, NULL AS [ExtAttribute17] 
			, NULL AS [ExtAttribute18] 
			, NULL AS [ExtAttribute19] 
			, NULL AS [ExtAttribute20]  

			, NULL AS [ExtAttribute21] --datetime
			, NULL AS [ExtAttribute22] 
			, NULL AS[ExtAttribute23] 
			, NULL AS [ExtAttribute24] 
			, NULL AS [ExtAttribute25] 
			, NULL AS [ExtAttribute26] 
			, NULL AS [ExtAttribute27] 
			, NULL AS [ExtAttribute28] 
			, NULL AS [ExtAttribute29] 
			, NULL AS [ExtAttribute30]  

			, NULL AS [ExtAttribute31]
			, NULL AS [ExtAttribute32]
			, NULL AS [ExtAttribute33] 
			, NULL AS [ExtAttribute34] 
			, NULL AS [ExtAttribute35] 

			/*Source Created and Updated*/
			, [p].[CreatedById] [SSCreatedBy]
			, [p].[LastModifiedById] [SSUpdatedBy]
			, [p].[CreatedDate] AS SSCreatedDate
			, [p].[LastModifiedDate][SSUpdatedDate]

			, NULL [AccountId]
			, act.IsBusiness --CASE WHEN z.id IS NOT NULL THEN 1 ELSE 0 END AS IsBusiness
			, CASE WHEN act.IsBusiness = 0 then act.customer_matchkey
			 END AS customer_matchkey
		-- Select p.id, p.MailingStreet, z.BillingStreet
		FROM  KingsCI_Reporting.ProdCopy_conv.Contact p	--order by SSB_CRMSYSTEM_Contact_ID__c desc	
		Left join KingsCI_Reporting.prodcopy_conv.account x on p.accountID = x.ID

		JOIN [etl].[vw_SFDCAccount_Load_DimCustomer_conversionOnly] act ON p.AccountId = act.SSID
	

	) a

)




GO
