SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


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

CREATE VIEW [etl].[vw_SFDCAccount_Load_DimCustomer_ConversionOnly] AS (

	SELECT *
	/*Name*/
	, HASHBYTES('sha2_256',
							ISNULL(RTRIM(Prefix),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(FirstName),'DBNULL_TEXT')
							+ ISNULL(RTRIM(MiddleName),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(LastName),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(FullName),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(Suffix),'DBNULL_TEXT')) AS [NameDirtyHash]
	, NULL AS [NameIsCleanStatus]
	, NULL AS [NameMasterId]

	/*Address*/
	, HASHBYTES('sha2_256', ISNULL(RTRIM(AddressPrimaryStreet),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(AddressPrimaryCity),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressPrimaryState),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(AddressPrimaryZip),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(AddressPrimaryCounty),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressPrimaryCountry),'DBNULL_TEXT')) AS [AddressPrimaryDirtyHash]
	, NULL AS [AddressPrimaryIsCleanStatus]
	, NULL AS [AddressPrimaryMasterId]
	, HASHBYTES('sha2_256', ISNULL(RTRIM(AddressOneStreet),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(AddressOneCity),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressOneState),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(AddressOneZip),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(AddressOneCounty),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressOneCountry),'DBNULL_TEXT')) AS [AddressOneDirtyHash]
	, NULL AS [AddressOneIsCleanStatus]
	, NULL AS [AddressOneMasterId]
	, HASHBYTES('sha2_256', ISNULL(RTRIM(AddressTwoStreet),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(AddressTwoCity),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressTwoState),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(AddressTwoZip),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressTwoCounty),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(AddressTwoCountry),'DBNULL_TEXT')) AS [AddressTwoDirtyHash]
	, NULL AS [AddressTwoIsCleanStatus]
	, NULL AS [AddressTwoMasterId]
	, HASHBYTES('sha2_256', ISNULL(RTRIM(AddressThreeStreet),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(AddressThreeCity),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressThreeState),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(AddressThreeZip),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(AddressThreeCounty),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressThreeCountry),'DBNULL_TEXT')) AS [AddressThreeDirtyHash]
	, NULL AS [AddressThreeIsCleanStatus]
	, NULL AS [AddressThreeMasterId]
	, HASHBYTES('sha2_256', ISNULL(RTRIM(AddressFourStreet),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(AddressFourCity),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressFourState),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(AddressFourZip),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressFourCounty),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(AddressFourCountry),'DBNULL_TEXT')) AS [AddressFourDirtyHash]
	, NULL AS [AddressFourIsCleanStatus]
	, NULL AS [AddressFourMasterId]

	/*Contact*/
	, HASHBYTES('sha2_256', ISNULL(RTRIM(Prefix),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(FirstName),'DBNULL_TEXT')
							+ ISNULL(RTRIM(MiddleName),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(LastName),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(FullName),'DBNULL_TEXT')
							+ ISNULL(RTRIM(Suffix),'DBNULL_TEXT')+ ISNULL(RTRIM(AddressPrimaryStreet),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(AddressPrimaryCity),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressPrimaryState),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(AddressPrimaryZip),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(AddressPrimaryCounty),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressPrimaryCountry),'DBNULL_TEXT')) AS [ContactDirtyHash]
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
	, HASHBYTES('sha2_256',	ISNULL(RTRIM(PhoneBusiness),'DBNULL_TEXT')) AS [PhoneBusinessDirtyHash]
	, NULL AS [PhoneBusinessIsCleanStatus]
	, NULL AS [PhoneBusinessMasterId]
	, HASHBYTES('sha2_256',	ISNULL(RTRIM(PhoneFax),'DBNULL_TEXT')) AS [PhoneFaxDirtyHash]
	, NULL AS [PhoneFaxIsCleanStatus]
	, NULL AS [PhoneFaxMasterId]
	, HASHBYTES('sha2_256',	ISNULL(RTRIM(PhoneFax),'DBNULL_TEXT')) AS [PhoneOtherDirtyHash]
	, NULL AS [PhoneOtherIsCleanStatus]
	, NULL AS [PhoneOtherMasterId]

	/*Email*/
	, HASHBYTES('sha2_256',	ISNULL(RTRIM(EmailPrimary),'DBNULL_TEXT')) AS [EmailPrimaryDirtyHash]
	, NULL AS [EmailPrimaryIsCleanStatus]
	, NULL AS [EmailPrimaryMasterId]
	, HASHBYTES('sha2_256',	ISNULL(RTRIM(EmailOne),'DBNULL_TEXT')) AS [EmailOneDirtyHash]
	, NULL AS [EmailOneIsCleanStatus]
	, NULL AS [EmailOneMasterId]
	, HASHBYTES('sha2_256',	ISNULL(RTRIM(EmailTwo),'DBNULL_TEXT')) AS [EmailTwoDirtyHash]
	, NULL AS [EmailTwoIsCleanStatus]
	, NULL AS [EmailTwoMasterId]
