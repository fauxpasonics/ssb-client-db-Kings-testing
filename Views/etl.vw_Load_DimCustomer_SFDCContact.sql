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

CREATE VIEW [etl].[vw_Load_DimCustomer_SFDCContact] AS 

(

	SELECT *
	/*Name*/
	, HASHBYTES('sha2_256',
							ISNULL(RTRIM(FullName),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(Prefix),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(FirstName),'DBNULL_TEXT')
							+ ISNULL(RTRIM(MiddleName),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(LastName),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(Suffix),'DBNULL_TEXT')
							+ ISNULL(RTRIM(CompanyName),'DBNULL_TEXT')
							) AS [NameDirtyHash]
	, 'Dirty' AS [NameIsCleanStatus]
	, NULL AS [NameMasterId]

	/*Address*/
	/*Address*/
	, HASHBYTES('sha2_256', ISNULL(RTRIM(AddressPrimaryStreet),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(AddressPrimarySuite),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressPrimaryCity),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressPrimaryState),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(AddressPrimaryZip),'DBNULL_TEXT') 
							---+ ISNULL(RTRIM(AddressPrimaryCounty),'DBNULL_TEXT')
							---+ ISNULL(RTRIM(AddressPrimaryCountry),'DBNULL_TEXT')
							) AS [AddressPrimaryDirtyHash]
	, 'Dirty' AS [AddressPrimaryIsCleanStatus]
	, NULL AS [AddressPrimaryMasterId]
	, HASHBYTES('sha2_256', ISNULL(RTRIM(AddressOneStreet),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(AddressOneSuite),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressOneCity),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressOneState),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(AddressOneZip),'DBNULL_TEXT') 
							---+ ISNULL(RTRIM(AddressOneCounty),'DBNULL_TEXT')
							---+ ISNULL(RTRIM(AddressOneCountry),'DBNULL_TEXT')
							) AS [AddressOneDirtyHash]
	, 'Dirty' AS [AddressOneIsCleanStatus]
	, NULL AS [AddressOneMasterId]
	, HASHBYTES('sha2_256', ISNULL(RTRIM(AddressTwoStreet),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(AddressTwoSuite),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressTwoCity),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressTwoState),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(AddressTwoZip),'DBNULL_TEXT')
							---+ ISNULL(RTRIM(AddressTwoCounty),'DBNULL_TEXT') 
							---+ ISNULL(RTRIM(AddressTwoCountry),'DBNULL_TEXT')
							) AS [AddressTwoDirtyHash]
	, 'Dirty' AS [AddressTwoIsCleanStatus]
	, NULL AS [AddressTwoMasterId]
	, HASHBYTES('sha2_256', ISNULL(RTRIM(AddressThreeStreet),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(AddressThreeSuite),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressThreeCity),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressThreeState),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(AddressThreeZip),'DBNULL_TEXT') 
							---+ ISNULL(RTRIM(AddressThreeCounty),'DBNULL_TEXT')
							---+ ISNULL(RTRIM(AddressThreeCountry),'DBNULL_TEXT')
							) AS [AddressThreeDirtyHash]
	, 'Dirty' AS [AddressThreeIsCleanStatus]
	, NULL AS [AddressThreeMasterId]
	, HASHBYTES('sha2_256', ISNULL(RTRIM(AddressFourStreet),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(AddressFourSuite),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressFourCity),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressFourState),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(AddressFourZip),'DBNULL_TEXT')
							---+ ISNULL(RTRIM(AddressFourCounty),'DBNULL_TEXT') 
							---+ ISNULL(RTRIM(AddressFourCountry),'DBNULL_TEXT')
							) AS [AddressFourDirtyHash]
	, 'Dirty' AS [AddressFourIsCleanStatus]
	, NULL AS [AddressFourMasterId]

	/*Contact*/
	, HASHBYTES('sha2_256', ISNULL(RTRIM(Prefix),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(FirstName),'DBNULL_TEXT')
							+ ISNULL(RTRIM(MiddleName),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(LastName),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(Suffix),'DBNULL_TEXT')+ ISNULL(RTRIM(AddressPrimaryStreet),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressPrimarySuite),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressPrimaryCity),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressPrimaryState),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(AddressPrimaryZip),'DBNULL_TEXT') 
							--+ ISNULL(RTRIM(AddressPrimaryCounty),'DBNULL_TEXT')
							--+ ISNULL(RTRIM(AddressPrimaryCountry),'DBNULL_TEXT')
							) AS [ContactDirtyHash]

	/*Phone*/
	, HASHBYTES('sha2_256',	ISNULL(RTRIM(PhonePrimary),'DBNULL_TEXT')) AS [PhonePrimaryDirtyHash]
	, 'Dirty' AS [PhonePrimaryIsCleanStatus]
	, NULL AS [PhonePrimaryMasterId]
	, HASHBYTES('sha2_256',	ISNULL(RTRIM(PhoneHome),'DBNULL_TEXT')) AS [PhoneHomeDirtyHash]
	, 'Dirty' AS [PhoneHomeIsCleanStatus]
	, NULL AS [PhoneHomeMasterId]
	, HASHBYTES('sha2_256',	ISNULL(RTRIM(PhoneCell),'DBNULL_TEXT')) AS [PhoneCellDirtyHash]
	, 'Dirty' AS [PhoneCellIsCleanStatus]
	, NULL AS [PhoneCellMasterId]
	, HASHBYTES('sha2_256',	ISNULL(RTRIM(PhoneBusiness),'DBNULL_TEXT')) AS [PhoneBusinessDirtyHash]
	, 'Dirty' AS [PhoneBusinessIsCleanStatus]
	, NULL AS [PhoneBusinessMasterId]
	, HASHBYTES('sha2_256',	ISNULL(RTRIM(PhoneFax),'DBNULL_TEXT')) AS [PhoneFaxDirtyHash]
	, 'Dirty' AS [PhoneFaxIsCleanStatus]
	, NULL AS [PhoneFaxMasterId]
	, HASHBYTES('sha2_256',	ISNULL(RTRIM(PhoneOther),'DBNULL_TEXT')) AS [PhoneOtherDirtyHash]
	, 'Dirty' AS [PhoneOtherIsCleanStatus]
	, NULL AS [PhoneOtherMasterId]

	/*Email*/
	, HASHBYTES('sha2_256',	ISNULL(RTRIM(EmailPrimary),'DBNULL_TEXT')) AS [EmailPrimaryDirtyHash]
	, 'Dirty' AS [EmailPrimaryIsCleanStatus]
	, NULL AS [EmailPrimaryMasterId]
	, HASHBYTES('sha2_256',	ISNULL(RTRIM(EmailOne),'DBNULL_TEXT')) AS [EmailOneDirtyHash]
	, 'Dirty' AS [EmailOneIsCleanStatus]
	, NULL AS [EmailOneMasterId]
	, HASHBYTES('sha2_256',	ISNULL(RTRIM(EmailTwo),'DBNULL_TEXT')) AS [EmailTwoDirtyHash]
	, 'Dirty' AS [EmailTwoIsCleanStatus]
	, NULL AS [EmailTwoMasterId]

	
	/*Attributes*/
