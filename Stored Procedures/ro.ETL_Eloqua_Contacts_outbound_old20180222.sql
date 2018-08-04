SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





--EXEC emailoutbound.sp_Load_WorkingSet	
--EXEC emailoutbound.sp_Load_Standard
--[ro].[ETL_Eloqua_Contacts_outbound]
--[ro].[ETL_Eloqua_Contacts_Inserts_outbound]


CREATE PROC [ro].[ETL_Eloqua_Contacts_outbound_old20180222]
AS
BEGIN


IF EXISTS (select * from sys.tables where name = 'Eloqua_Contacts_Outbound_Stage' and type = 'U')
	DROP TABLE etl.Eloqua_Contacts_Outbound_Stage;


IF OBJECT_ID('tempdb.Kings.#tmpMaxDate')IS NOT NULL DROP TABLE #tmpMaxDate


--This is selecting the max date of engagement for each guid and its related sources
SELECT *
INTO  #tmpMaxDate
FROM (

SELECT  d.SSB_CRMSYSTEM_CONTACT_ID, MAX(c.createdat) AS MaxDate, d.SourceSystem
FROM dbo.vwDimCustomer_ModAcctId d
JOIN ods.eloqua_contact C
	ON c.id = d.ssid
WHERE d.SourceSystem = 'Eloqua Kings'
AND c.createdAt >= (GETDATE () - 730)
GROUP BY d.ssb_crmsystem_contact_ID, d.sourcesystem


union

SELECT d.ssb_crmsystem_contact_ID, max(a.order_date) AS MaxDate, d.sourcesystem
FROM dbo.vwDimCustomer_ModAcctId d 
JOIN ods.Appetize_orders a
	ON a.email = d.ssid AND d.sourcesystem = 'Appetize'
GROUP BY d.ssb_crmsystem_contact_ID, d.sourcesystem

UNION 

SELECT  d.ssb_crmsystem_contact_ID, max(a.CreatedAt) AS MaxDate, d.sourcesystem
FROM dbo.vwDimCustomer_ModAcctId d 
JOIN [ods].[Eloqua_ActivityEmailOpen] a
	ON a.contactID = d.ssid AND d.sourcesystem = 'Eloqua Kings'
	WHERE a.createdat > (GETDATE () - 730)
GROUP BY d.ssb_crmsystem_contact_ID, d.sourcesystem



UNION 

SELECT d.ssb_crmsystem_contact_ID, max(a.CreatedAt) AS MaxDate, d.sourcesystem
FROM dbo.vwDimCustomer_ModAcctId d 
JOIN [ods].[Eloqua_ActivityEmailClickThrough] a
	ON a.contactID = d.ssid AND d.sourcesystem = 'Eloqua Kings'
	WHERE a.createdat > (GETDATE () - 730)
GROUP BY d.ssb_crmsystem_contact_ID, d.sourcesystem


UNION 

SELECT d.ssb_crmsystem_contact_ID, max(a.CreatedAt) AS MaxDate, d.sourcesystem
FROM dbo.vwDimCustomer_ModAcctId d 
JOIN  [ods].[Eloqua_ActivityEmailSend] a
	ON a.contactID = d.ssid AND d.sourcesystem = 'Eloqua Kings'
	WHERE a.createdat > (GETDATE () - 730)
GROUP BY d.ssb_crmsystem_contact_ID, d.sourcesystem


UNION 

SELECT  d.ssb_crmsystem_contact_ID, max(a.CreatedAt) AS MaxDate, d.sourcesystem 
FROM dbo.vwDimCustomer_ModAcctId d 
JOIN  [ods].[Eloqua_ActivityEmailSubscribe] a
	ON a.contactID = d.ssid AND d.sourcesystem = 'Eloqua Kings'
	WHERE a.createdat > (GETDATE () - 730)
GROUP BY d.ssb_crmsystem_contact_ID, d.sourcesystem


UNION 

SELECT d.ssb_crmsystem_contact_ID, max(a.CreatedAt) AS MaxDate, d.sourcesystem
FROM dbo.vwDimCustomer_ModAcctId d 
JOIN  [ods].[Eloqua_ActivityFormSubmit] a
	ON a.contactID = d.ssid AND d.sourcesystem = 'Eloqua Kings'
	WHERE a.createdat > (GETDATE () - 730)
GROUP BY d.ssb_crmsystem_contact_ID, d.sourcesystem




UNION 

SELECT d.ssb_crmsystem_contact_ID, max(a.CreatedAt) AS MaxDate, d.sourcesystem
FROM dbo.vwDimCustomer_ModAcctId d 
JOIN  [ods].[Eloqua_ActivityPageView] a
	ON a.contactID = d.ssid AND d.sourcesystem = 'Eloqua Kings'
	WHERE a.createdat > (GETDATE () - 730)
GROUP BY d.ssb_crmsystem_contact_ID, d.sourcesystem



UNION 

SELECT d.ssb_crmsystem_contact_ID, MAX(a.CreatedAt) AS MaxDate, d.sourcesystem 
FROM dbo.vwDimCustomer_ModAcctId d 
JOIN [ods].[Eloqua_ActivityWebVisit] a
	ON a.contactID = d.ssid AND d.sourcesystem = 'Eloqua Kings'
	WHERE a.createdat > (GETDATE () - 730)
GROUP BY d.ssb_crmsystem_contact_ID, d.sourcesystem


UNION 

SELECT d.ssb_crmsystem_contact_ID, max(a.SaleDate) AS MaxDate, d.sourcesystem
FROM dbo.vwDimCustomer_ModAcctId d 
JOIN  [ods].[Host_Trans] a
	ON a.Calc_HostAccountId = d.ssid AND d.sourcesystem = 'Host Kings'
WHERE a.SaleDate> (GETDATE () - 1825)
GROUP BY d.ssb_crmsystem_contact_ID, d.sourcesystem
--329593

UNION 

SELECT d.ssb_crmsystem_contact_ID, max(a.SSCreatedDate) AS MaxDate, d.sourcesystem
FROM dbo.vwDimCustomer_ModAcctId d 
JOIN  [dbo].[FactTicketSales] a
	ON a.dimcustomerID = d.DimCustomerId AND d.sourcesystem = 'TM'
	WHERE a.SSCreatedDate > (GETDATE () - 730)
GROUP BY d.ssb_crmsystem_contact_ID, d.sourcesystem

union

SELECT  d.ssb_crmsystem_contact_ID, MAX(t.add_datetime) AS MaxDate, d.SourceSystem
FROM ods.TM_Tex  t
join dbo.vwDimCustomer_ModAcctId d
	ON d.ssid = CAST(t.acct_ID AS nvarchar)
WHERE add_datetime > (GETDATE () - 730)
AND d.SourceSystem = 'TM' 
GROUP BY d.SSB_CRMSYSTEM_CONTACT_ID, d.SourceSystem


)xxx



--this is select the max date and source for each guid (source winner)
IF OBJECT_ID('tempdb.Kings.#sourcewinner')IS NOT NULL DROP TABLE #sourcewinner
SELECT * 
INTO  #sourcewinner 
from
(SELECT ssb_crmsystem_contact_ID, MaxDate,SourceSystem, ROW_NUMBER() OVER (PARTITION BY SSB_CRMSYSTEM_CONTACT_ID
	ORDER BY  MaxDate desc) ma
FROM #tmpMaxDate
	 )a
 WHERE ma = 1


 -------------------------------------------------------------------Eloqua-------------------------------------------------------------------

 ------
 --This selects all the ssb_crmsystem_contact_ID last engagement date for each source
 ------

 IF OBJECT_ID('tempdb.Kings.#contacts')IS NOT NULL DROP TABLE #contacts