FROM (
--base set

		SELECT 

		'Kings SFDC' AS [SourceDB]
		, 'Kings PC_SFDC Account' AS [SourceSystem]
		, 1 AS [SourceSystemPriority]
		, CAST(a.[ID] AS NVARCHAR(50)) AS [SSID]

		/*Standard Attributes*/
		, NULL AS [CustomerType]
		, NULL AS [CustomerStatus]
	    , CAST(NULL AS NVARCHAR(50)) AS [AccountType] 
		, CAST(NULL AS NVARCHAR(50)) AS [AccountRep] 
		, CASE WHEN a.IspersonAccount = 0 then a.name  END AS [CompanyName] 
		, NULL AS [SalutationName]
		, NULL AS [DonorMailName]
		, NULL AS [DonorFormalName]
		, TRY_CAST(NULL AS DATE) AS [Birthday]
		, NULL AS [Gender] 
		, 0 [MergedRecordFlag]
		, NULL [MergedIntoSSID]

		/**ENTITIES**/
			/*Name*/

		, CASE WHEN a.IspersonAccount = 1 THEN a.Salutation ELSE b.Salutation END AS [Prefix]
		, CASE WHEN a.IspersonAccount = 1 THEN a.FirstName ELSE b.FirstName END AS [FirstName]
		, NULL AS [MiddleName]
		, CASE WHEN a.IspersonAccount = 1 THEN a.LastName ELSE b.LastName END AS [LastName]
		, CASE WHEN a.IspersonAccount = 1 THEN a.[Name] ELSE b.Name END AS [FullName]
		--,[Name] [FullName]
		, NULL AS [Suffix]
		--, c.name_title as [Title]

		/*AddressPrimary*/
            , CASE WHEN ISNULL(a.[BillingStreet],'') = '' THEN b.MailingStreet ELSE a.[BillingStreet] END AS [AddressPrimaryStreet]
			, CASE WHEN ISNULL(a.[BillingStreet],'') = '' THEN b.MailingCity ELSE a.[BillingCity] END AS [AddressPrimaryCity] 
			, CASE WHEN ISNULL(a.[BillingStreet],'') = '' THEN b.MailingState ELSE a.[BillingState]	END AS [AddressPrimaryState] 
			, CASE WHEN ISNULL(a.[BillingStreet],'') = '' THEN b.MailingPostalCode ELSE a.[BillingPostalCode] END AS [AddressPrimaryZip] 
			, NULL AS [AddressPrimaryCounty]
			, CASE WHEN ISNULL(a.[BillingStreet],'') = '' THEN b.MailingCountry ELSE a.[BillingCountry]	END AS [AddressPrimaryCountry] 
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
			, LEFT(a.[Phone],25) AS [PhonePrimary]
			, NULL AS [PhoneHome]
			, NULL AS [PhoneCell]
			, LEFT(a.[Phone],25) AS [PhoneBusiness]
			, LEFT(a.[Fax],25) AS [PhoneFax]
			, NULL AS [PhoneOther]

			/*Email*/
			, ISNULL([a].[PersonEmail],b.Email) AS [EmailPrimary]
			, NULL AS [EmailOne]
			, NULL AS [EmailTwo]

				/*Extended Attributes*/
			, NULL AS [ExtAttribute1] --nvarchar(100)
			, NULL AS [ExtAttribute2] 
			, NULL AS [ExtAttribute3] 
			, a.ID AS [ExtAttribute4] 
			, LEFT(a.Archtics_ID__C, 100) AS [ExtAttribute5] 
			, NULL AS [ExtAttribute6] 
			, NULL AS [ExtAttribute7] 
			, NULL AS [ExtAttribute8] 
			, NULL AS [ExtAttribute9] 
			, NULL AS [ExtAttribute10] 

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
			, NULL AS [ExtAttribute23] 
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
	   	    , [a].[CreatedById] [SSCreatedBy]
			, [a].[LastModifiedById] [SSUpdatedBy]
			, [a].[CreatedDate] AS SSCreatedDate
			, [a].[LastModifiedDate][SSUpdatedDate]

			, GETDATE() CreatedDate
			, GETDATE() UpdatedDate
			, 0 IsDeleted
			, NULL DeleteDate

			, CAST(NULL AS INT) [AccountId]
			, CASE WHEN a.IspersonAccount = 0 THEN 1 ELSE 0 END AS IsBusiness
			, CASE WHEN a.isPersonAccount = 1 
						AND( (ISNULL(a.BillingStreet,'') = '' 
						OR ISNULL(a.[PersonEmail],'') = '' 
						OR a.BillingCountryCode <> 'US'
						OR ISNULL(Replace(a.Phone,'.',''),'') = '')
						OR ISNUMERIC(a.Archtics_ID__C) = 1	)					
						THEN CASE WHEN ISNUMERIC(a.Archtics_ID__C) = 1 THEN ISNULL(a.Archtics_ID__C, a.ID) 
					WHEN a.isPersonAccount = 0 AND ISNUMERIC(a.Archtics_ID__C) = 1 THEN a.Archtics_ID__C ELSE a.ID END
				END AS customer_matchkey
			FROM KingsCI_Reporting.prodcopy_conv.account a
			LEFT JOIN KingsCI_Reporting.ProdCopy_conv.Contact b
				ON a.Primary_Contact__c = b.ID
			) a
)










GO