, HASHBYTES('sha2_256', ISNULL(RTRIM(customerType),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(CustomerStatus),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AccountType),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(AccountRep),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(CompanyName),'DBNULL_TEXT')
							+ ISNULL(RTRIM(SalutationName),'DBNULL_TEXT')
							+ ISNULL(RTRIM(DonorMailName),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(DonorFormalName),'DBNULL_TEXT')
							+ ISNULL(RTRIM(Birthday),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(Gender),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(AccountId),'DBNULL_TEXT')
							+ ISNULL(RTRIM(MergedRecordFlag),'DBNULL_TEXT')
							+ ISNULL(RTRIM(MergedIntoSSID),'DBNULL_TEXT')
							+ ISNULL(RTRIM(IsBusiness),'DBNULL_TEXT')) AS [contactattrDirtyHash]

, HASHBYTES('sha2_256', ISNULL(RTRIM(ExtAttribute1),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(ExtAttribute2),'DBNULL_TEXT')
							+ ISNULL(RTRIM(ExtAttribute3),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(ExtAttribute4),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(ExtAttribute5),'DBNULL_TEXT')
							+ ISNULL(RTRIM(ExtAttribute6),'DBNULL_TEXT')
							+ ISNULL(RTRIM(ExtAttribute7),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(ExtAttribute8),'DBNULL_TEXT')
							+ ISNULL(RTRIM(ExtAttribute9),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(ExtAttribute10),'DBNULL_TEXT') 
							) AS [extattr1_10DirtyHash]

							, HASHBYTES('sha2_256', ISNULL(RTRIM(ExtAttribute11),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(ExtAttribute12),'DBNULL_TEXT')
							+ ISNULL(RTRIM(ExtAttribute13),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(ExtAttribute14),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(ExtAttribute15),'DBNULL_TEXT')
							+ ISNULL(RTRIM(ExtAttribute16),'DBNULL_TEXT')
							+ ISNULL(RTRIM(ExtAttribute17),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(ExtAttribute18),'DBNULL_TEXT')
							+ ISNULL(RTRIM(ExtAttribute19),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(ExtAttribute20),'DBNULL_TEXT') 
							) AS [extattr11_20DirtyHash]

							