--This is select all relevant guids specified in the initial criteria from Kings 
SELECT DISTINCT ssb_crmsystem_contact_ID, EmailPrimary
INTO  #Contacts
FROM 
(

SELECT DISTINCT d.SSB_CRMSYSTEM_CONTACT_ID, d.EmailPrimary
FROM dbo.vwDimCustomer_ModAcctId d
JOIN ods.eloqua_contact C
	ON c.id = d.ssid
WHERE d.SourceSystem = 'Eloqua Kings'
AND c.createdAt >(GETDATE () - 730)


UNION

SELECT DISTINCT  d.ssb_crmsystem_contact_ID, d.EmailPrimary
FROM dbo.vwDimCustomer_ModAcctId d 
JOIN  [ods].[Eloqua_ActivityEmailSubscribe] a
	ON a.contactID = d.ssid AND d.sourcesystem = 'Eloqua Kings'
	WHERE a.createdat > (GETDATE () - 730)


union

SELECT DISTINCT d.ssb_crmsystem_contact_ID, d.EmailPrimary
FROM  ods.eloqua_contact C
JOIN [ods].[Eloqua_ActivityEmailOpen] o 
	ON c.id = o.contactid
JOIN dbo.vwDimCustomer_ModAcctId d
	ON d.ssid = c.id
WHERE o.createdat > (GETDATE () - 730)
AND d.SourceSystem = 'Eloqua Kings'
UNION

SELECT DISTINCT d.ssb_crmsystem_contact_ID, d.EmailPrimary
FROM  ods.eloqua_contact C
JOIN [ods].[Eloqua_ActivityEmailSend] s
	ON s.contactID = C.ID
JOIN dbo.vwDimCustomer_ModAcctId d
	ON d.ssid = c.id
WHERE s.createdat > (GETDATE () - 730)
AND d.SourceSystem = 'Eloqua Kings'
UNION 


SELECT d.ssb_crmsystem_contact_ID, d.EmailPrimary
FROM dbo.vwDimCustomer_ModAcctId d 
JOIN  [ods].[Eloqua_ActivityPageView] a
	ON a.contactID = d.ssid 
	WHERE a.createdat > (GETDATE () - 730)
		AND d.sourcesystem = 'Eloqua Kings'

union

SELECT DISTINCT d.ssb_crmsystem_contact_ID, d.EmailPrimary
FROM  ods.eloqua_contact C
JOIN [ods].[Eloqua_ActivityEmailClickThrough] cl
	ON cl.contactID = c.ID
JOIN dbo.vwDimCustomer_ModAcctId d
	ON d.ssid = c.id
WHERE cl.createdat > (GETDATE () - 730)
AND d.SourceSystem = 'Eloqua Kings'

UNION

SELECT DISTINCT d.ssb_crmsystem_contact_ID, d.EmailPrimary
FROM  ods.eloqua_contact C
 JOIN [ods].[Eloqua_ActivityFormSubmit]fs
	ON fs.contactID = c.ID
JOIN dbo.vwDimCustomer_ModAcctId d
	ON d.ssid = c.id
WHERE fs.createdat > (GETDATE () - 730)
AND d.SourceSystem = 'Eloqua Kings'

UNION


SELECT DISTINCT d.ssb_crmsystem_contact_ID, d.EmailPrimary
FROM  ods.eloqua_contact C
 join [ods].[Eloqua_ActivityWebVisit] wv
	ON wv.contactID = c.ID
JOIN dbo.vwDimCustomer_ModAcctId d
	ON d.ssid = c.id
WHERE wv.createdat > (GETDATE () - 730)
AND d.SourceSystem = 'Eloqua Kings'

UNION	

SELECT DISTINCT d.ssb_crmsystem_contact_ID, d.EmailPrimary
FROM  [ro].[vw_FactTicketSales] f 
JOIN dbo.vwDimCustomer_ModAcctId d
	ON CAST(f.ETL__SSID_TM_acct_ID AS nvarchar) = d.accountid
WHERE f.orderdate > (GETDATE () - 730)
AND d.SourceSystem = 'TM'

UNION


SELECT DISTINCT d.ssb_crmsystem_contact_ID, d.EmailPrimary
FROM ods.TM_Tex  t
join dbo.vwDimCustomer_ModAcctId d
	ON d.ssid = CAST(t.acct_ID AS nvarchar)
WHERE add_datetime > (GETDATE () - 730)
AND d.SourceSystem = 'TM' 

UNION

SELECT DISTINCT d.ssb_crmsystem_contact_ID, d.EmailPrimary
FROM ods.Host_Trans h 
join dbo.vwDimCustomer_ModAcctId d
	ON d.ssid = CAST(h.Calc_HostAccountId AS nvarchar)
WHERE saledate > (GETDATE () - 1825)
AND  d.SourceSystem = 'Host Kings'

)x










IF OBJECT_ID('tempdb.Kings.#maxdateEloqua')IS NOT NULL DROP TABLE #maxdateEloqua
SELECT DISTINCT xx.ssb_crmsystem_contact_id, MAX(xx.maxdate)MaxDate, xx.EmailPrimary 
INTO #maxdateEloqua
FROM(
	
SELECT  d.ssb_crmsystem_contact_ID, max(a.CreatedAt) AS MaxDate, d.EmailPrimary
FROM dbo.vwDimCustomer_ModAcctId d 
JOIN [ods].[Eloqua_ActivityEmailOpen] a
	ON a.contactID = d.ssid AND d.sourcesystem = 'Eloqua Kings'
	WHERE a.createdat > (GETDATE () - 730)
GROUP BY d.ssb_crmsystem_contact_ID, d.EmailPrimary



UNION 

SELECT d.ssb_crmsystem_contact_ID, max(a.CreatedAt) AS MaxDate, d.EmailPrimary
FROM dbo.vwDimCustomer_ModAcctId d 
JOIN [ods].[Eloqua_ActivityEmailClickThrough] a
	ON a.contactID = d.ssid AND d.sourcesystem = 'Eloqua Kings'
	WHERE a.createdat > (GETDATE () - 730)
GROUP BY d.ssb_crmsystem_contact_ID, d.EmailPrimary

)xx
GROUP BY xx.SSB_CRMSYSTEM_CONTACT_ID,
         xx.EmailPrimary












IF OBJECT_ID('tempdb.Kings.#bounbceback')IS NOT NULL DROP TABLE #bounbceback
--Finds all guids that have bounceback activity
SELECT DISTINCT d.ssb_crmsystem_contact_ID, bb.EmailAddress, MAX(bb.CreatedAt) MaxBounceBack
INTO  #bounbceback
FROM  [ods].[Eloqua_Contact] c
JOIN [ods].[Eloqua_ActivityBounceback] bb
	ON bb.emailaddress = c.emailaddress
