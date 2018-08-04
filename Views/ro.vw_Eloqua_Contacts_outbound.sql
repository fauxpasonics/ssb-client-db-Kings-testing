SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






CREATE	VIEW [ro].[vw_Eloqua_Contacts_outbound]
AS

SELECT 
		d.dimcustomerID
	   ,d.emailprimary
	   ,ds.SSB_CRMSYSTEM_CONTACT_ID
	   ,ds.SSB_CRMSYSTEM_ACCT_ID
	   ,d.accountID AS ArchticsID
	   ,d.FirstName
	   ,d.MiddleName
	   ,d.LastName
	   ,d.AddressPrimaryStreet AS Address1
	   ,CONCAT(d.Addressprimarycity, + d.addressprimarystate, + d.addressprimaryzip) AS Address2
	   , NULL AS address3
	   , NULL AS address4 
	   ,d.Addressprimarycity
	   ,d.addressprimarystate
	   ,d.addressprimaryzip
	   ,d.addressprimarycountry
	   ,d.birthday
       ,d.PhonePrimary
	   ,d.PhoneHome
	   ,d.PhoneCell
	   ,d.PhoneBusiness
	   ,d.PhoneFax
	   ,d.prefix AS Title
	   , a.ownerID
	   , u2.Email
	   , u2.[Name] --(may want to limit to active users)
	   , u.AccountID
	   , u.ContactID
       ,d.CreatedDate
	   ,d.UpdatedDate
	   ,ec.id AS [Eloqua Contact ID]
	   ,SUBSTRING (CAST(d.Birthday AS NVARCHAR(10)),6,2) AS [Birth Month]
	   , LEFT(CAST(d.Birthday AS NVARCHAR(10)), 4) AS [Birth Year]
	  --  ,      as [Rep - Group Sales] --u.name will the be owner and look for max date after joining to ssbid
       , a.share_partner__C  AS [Share Partner Flag] 
      --   ,     as [Share Partner Account ID] 
      --   ,     as [STM Flag] 
         , CASE WHEN a.group_category__C = 'broker' THEN 1 ELSE 0 END   AS [Broker Flag] 
      --   ,     as [Group Leader Flag] 
         , a.New_Fulls_Lead_Score__C  AS [SFDC Lead Score] 
      --   ,     as [Lead Score Date] (Need Kings to create new field in Salesforce)
         , ds.sourcesystem AS [Source] 
      --   ,     as [Last Engagement Date] 
      --   ,     as [Last Engagement Type] 
	    ,d.AccountType     as [Account Type Description] 
 
 

FROM dbo.vwDimCustomer_ModAcctId d
 JOIN dbo.dimcustomerssbid ds
	ON ds.dimcustomerID = d.dimcustomerID
 JOIN prodcopy.Account a
	ON a.[SSB_CRMSYSTEM_DimCustomerIDs__c] = d.dimcustomerID
 JOIN prodcopy.[user] u
	ON u.accountID = a.id
 JOIN ods.Eloqua_contact ec
	ON ec.C_Archtics_Account_ID1 = d.ssid
 JOIN prodcopy.[user] u2
	ON a.ownerID = u2.ID
 JOIN (SELECT ssb_crmsystem_contact_ID, MIN(createddate) cd FROM [dbo].[DimCustomerSSBID]
		GROUP BY ssb_crmsystem_contact_ID) x ON ds.SSB_CRMSYSTEM_CONTACT_ID = x.SSB_CRMSYSTEM_CONTACT_ID
		AND ds.CreatedDate = x.cd






GO