, HASHBYTES('sha2_256', ISNULL(RTRIM(ExtAttribute21),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(ExtAttribute22),'DBNULL_TEXT')
							+ ISNULL(RTRIM(ExtAttribute23),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(ExtAttribute24),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(ExtAttribute25),'DBNULL_TEXT')
							+ ISNULL(RTRIM(ExtAttribute26),'DBNULL_TEXT')
							+ ISNULL(RTRIM(ExtAttribute27),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(ExtAttribute28),'DBNULL_TEXT')
							+ ISNULL(RTRIM(ExtAttribute29),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(ExtAttribute30),'DBNULL_TEXT') 
							) AS [extattr21_30DirtyHash]

							
, HASHBYTES('sha2_256', ISNULL(RTRIM(ExtAttribute31),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(ExtAttribute32),'DBNULL_TEXT')
							+ ISNULL(RTRIM(ExtAttribute33),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(ExtAttribute34),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(ExtAttribute35),'DBNULL_TEXT')
							) AS [extattr31_35DirtyHash]




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
			, CASE WHEN rt.Name LIKE '%business%' THEN x.name  END AS [CompanyName] 
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

			--Removed due to bad join
			--, CASE	WHEN act.Isbusiness = 1 THEN act.[AddressPrimaryStreet]
			--		WHEN ISNULL(MailingStreet,'') = '' THEN act.[AddressPrimaryStreet] ELSE ISNULL(MailingStreet, act.[AddressPrimaryStreet]) END AS [AddressPrimaryStreet]
			--, CASE  WHEN act.Isbusiness = 1 THEN act.[AddressPrimaryCity]
			--		WHEN ISNULL(MailingStreet,'') = '' THEN act.[AddressPrimaryCity] ELSE ISNULL(MailingCity, act.[AddressPrimaryCity]) END AS [AddressPrimaryCity] 
			--, CASE	WHEN act.Isbusiness = 1 THEN act.[AddressPrimaryState]
			--		WHEN ISNULL(MailingStreet,'') = '' THEN act.[AddressPrimaryState] ELSE ISNULL(MailingState, act.[AddressPrimaryState])	END AS [AddressPrimaryState] 
			--, CASE  WHEN act.Isbusiness = 1 THEN act.[AddressPrimaryZip]
			--		WHEN ISNULL(MailingStreet,'') = '' THEN act.[AddressPrimaryZip] ELSE ISNULL(MailingPostalCode, act.[AddressPrimaryZip]) END	AS [AddressPrimaryZip] 
			--, NULL AS [AddressPrimaryCounty]
			--, CASE	WHEN act.Isbusiness = 1 THEN act.[AddressPrimaryCountry]
			--		WHEN ISNULL(MailingStreet,'') = '' THEN act.[AddressPrimaryCountry] ELSE ISNULL([MailingCountry], act.[AddressPrimaryCountry]) END AS [AddressPrimaryCountry] 

	

			,CASE WHEN rt.name LIKE '%business%' AND  ISNULL(x.[BillingStreet],'') = ''  AND  ISNULL(p.MailingStreet,'') != '' THEN p.MailingStreet
				  WHEN rt.name LIKE '%business%' AND  ISNULL(x.[BillingStreet],'') != '' THEN x.BillingStreet
				  ELSE ISNULL(p.MailingStreet, x.BillingStreet) END AS [AddressPrimaryStreet]
			,CASE WHEN rt.name LIKE '%business%' AND  ISNULL(x.[BillingCity],'') = ''  AND  ISNULL(p.MailingCity,'') != '' THEN p.MailingCity
				  WHEN rt.name LIKE '%business%' AND  ISNULL(x.[BillingCity],'') != '' THEN x.BillingCity
				  ELSE ISNULL(p.MailingCity, x.BillingCity) END AS [AddressPrimaryCity]
			,CASE WHEN rt.name LIKE '%business%' AND  ISNULL(x.[BillingState],'') = ''  AND  ISNULL(p.MailingState,'') != '' THEN p.MailingState
				  WHEN rt.name LIKE '%business%' AND  ISNULL(x.[BillingState],'') != '' THEN x.BillingState
				  ELSE ISNULL(p.MailingState, x.BillingState) END AS [AddressPrimaryState]
			,CASE WHEN rt.name LIKE '%business%' AND  ISNULL(x.[BillingPostalCode],'') = ''  AND  ISNULL(p.MailingPostalCode,'') != '' THEN p.MailingPostalCode
				  WHEN rt.name LIKE '%business%' AND  ISNULL(x.[BillingPostalCode],'') != '' THEN x.BillingPostalCode
				  ELSE ISNULL(p.MailingPostalCode, x.BillingPostalCode) END AS [AddressPrimaryZip]
			,CASE WHEN rt.name LIKE '%business%' AND  ISNULL(x.[BillingCountry],'') = ''  AND  ISNULL(p.MailingCountry,'') != '' THEN p.MailingCountry
				  WHEN rt.name LIKE '%business%' AND  ISNULL(x.[BillingCountry],'') != '' THEN x.BillingCountry
				  ELSE ISNULL(p.MailingCountry, x.BillingCountry) END AS [AddressPrimaryCountry]
			,NULL AS AddressPrimaryCounty
			
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
			, NULL AS [PhoneHome]
			, CAST(p.MobilePhone AS NVARCHAR(25)) AS [PhoneCell]
			, CAST(NULL AS NVARCHAR(25)) AS [PhoneBusiness]
			, CAST(p.Fax AS NVARCHAR(25)) AS [PhoneFax]
			, NULL AS [PhoneOther]

			/*Email*/
			--Removed due to bad join
			--, CASE	WHEN act.Isbusiness = 1 THEN p.Email ELSE ISNULL(p.Email,Act.EmailPrimary) END  AS [EmailPrimary]
			, p.Email AS [EmailPrimary]
			, NULL AS [EmailOne]
			, NULL AS [EmailTwo]

			/*Extended Attributes*/
			, NULL AS[ExtAttribute1] --nvarchar(100)
			, NULL AS[ExtAttribute2] 
			, NULL AS[ExtAttribute3] 
			, p.AccountID AS[ExtAttribute4] 
			--Removed due to bad join
			--, LEFT(act.Archtics_ID__C, 100)AS [ExtAttribute5] 
			, LEFT(x.Archtics_ID__C, 100)AS [ExtAttribute5] 
			, CAST(p.Archtics_ID__C AS VARCHAR(100)) AS[ExtAttribute6] 
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

			, NULL AddressPrimarySuite
			, NULL AddressOneSuite
			, NULL AddressThreeSuite
			, NULL AddressTwoSuite
			, Null AddressFourSuite

			/*Source Created and Updated*/
			, [p].[CreatedById] [SSCreatedBy]
			, [p].[LastModifiedById] [SSUpdatedBy]
			, [p].[CreatedDate] AS SSCreatedDate
			, [p].[LastModifiedDate][SSUpdatedDate]
			, GETDATE() AS createdDate
			, p.isdeleted AS IsDeleted
			, NULL AS DeleteDate

			, NULL [AccountId]
			--Removed due to bad join
			--, act.IsBusiness --CASE WHEN z.id IS NOT NULL THEN 1 ELSE 0 END AS IsBusiness
			, CASE 	WHEN rt.Name LIKE '%business%' THEN 1 ELSE 0 END AS IsBusiness
			--Removed due to bad join 
			--, CASE WHEN act.IsBusiness = 0 THEN act.customer_matchkey
			--	 WHEN p.Archtics_ID__c IS NOT NULL THEN p.Id
			 --END AS customer_matchkey
			, CASE WHEN  rt.Name NOT LIKE '%business%' THEN x.ID
				 WHEN p.Archtics_ID__c IS NOT NULL THEN p.Id
			 END AS customer_matchkey

--		select top 100 *
		FROM  KingsCI_Reporting.ProdCopy.Contact p	--order by SSB_CRMSYSTEM_Contact_ID__c desc	
		LEFT JOIN KingsCI_Reporting.prodcopy.account x
			ON p.accountID = x.ID AND x.isdeleted = 0
		--JOIN etl.vw_SFDCAccount_Load_DimCustomer act
		--	ON p.AccountId = act.SSID
			LEFT JOIN KingsCI_Reporting.prodcopy.RecordType rt ON x.RecordTypeId = rt.id
		WHERE p.isdeleted = 0
		AND (p.CreatedDate > DATEADD(DAY,-3,GETDATE()) OR p.LastModifiedDate > DATEADD(DAY,-3,GETDATE()))

	) a

)




GO