JOIN dbo.vwDimCustomer_ModAcctId d
	ON d.ssid = c.id AND d.SourceSystem = 'Eloqua Kings'
	GROUP BY d.SSB_CRMSYSTEM_CONTACT_ID,bb.EmailAddress




IF OBJECT_ID('tempdb.Kings.#bouncebacklimited')IS NOT NULL DROP TABLE #bouncebacklimited
SELECT DISTINCT b.*
INTO #bouncebacklimited
FROM #bounbceback b
JOIN #maxdateEloqua e
ON e.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID AND b.EmailAddress = e.EmailPrimary
WHERE e.MaxDate < b.MaxBounceBack





IF OBJECT_ID('tempdb.Kings.#activecontacts')IS NOT NULL DROP TABLE #activecontacts
--Removes all Bounce back Guids
SELECT DISTINCT c.ssb_crmsystem_contact_id, c.EmailPrimary
INTO   #activecontacts
FROM #contacts c
LEFT OUTER JOIN #bouncebacklimited bb
	ON bb.ssb_crmsystem_contact_id = c.ssb_crmsystem_contact_id AND bb.EmailAddress = c.EmailPrimary
WHERE bb.ssb_crmsystem_contact_id IS NULL
AND c.EmailPrimary <> ''


--select * FROM #activecontacts WHERE EmailPrimary in
--('jbusch@addlins.com'
--,'Slidewayz44@yahoo.com'
--,'Newtsaelee@gmail.com')

--557181
--Joins to Composite record to receive the email associated with guid
IF OBJECT_ID('tempdb.Kings.#tmp')IS NOT NULL DROP TABLE #tmp
SELECT distinct  comp.EmailPrimary, a.SSB_CRMSYSTEM_CONTACT_ID
INTO  #tmp
FROM #activecontacts a
JOIN mdm.CompositeRecord comp
 ON comp.SSB_CRMSYSTEM_CONTACT_ID = a.SSB_CRMSYSTEM_CONTACT_ID AND comp.EmailPrimary = a.EmailPrimary
WHERE 1=1 -- comp.SourceSystemPriority = 1
AND (comp.EmailPrimary is NOT NULL OR comp.EmailPrimary <> '')



--SELECT SSB_CRMSYSTEM_CONTACT_ID,EmailPrimary,* FROM dbo.vwDimCustomer_ModAcctId
--WHERE SSB_CRMSYSTEM_CONTACT_ID IN ('4DBA3657-C561-4A57-8C89-139D9A9A0461'
--,'733BC025-34B3-492C-A6FD-6CA49FE2A311'
--,'F9175154-03E5-4D5A-B42D-3233A66B5F81'
--,'465428A8-5D86-487B-83F0-11051DC5F274')


--SELECT SSB_CRMSYSTEM_CONTACT_ID,EmailPrimary,* FROM mdm.CompositeRecord
--WHERE SSB_CRMSYSTEM_CONTACT_ID IN ('4DBA3657-C561-4A57-8C89-139D9A9A0461'
--,'733BC025-34B3-492C-A6FD-6CA49FE2A311'
--,'F9175154-03E5-4D5A-B42D-3233A66B5F81'
--,'465428A8-5D86-487B-83F0-11051DC5F274')



--SELECT * FROM #tmp
--WHERE EmailPrimary in('jbusch@addlins.com'
--,'Slidewayz44@yahoo.com'
--,'Newtsaelee@gmail.com')



IF OBJECT_ID('tempdb.Kings.#tmpEloquaContact')IS NOT NULL DROP TABLE #tmpEloquaContact
SELECT DISTINCT d.emailPrimary, c.SSB_CRMSYSTEM_CONTACT_ID, (CASE WHEN sw.MaxDate > isnull(u.USCreated,'1900-01-01') and ec.IsSubscribed = 1 THEN 0 ELSE 1 END) as UnsubscribedWithRecentEngagement
INTO #tmpEloquaContact
--INTO #nonranked
FROM #tmp c
JOIN dbo.vwDimCustomer_ModAcctId d
 ON c.SSB_CRMSYSTEM_CONTACT_ID = d.SSB_CRMSYSTEM_CONTACT_ID
JOIN ods.Eloqua_Contact ec
 ON ec.id = d.SSID AND ec.Name = d.EmailPrimary
JOIN #sourcewinner sw
ON sw.SSB_CRMSYSTEM_CONTACT_ID = c.SSB_CRMSYSTEM_CONTACT_ID
--JOIN #guidswithpurchases gwp
--ON gwp.SSB_CRMSYSTEM_CONTACT_ID = c.SSB_CRMSYSTEM_CONTACT_ID
LEFT JOIN (SELECT emailaddress, MAX(createdat) USCreated from [ods].[Eloqua_ActivityEmailUnsubscribe] GROUP BY emailaddress ) u
ON u.EmailAddress = ec.EmailAddress
WHERE d.sourcesystem = 'Eloqua Kings'
 AND ec.ETL_IsDeleted = 0
AND(ec.IsSubscribed = '1' 
OR sw.MaxDate > isnull(u.USCreated,'1900-01-01'))








IF OBJECT_ID('tempdb.Kings.#unsubscribewithrecentengagment')IS NOT NULL DROP TABLE #unsubscribewithrecentengagment
SELECT DISTINCT EmailPrimary
INTO #unsubscribewithrecentengagment
FROM #tmpEloquaContact
WHERE UnsubscribedWithRecentEngagement = 1








--- Getting all Kings and Host transactions for the last 2 years for Kings and 5 years for Host to use for included Eloqua contacts that have transaction dates more recent than unsubscribed date
IF OBJECT_ID('tempdb.Kings.#guidswithpurchases')IS NOT NULL DROP TABLE #guidswithpurchases
SELECT DISTINCT ssb_crmsystem_contact_ID, MAX(maxDATE)  AS maxdate, xx.EmailPrimary
INTO #guidswithpurchases
FROM (
SELECT d.ssb_crmsystem_contact_ID, max(a.SaleDate) AS MaxDate, d.sourcesystem,d.EmailPrimary
FROM dbo.vwDimCustomer_ModAcctId d 
JOIN  [ods].[Host_Trans] a
	ON a.Calc_HostAccountId = d.ssid AND d.sourcesystem = 'Host Kings'
WHERE a.SaleDate> (GETDATE () - 1825)
GROUP BY d.ssb_crmsystem_contact_ID, d.sourcesystem,d.EmailPrimary
--329593

UNION 

SELECT d.ssb_crmsystem_contact_ID, max(a.SSCreatedDate) AS MaxDate, d.sourcesystem, d.EmailPrimary
FROM dbo.vwDimCustomer_ModAcctId d 
JOIN  [dbo].[FactTicketSales] a
	ON a.dimcustomerID = d.DimCustomerId AND d.sourcesystem = 'TM'
	WHERE a.SSCreatedDate > (GETDATE () - 730)
GROUP BY d.ssb_crmsystem_contact_ID, d.sourcesystem,d.EmailPrimary

union

SELECT  d.ssb_crmsystem_contact_ID, MAX(t.add_datetime) AS MaxDate, d.SourceSystem, d.EmailPrimary
FROM ods.TM_Tex  t
join dbo.vwDimCustomer_ModAcctId d
	ON d.ssid = CAST(t.acct_ID AS nvarchar)
WHERE add_datetime > (GETDATE () - 730)
AND d.SourceSystem = 'TM' 
GROUP BY d.SSB_CRMSYSTEM_CONTACT_ID, d.SourceSystem,d.EmailPrimary

union

SELECT d.ssb_crmsystem_contact_ID, max(a.CreatedAt) AS MaxDate, d.sourcesystem,d.EmailPrimary
FROM dbo.vwDimCustomer_ModAcctId d 
JOIN  [ods].[Eloqua_ActivityFormSubmit] a
	ON a.contactID = d.ssid AND d.sourcesystem = 'Eloqua Kings'
	WHERE a.createdat > (GETDATE () - 730)
GROUP BY d.ssb_crmsystem_contact_ID, d.sourcesystem,d.EmailPrimary
)xx
GROUP BY xx.ssb_crmsystem_contact_ID, xx.EmailPrimary




IF OBJECT_ID('tempdb.Kings.#nopurchases')IS NOT NULL DROP TABLE #nopurchases
SELECT DISTINCT u.EmailPrimary
INTO #nopurchases
FROM #unsubscribewithrecentengagment u
LEFT OUTER JOIN #guidswithpurchases g
ON g.EmailPrimary = u.EmailPrimary
WHERE g.EmailPrimary IS NULL


IF EXISTS (select * from sys.tables where name = 'ETL_ActiveEloquacontacts' and type = 'U')
	DROP TABLE ods.ETL_ActiveEloquacontacts;


--547665
SELECT e.*
INTO ods.ETL_ActiveEloquacontacts
FROM #tmpEloquaContact e
LEFT OUTER JOIN #nopurchases n
ON n.EmailPrimary = e.EmailPrimary
WHERE n.EmailPrimary IS null


--SELECT  *
--INTO #unengaged
--FROM  ods.Eloqua_Contact c
-- LEFT OUTER JOIN #ActiveEloquaContacts a
-- ON c.EmailAddress = a.EmailPrimary
-- WHERE a.EmailPrimary IS null


-- SELECT id,EmailAddress FROM #unengaged
-- WHERE ETL_IsDeleted = 0


-- SELECT * 
-- INTO #unengagegd
-- FROM #unengaged
-- WHERE ETL_DeletedDate = 0
-- JOIN #ActiveEloquaContacts
-- ON #ActiveEloquaContacts.EmailPrimary = #unengaged.EmailPrimary

--SELECT * FROM etl.Eloqua_contacts_outbound_Stage
--WHERE EmailPrimary IN ('j.meyer21@comcast.net','tedg1@grebitus.com','jeffpzimmerman@gmail.com','geekengnr@yahoo.com','retiredlady60@aol.com')


-------------------------------------------------------------ProdCopyContact------------------------------------------------------------------



IF OBJECT_ID('tempdb.Kings.#tmpProdCopy')IS NOT NULL DROP TABLE #tmpProdCopy


SELECT *
INTO   #tmpProdCopy
FROM (
 SELECT c.SSB_CRMSYSTEM_CONTACT_ID__c
 , C.accountID
 , C.id,c.SSB_CRMSYSTEM_ACCT_ID__c AS contact_SSB_CRMSYSTEM_ACCT_ID__c
 ,A.Id AS A_ID
 , a.OwnerId
 --, a.Kings_Season_Ticket_Holder__C
 , a.share_partner__C
 , a.group_category__C 
 ,a.New_Fulls_Lead_Score__C
 , a.SSB_CRMSYSTEM_ACCT_ID__c
 ,u.ID AS [USER ID]
 , u.[name] AS u_name
 , u.email
 , u.phone
 , RepGroupSale
 , GroupLeader
 , RANK() OVER(PARTITION BY c.SSB_CRMSYSTEM_CONTACT_ID__c ORDER BY a.Kings_Season_Ticket_Holder__C DESC,a.New_Fulls_Lead_Score__C DESC, a.share_partner__C, a.CreatedDate, c.id)pcr

FROM KingsCI_Reporting.prodcopy.Contact c
JOIN KingsCI_Reporting.prodcopy.Account a	
		ON a.id = c.accountid
JOIN KingsCI_Reporting.prodcopy.[user] u--1873210
		ON u.ID = a.ownerID 
LEFT JOIN (SELECT accountID	
				 ,SUM(CASE WHEN season__C = '2017-18' AND name LIKE'%group%' THEN 1 ELSE 0 END) AS RepGroupSale
				 ,SUM(CASE WHEN season__C = '2017-18' and name like '%deposit%' and stagename = 'Closed Won' then 1 else 0 END) AS GroupLeader
		   FROM KingsCI_Reporting.prodcopy.opportunity
		   GROUP BY AccountId
		   ) o ON o.accountid = a.ID 
WHERE c.isdeleted = 0 
	  AND a.isdeleted = 0)x
WHERE pcr = 1

----------------------------------------------------------------------------EMAILPRIMARY Priority Ranking for non mastered demographic data----------------------------------------------------


IF OBJECT_ID('tempdb.Kings.#emailsourcepriorityranking')IS NOT NULL DROP TABLE #emailsourcepriorityranking
SELECT * ,
ROW_NUMBER() OVER(PARTITION BY x.EmailPrimary ORDER BY x.SourceSystemPriority desc,x.UpdatedDate DESC) sourcerank

INTO #emailsourcepriorityranking
FROM (
SELECT d.DimCustomerId
	  ,d.EmailPrimary
		, CASE WHEN  d.SourceSystem = 'TM' THEN 99
			   WHEN  d.SourceSystem = 'Host' THEN 89
			   WHEN  d.SourceSystem = 'Kings PC_SFDC Account' THEN 79
			   WHEN  d.SourceSystem = 'Kings PC_SFDC Contact' THEN 69
			   WHEN  d.SourceSystem = 'Eloqua Kings' THEN 59
			   WHEN  d.SourceSystem = 'LA_Cust' THEN 49
			   WHEN  d.SourceSystem = 'SKiData' THEN 39
			   WHEN  d.SourceSystem = 'Experience' THEN 29
			   WHEN  d.SourceSystem = 'Appetize' THEN 19
			   ELSE 0 END AS SourceSystemPriority
		,d.UpdatedDate
		,d.SourceSystem
--select count (*)
FROM dbo.vwDimCustomer_ModAcctId d --4364879
where d.EmailPrimary <> ''
--GROUP BY d.DimCustomerId, d.EmailPrimary,d.SourceSystem
)x


IF OBJECT_ID('tempdb.Kings.#emailsourcedemo')IS NOT NULL DROP TABLE #emailsourcedemo
SELECT e.DimCustomerId,d.EmailPrimary, d.FirstName, d.MiddleName, d.LastName,d.Suffix, d.AddressPrimaryStreet,d.AddressPrimarySuite, d.AddressPrimaryCity, d.AddressPrimaryState, 
d.AddressPrimaryZip, d.AddressPrimaryCountry ,d.Birthday,d.PhonePrimary,d.PhoneHome,d.PhoneCell,d.PhoneBusiness,d.PhoneFax,d.Prefix
INTO #emailsourcedemo
FROM dbo.vwDimCustomer_ModAcctId d
JOIN #emailsourcepriorityranking e
ON e.DimCustomerId = d.DimCustomerId
WHERE e.sourcerank = 1



IF OBJECT_ID('tempdb.Kings.#TMTicketRank')IS NOT NULL DROP TABLE #TMTicketRank
SELECT * ,
ROW_NUMBER() OVER(PARTITION BY xx.EmailPrimary ORDER BY xx.SuiteCurrentYear,xx.SeasonTicketCurrentYear desc,xx.PartialPlanCurrentYear desc,xx.GroupCurrentYear desc, xx.SingleCurrentYear desc)TMTicketRank

INTO  #TMTicketRank
FROM (
SELECT d.DimCustomerId
	  ,d.EmailPrimary
		
		, MAX(CASE WHEN f.DimTicketTypeId = 18 AND s.seasonyear  = YEAR(GETDATE()) THEN 99 ELSE 0 END) AS SuiteCurrentYear
		, MAX(CASE WHEN f.DimTicketTypeId = 1 AND s.seasonyear  = YEAR(GETDATE()) THEN 89 ELSE 0 END) AS SeasonTicketCurrentYear
		, MAX(CASE WHEN f.DimTicketTypeId IN(20,21,22,23) AND s.seasonyear  = YEAR(GETDATE()) THEN 79 ELSE 0 END) AS PartialPlanCurrentYear
		, max(CASE WHEN f.DimTicketTypeId = 13 AND s.seasonyear  = YEAR(GETDATE()) THEN 69 ELSE 0 END) AS GroupCurrentYear
		, max(CASE WHEN f.DimTicketTypeId = 12 AND s.seasonyear  = YEAR(GETDATE()) THEN 59 ELSE 0 END) AS SingleCurrentYear


--select count (*)
FROM #emailsourcepriorityranking d --4364879
LEFT join dbo.FactTicketSales f
ON f.DimCustomerId = d.DimCustomerId --1107337
LEFT JOIN dbo.DimSeason s
ON f.DimSeasonId = s.DimSeasonId
WHERE d.SourceSystem = 'TM'
AND d.DimCustomerId <>-1     --1107190
AND d.EmailPrimary <> ''
GROUP BY d.DimCustomerId, d.EmailPrimary
) xx



IF OBJECT_ID('tempdb.Kings.#emailticketdemowinner')IS NOT NULL DROP TABLE #emailticketdemowinner
SELECT e.DimCustomerId,d.EmailPrimary, d.FirstName, d.MiddleName, d.LastName,d.Suffix, d.AddressPrimaryStreet,d.AddressPrimarySuite, d.AddressPrimaryCity, d.AddressPrimaryState, 
d.AddressPrimaryZip, d.AddressPrimaryCountry ,d.Birthday,d.PhonePrimary,d.PhoneHome,d.PhoneCell,d.PhoneBusiness,d.PhoneFax,d.Prefix
INTO #emailticketdemowinner
FROM dbo.vwDimCustomer_ModAcctId d
JOIN #TMTicketRank e
ON e.DimCustomerId = d.DimCustomerId
WHERE e.TMTicketRank = 1



IF OBJECT_ID('tempdb.Kings.#SourceUpdatedDate')IS NOT NULL DROP TABLE #SourceUpdatedDate
SELECT * ,
ROW_NUMBER() OVER(PARTITION BY xxx.EmailPrimary ORDER BY xxx.ArchticsUpdateDate desc,xxx.HostUpdateDate desc,xxx.SFDCAccountUpdateDate desc,
							   xxx.SFDCContactUpdateDate desc, xxx.SkidataUpdateDate DESC, xxx.EloquaUpdateDate DESC, xxx.AppetizeUpdateDate desc)SourceUpdatedDate

INTO  #SourceUpdatedDate
FROM (
SELECT d.DimCustomerId
	  ,d.EmailPrimary
		, max(CASE WHEN m.SourceSystem = 'TM' THEN m.UpdatedDate ELSE NULL END) ArchticsUpdateDate
		, max(CASE WHEN m.SourceSystem = 'host' THEN m.UpdatedDate ELSE NULL END) HostUpdateDate
		, max(CASE WHEN m.SourceSystem = 'Kings PC_SFDC Account' THEN m.UpdatedDate ELSE NULL END) SFDCAccountUpdateDate
		, max(CASE WHEN m.SourceSystem = 'Kings PC_SFDC Contact' THEN m.UpdatedDate ELSE NULL END) SFDCContactUpdateDate
		, max(CASE WHEN m.SourceSystem = 'Skidata' THEN m.UpdatedDate ELSE NULL END) SkidataUpdateDate
		, max(CASE WHEN m.SourceSystem = 'Eloqua Kings' THEN m.UpdatedDate ELSE NULL END) EloquaUpdateDate
		, max(CASE WHEN m.SourceSystem = 'Appetize' THEN m.UpdatedDate ELSE NULL END) AppetizeUpdateDate

--INTO #emailranking
--select count (*)
FROM #TMTicketRank d --4364879
JOIN dbo.vwDimCustomer_ModAcctId m
ON m.DimCustomerId = d.DimCustomerId
WHERE d.TMTicketRank <> 1
AND d.DimCustomerId <>-1     --1107190
AND d.EmailPrimary <> ''
GROUP BY d.DimCustomerId, d.EmailPrimary
)xxx


IF OBJECT_ID('tempdb.Kings.#emailsourceupdatewinner')IS NOT NULL DROP TABLE #emailsourceupdatewinner
SELECT e.DimCustomerId,d.EmailPrimary, d.FirstName, d.MiddleName, d.LastName,d.Suffix, d.AddressPrimaryStreet,d.AddressPrimarySuite, d.AddressPrimaryCity, d.AddressPrimaryState, 
d.AddressPrimaryZip, d.AddressPrimaryCountry ,d.Birthday,d.PhonePrimary,d.PhoneHome,d.PhoneCell,d.PhoneBusiness,d.PhoneFax,d.Prefix
INTO #emailsourceupdatewinner
FROM dbo.vwDimCustomer_ModAcctId d
JOIN #SourceUpdatedDate e
ON e.DimCustomerId = d.DimCustomerId
WHERE e.SourceUpdatedDate = 1

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--SELECT  COUNT(*)
--FROM (

--INSERT INTO etl.Eloqua_Contacts_outbound


		SELECT
		CAST(NULL as binary(32)) as ETL_DeltaHashKey
	 --  ,tec.SSID 
	   ,tec.emailprimary
	   ,tec.SSB_CRMSYSTEM_CONTACT_ID
	   , CASE WHEN m.SSB_CRMSYSTEM_ACCT_ID = '' THEN NULL ELSE m.SSB_CRMSYSTEM_ACCT_ID END  AS SSB_CRMSYSTEM_ACCT_ID
	   ,CASE WHEN m.accountID = '' THEN NULL ELSE m.accountID END AS ArchticsID
	   ,CASE WHEN m.First_Name = '' THEN NULL ELSE m.First_Name END AS FirstName
	   ,CASE WHEN m.MiddleName = '' THEN NULL ELSE m.MiddleName END AS MiddleName
	   ,CASE WHEN m.Last_Name = '' THEN NULL ELSE m.Last_Name END AS LastName
	   ,CASE WHEN m.suffix = '' THEN NULL ELSE m.Suffix END AS Suffix
	   ,CASE WHEN m.Address_Street = '' THEN NULL ELSE m.Address_Street END AS Address1
	   ,CASE WHEN m.Address_Suite = '' THEN NULL ELSE m.Address_Suite END AS Address2 
	   , NULL AS address3 
	   , NULL AS address4 
	   ,CASE WHEN m.Address_city = '' THEN NULL ELSE m.Address_city END AS Addressprimarycity
	   ,CASE WHEN m.address_state = '' THEN NULL ELSE m.address_state END AS addressprimarystate
	   ,CASE WHEN m.address_zip = '' THEN NULL ELSE m.address_zip END AS addressprimaryzip
	   ,CASE WHEN m.address_country = '' THEN NULL ELSE m.address_country END AS addressprimarycountry
	   ,CASE WHEN m.birthday = '1900-01-01' THEN NULL ELSE m.Birthday END AS Birthday
       ,CASE WHEN m.phone = '' THEN NULL ELSE m.phone END AS PhonePrimary
	   ,CASE WHEN m.PhoneHome = '' THEN NULL ELSE m.PhoneHome END AS PhoneHome
	   ,CASE WHEN m.PhoneCell = '' THEN NULL ELSE m.PhoneCell END AS PhoneCell
	   ,CASE WHEN m.PhoneBusiness = '' THEN NULL ELSE m.PhoneBusiness END AS PhoneBusiness
	   ,CASE WHEN m.PhoneFax = '' THEN NULL ELSE m.PhoneFax END AS PhoneFax
	   ,CASE WHEN m.prefix = '' THEN NULL ELSE m.prefix END AS Title
	   ,CASE WHEN COALESCE(er.FirstName,TR.FirstName,SUD.FirstName) = '' THEN NULL ELSE COALESCE(er.FirstName,TR.FirstName,SUD.FirstName)  END AS RankedFirstName
	   ,CASE WHEN COALESCE(er.MiddleName,TR.MiddleName,SUD.MiddleName) = '' THEN NULL ELSE COALESCE(er.MiddleName,TR.MiddleName,SUD.MiddleName)END AS RankedMiddleName
	   ,CASE WHEN COALESCE(er.LastName,TR.LastName,SUD.LastName) = '' THEN NULL ELSE COALESCE(er.LastName,TR.LastName,SUD.LastName) END AS RankedLastName
	   ,CASE WHEN COALESCE(er.Suffix,TR.Suffix,SUD.Suffix) = '' THEN NULL ELSE COALESCE(er.Suffix,TR.Suffix,SUD.Suffix) END AS RankedSuffix
	   ,CASE WHEN COALESCE(er.AddressPrimaryStreet,TR.AddressPrimaryStreet,SUD.AddressPrimaryStreet) = '' THEN NULL ELSE COALESCE(er.AddressPrimaryStreet,TR.AddressPrimaryStreet,SUD.AddressPrimaryStreet) END AS RankedAddress1
	   ,CASE WHEN COALESCE(er.AddressPrimarySuite,TR.AddressPrimarySuite,SUD.AddressPrimarySuite)= '' THEN NULL ELSE COALESCE(er.AddressPrimarySuite,TR.AddressPrimarySuite,SUD.AddressPrimarySuite) END AS RankedAddress2 
	   , NULL AS rankedaddress3 
	   , NULL AS rankedaddress4 
	   ,CASE WHEN COALESCE(er.AddressPrimaryCity,TR.AddressPrimaryCity,SUD.AddressPrimaryCity)= '' THEN NULL ELSE COALESCE(er.AddressPrimaryCity,TR.AddressPrimaryCity,SUD.AddressPrimaryCity) END AS RankedAddressprimarycity
	   ,CASE WHEN COALESCE(er.AddressPrimaryState,TR.AddressPrimaryState,SUD.AddressPrimaryState)= '' THEN NULL ELSE COALESCE(er.AddressPrimaryState,TR.AddressPrimaryState,SUD.AddressPrimaryState) END AS RankedAddressprimarystate
	   ,CASE WHEN COALESCE(er.AddressPrimaryZip,TR.AddressPrimaryZip,SUD.AddressPrimaryZip) = '' THEN NULL ELSE COALESCE(er.AddressPrimaryZip,TR.AddressPrimaryZip,SUD.AddressPrimaryZip) END AS RankedAddressprimaryzip
	   ,CASE WHEN COALESCE(er.AddressPrimaryCountry,TR.AddressPrimaryCountry,SUD.AddressPrimaryCountry) = '' THEN NULL ELSE COALESCE(er.AddressPrimaryCountry,TR.AddressPrimaryCountry,SUD.AddressPrimaryCountry) END AS RankedAddressprimarycountry
	   ,CASE WHEN COALESCE(er.Birthday,TR.Birthday,SUD.Birthday) = '1900-01-01' THEN NULL ELSE COALESCE(er.Birthday,TR.Birthday,SUD.Birthday) END AS RankedBirthday
	   ,CASE WHEN COALESCE(er.PhonePrimary,TR.PhonePrimary,SUD.PhonePrimary) = '' THEN NULL ELSE COALESCE(er.PhonePrimary,TR.PhonePrimary,SUD.PhonePrimary) END AS RankedPhonePrimary
	   ,CASE WHEN COALESCE(er.PhoneHome,TR.PhoneHome,SUD.PhoneHome) = '' THEN NULL ELSE COALESCE(er.PhoneHome,TR.PhoneHome,SUD.PhoneHome) END AS RankedPhoneHome
	   ,CASE WHEN COALESCE(er.PhoneCell,TR.PhoneCell,SUD.PhoneCell) = '' THEN NULL ELSE  COALESCE(er.PhoneCell,TR.PhoneCell,SUD.PhoneCell) END AS RankedPhoneCell
	   ,CASE WHEN COALESCE(er.PhoneBusiness,TR.PhoneBusiness,SUD.PhoneBusiness) = '' THEN NULL ELSE COALESCE(er.PhoneBusiness,TR.PhoneBusiness,SUD.PhoneBusiness) END AS RankedPhoneBusiness
	   ,CASE WHEN COALESCE(er.PhoneFax,TR.PhoneFax,SUD.PhoneFax) = '' THEN NULL ELSE COALESCE(er.PhoneFax,TR.PhoneFax,SUD.PhoneFax) END AS RankedPhoneFax
	   ,CASE WHEN COALESCE(er.prefix,TR.prefix,SUD.prefix) = '' THEN NULL ELSE COALESCE(er.prefix,TR.prefix,SUD.prefix) END AS RankedTitle
	   ,CASE WHEN pc.u_name ='' THEN NULL ELSE pc.u_name END AS [RepNAME] 
	   ,CASE WHEN pc.Email = '' THEN NULL ELSE pc.Email END AS [RepEmail]
	   ,CASE WHEN pc.phone = '' THEN NULL ELSE pc.phone END AS [RepPhone]
	   ,CASE WHEN pc.A_ID ='' THEN NULL ELSE pc.A_ID END  AS AccountID 
	   ,CASE WHEN pc.ID='' THEN NULL ELSE pc.ID END AS ContactID
       ,x.DateCreated 
	   ,x.DateModified 
	   , CASE WHEN m.birthday = '' THEN NULL ELSE SUBSTRING (CAST(m.Birthday AS NVARCHAR(10)),6,2) END AS [BirthMonth]
	   ,CASE WHEN m.birthday  ='' THEN NULL ELSE LEFT(CAST(m.Birthday AS NVARCHAR(10)), 4) END AS [BirthYear]
	   ,CASE WHEN RepGroupSale > 0 THEN pc.u_name ELSE NULL END   AS [RepGroupSales] 
   --    ,CASE WHEN pc.Kings_Season_Ticket_Holder__C ='' THEN NULL ELSE pc.Kings_Season_Ticket_Holder__C END    AS [STM Flag] 
       ,CASE WHEN pc.share_partner__C  ='' THEN NULL ELSE pc.share_partner__C END AS [SharePartnerFlag] 
       ,CASE WHEN pc.group_category__C = 'broker' THEN 1 ELSE 0 END   AS [BrokerFlag] 
       ,CASE WHEN GRoupLeader > 0 THEN 1 ELSE 0 END  AS [GroupLeaderFlag] 
       ,pc.New_Fulls_Lead_Score__C  AS [SFDCLeadScore] 
       ,CASE WHEN m.sourcesystem ='' THEN NULL ELSE m.sourcesystem END AS [Source] 
       ,tec.UnsubscribedWithRecentEngagement 
	   ,sw.MaxDate AS [LastEngagementDate] 
       ,sw.sourcesystem    AS [LastEngagementType] 
	   ,CASE WHEN m.AccountType = '' THEN NULL ELSE m.AccountType END    AS [AccountTypeDescription] 
	   ,IDENTITY (INT,1,1) AS QueueID
	  
INTO  etl.Eloqua_Contacts_Outbound_Stage



--select count(*)
     FROM ods.ETL_ActiveEloquacontacts tec	   --589109
	   LEFT JOIN EmailOutbound.Upsert_Standard m --for insert
		ON m.Email = tec.EmailPrimary--626413
	   LEFT JOIN #tmpProdCopy pc
	   ON pc.SSB_CRMSYSTEM_CONTACT_ID__C = tec.SSB_CRMSYSTEM_CONTACT_ID --626413
	   LEFT JOIN #sourcewinner sw
		ON sw.SSB_CRMSYSTEM_CONTACT_ID = tec.SSB_CRMSYSTEM_CONTACT_ID --626413
       JOIN (SELECT ssb_crmsystem_contact_ID, MIN(SSCreatedDate) Datecreated,MAX(ssUpdatedDate) DateModified --check to see if this should be source system specific
			FROM dbo.vwDimCustomer_ModAcctId
     		GROUP BY ssb_crmsystem_contact_ID) x ON tec.SSB_CRMSYSTEM_CONTACT_ID = x.SSB_CRMSYSTEM_CONTACT_ID --626413
	   LEFT JOIN #emailsourcedemo er
	   ON er.emailprimary = tec.emailprimary -- 626413
	   LEFT JOIN #emailticketdemowinner tr
       ON tr.emailprimary = tec.emailprimary  -- 626413
	   LEFT JOIN #emailsourceupdatewinner sud
	   ON sud.emailprimary = tec.emailprimary -- 626413




--	set list of excluded columns to be omitted from hashkey build
DECLARE @ExcludedHashColumns VARCHAR(MAX);
DECLARE	@ExcludedHashColumnsTbl TABLE (ExcludedColumns VARCHAR(MAX));
INSERT @ExcludedHashColumnsTbl (ExcludedColumns)
	EXEC etl.SSB_ExcludedHashColumns 'etl.Eloqua_Contacts_Outbound_Stage','QueueID';
SET @ExcludedHashColumns = (SELECT TOP 1 ExcludedColumns FROM @ExcludedHashColumnsTbl); 


--	build hashkey for comparison in merge
DECLARE @HashSyntax VARCHAR(MAX);
DECLARE	@HashTbl TABLE (HashSyntax VARCHAR(MAX));
INSERT @HashTbl (HashSyntax)
	EXEC etl.SSB_MergeHashFieldSyntax 'etl.Eloqua_Contacts_Outbound_Stage', @ExcludedHashColumns;
SET @HashSyntax = (SELECT TOP 1 HashSyntax FROM @HashTbl);


DECLARE @SQL nvarchar(MAX);
SET @SQL = CONCAT('UPDATE etl.Eloqua_Contacts_Outbound_Stage SET ETL_DeltaHashKey = ', @HashSyntax, ';');
EXEC (@SQL);



--SELECT emailprimary,COUNT(*) FROM [ods].[Eloqua_Contacts_Outbound_Merge]
--GROUP BY emailprimary
--HAVING COUNT(*) > 1


--truncate table [ods].[Eloqua_Contacts_Outbound_Merge]
MERGE [ods].[Eloqua_Contacts_Outbound_Merge] AS myTarget
USING (SELECT *
		FROM etl.Eloqua_Contacts_Outbound_Stage) AS mySource
ON mySource.emailprimary = myTarget.emailprimary --AND mysource.SSB_CRMSYSTEM_CONTACT_ID = myTarget.SSB_CRMSYSTEM_CONTACT_ID	


WHEN MATCHED
AND ISNULL(myTarget.ETL_DeltaHashKey,-1) <> ISNULL(mySource.ETL_DeltaHashKey,-1)
THEN UPDATE SET

		 myTarget.emailprimary						=mysource.emailprimary
		 ,myTarget.SSB_CRMSYSTEM_CONTACT_ID			=mysource.SSB_CRMSYSTEM_CONTACT_ID
		 ,myTarget.SSB_CRMSYSTEM_ACCT_ID			=mysource.SSB_CRMSYSTEM_ACCT_ID
		 ,myTarget.ArchticsID						=mysource.ArchticsID
		 ,myTarget.Comp_FirstName					=mysource.FirstName
		 ,myTarget.Comp_MiddleName					=mysource.MiddleName
		 ,myTarget.Comp_LastName				    =mysource.LastName
		 ,myTarget.Comp_suffix					    =mysource.suffix
		 ,myTarget.Comp_Address1					=mysource.Address1
		 ,myTarget.Comp_Address2					=mysource.Address2
		 ,myTarget.Comp_address3					=mysource.address3
		 ,myTarget.Comp_address4					=mysource.address4
		 ,myTarget.Comp_Addressprimarycity			=mysource.Addressprimarycity
		 ,myTarget.Comp_addressprimarystate			=mysource.addressprimarystate
		 ,myTarget.Comp_addressprimaryzip			=mySource.addressprimaryzip
		 ,myTarget.Comp_addressprimarycountry		=mysource.addressprimarycountry
		 ,myTarget.Comp_birthday					=mysource.birthday
		 ,myTarget.Comp_PhonePrimary				=mysource.PhonePrimary
		 ,myTarget.Comp_PhoneHome					=mysource.PhoneHome
		 ,myTarget.Comp_PhoneCell					=mysource.PhoneCell
		 ,myTarget.Comp_PhoneBusiness				=mysource.PhoneBusiness
		 ,myTarget.Comp_PhoneFax					=mysource.PhoneFax
		 ,myTarget.Comp_Title						=mysource.Title
		 ,mytarget.Source_FirstName					=mysource.RankedFirstName
		 ,mytarget.Source_MiddleName				=mysource.RankedMiddleName
		 ,mytarget.Source_LastName					=mysource.RankedLastName
		 ,mytarget.Source_Suffix					=mysource.RankedSuffix
		 ,mytarget.Source_Address1					=mysource.RankedAddress1
		 ,mytarget.Source_Address2					=mysource.RankedAddress2
		 ,mytarget.Source_address3					=mysource.rankedaddress3
		 ,mytarget.Source_address4					=mysource.rankedaddress4
		 ,mytarget.Source_Addressprimarycity		=mysource.RankedAddressprimarycity
		 ,mytarget.Source_Addressprimarystate		=mysource.RankedAddressprimarystate
		 ,mytarget.Source_Addressprimaryzip			=mysource.RankedAddressprimaryzip
		 ,mytarget.Source_Addressprimarycountry		=mysource.RankedAddressprimarycountry
		 ,mytarget.Source_Birthday					=mysource.RankedBirthday
		 ,mytarget.Source_PhonePrimary				=mysource.RankedPhonePrimary
		 ,mytarget.Source_PhoneHome					=mysource.RankedPhoneHome
		 ,mytarget.Source_PhoneCell					=mysource.RankedPhoneCell
		 ,mytarget.Source_PhoneBusiness				=mysource.RankedPhoneBusiness
		 ,mytarget.Source_PhoneFax					=mysource.RankedPhoneFax
		 ,mytarget.Source_Title						=mysource.RankedTitle
		 ,myTarget.[RepName]						=mysource.[RepName]
		 ,myTarget.[RepEmail]						=mysource.[RepEmail]
		 ,myTarget.[Repphone]						=mysource.[Repphone]
		 ,myTarget.AccountID						=mysource.AccountID
		 ,myTarget.ContactID						=mysource.ContactID
		 ,myTarget.DateCreated						=mysource.DateCreated
		 ,myTarget.DateModified						=mysource.DateModified
		 ,myTarget.[BirthMonth]					=mySource.[BirthMonth]
		 ,myTarget.[BirthYear]						=mySource.[BirthYear]
		 ,myTarget.[RepGroupSales]				=mySource.[RepGroupSales]
		 ,myTarget.[SharePartnerFlag]				=mySource.[SharePartnerFlag]
	--	 ,myTarget.[STM Flag]						=mySource.[STM Flag]
		 ,myTarget.[BrokerFlag]					=mySource.[BrokerFlag]
		 ,myTarget.[GroupLeaderFlag]				=mySource.[GroupLeaderFlag]
		 ,myTarget.[SFDCLeadScore]				=mySource.[SFDCLeadScore]
		 ,myTarget.Source							=mySource.Source
		 ,myTarget.UnsubscribedWithRecentEngagement	=mySource.UnsubscribedWithRecentEngagement
		 ,myTarget.[LastEngagementDate]			=mySource.[LastEngagementDate]
		 ,myTarget.[LastEngagementType]			=mySource.[LastEngagementType]
		 ,myTarget.[AccountTypeDescription]		=mySource.[AccountTypeDescription]
		 ,mytarget.ETL__CreatedDate			        = GETDATE()
		 ,mytarget.ETL_DeltaHashKey			        = mySource.ETL_DeltaHashKey

WHEN NOT MATCHED THEN
INSERT (
        emailprimary
        ,SSB_CRMSYSTEM_CONTACT_ID
		,SSB_CRMSYSTEM_ACCT_ID
		,ArchticsID
        ,Comp_FirstName
        ,Comp_MiddleName
        ,Comp_LastName
        ,Comp_suffix
        ,Comp_Address1
        ,Comp_Address2
        ,Comp_address3
        ,Comp_address4
		,Comp_Addressprimarycity
        ,Comp_addressprimarystate
		,Comp_addressprimaryzip
        ,Comp_addressprimarycountry
		,Comp_birthday
        ,Comp_PhonePrimary
        ,Comp_PhoneHome
        ,Comp_PhoneCell
		,Comp_PhoneBusiness
        ,Comp_PhoneFax
		,Comp_Title
		,Source_FirstName
		,Source_MiddleName
		,Source_LastName
		,Source_Suffix
		,Source_Address1
		,Source_Address2
		,Source_address3
		,Source_address4
		,Source_Addressprimarycity
		,Source_Addressprimarystate
		,Source_Addressprimaryzip
		,Source_Addressprimarycountry
		,Source_Birthday
		,Source_PhonePrimary
		,Source_PhoneHome
		,Source_PhoneCell
		,Source_PhoneBusiness
		,Source_PhoneFax
		,Source_Title
		,RepName 
		,RepEmail
		,RepPhone
		,AccountID
		,ContactID
		,DateCreated
		,DateModified
		,BirthMonth
		,BirthYear
		,RepGroupSales
		,SharePartnerFlag
	--	,[STM Flag]
		,BrokerFlag
		,GroupLeaderFlag
		,SFDCLeadScore
		,Source
		,UnsubscribedWithRecentEngagement
		,LastEngagementDate
		,LastEngagementType
		,AccountTypeDescription
		,ETL__CreatedDate
	    ,ETL_DeltaHashKey

		
		 )
VALUES (	 
              mysource.emailprimary
             , mysource.SSB_CRMSYSTEM_CONTACT_ID
			 , mysource.SSB_CRMSYSTEM_ACCT_ID
			 , mysource.ArchticsID
             , mysource.FirstName
             , mysource.MiddleName
             , mysource.LastName
             , mysource.suffix
             , mysource.Address1
             , mysource.Address2
             , mysource.address3
             , mysource.address4
			 , mysource.Addressprimarycity
             , mysource.addressprimarystate
			 , mySource.addressprimaryzip
             , mysource.addressprimarycountry
			 , mysource.birthday
             , mysource.PhonePrimary
             , mysource.PhoneHome
             , mysource.PhoneCell
			 , mysource.PhoneBusiness
             , mysource.PhoneFax
			 , mysource.Title
			 , mysource.RankedFirstName
			 , mysource.RankedMiddleName
			 , mysource.RankedLastName
			 , mysource.RankedSuffix
			 , mysource.RankedAddress1
			 , mysource.RankedAddress2
			 , mysource.rankedaddress3
			 , mysource.rankedaddress4
			 , mysource.RankedAddressprimarycity
			 , mysource.RankedAddressprimarystate
			 , mysource.RankedAddressprimaryzip
			 , mysource.RankedAddressprimarycountry
			 , mysource.RankedBirthday
			 , mysource.RankedPhonePrimary
			 , mysource.RankedPhoneHome
			 , mysource.RankedPhoneCell
			 , mysource.RankedPhoneBusiness
			 , mysource.RankedPhoneFax
			 , mysource.RankedTitle
             , mysource.RepName 
             , mysource.RepEmail
             , mysource.RepPhone
             , mysource.AccountID
             , mysource.ContactID
             , mysource.DateCreated
             , mysource.DateModified
			 , mySource.BirthMonth
			 , mySource.BirthYear
			 , mySource.RepGroupSales
			 , mySource.SharePartnerFlag
	--		 , mySource.[STM Flag]
			 , mySource.BrokerFlag
			 , mySource.GroupLeaderFlag
			 , mySource.SFDCLeadScore
			 , mySource.Source
			 , mysource.UnsubscribedWithRecentEngagement
			 , mySource.LastEngagementDate
			 , mySource.LastEngagementType
			 , mySource.AccountTypeDescription
			 ,GETDATE()
	         ,mySource.ETL_DeltaHashKey
			 );


	END	
		

	
GO
