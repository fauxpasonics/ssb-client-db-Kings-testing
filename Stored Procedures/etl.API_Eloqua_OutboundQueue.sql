SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO










--EXEC ro.ETL_Eloqua_Contacts_outbound

CREATE PROCEDURE [etl].[API_Eloqua_OutboundQueue] AS 



-- This prcoess needs to be run after the data is ynced to azure.  Ian's outbound process will run at any point after the sync and queue load is complete 

IF OBJECT_ID('tempdb..#Working') IS NOT NULL
	DROP TABLE #working
		
	CREATE TABLE #working --TABLE	 
		(SSID	NVARCHAR(250)
		,GroupID INT
		,QueueID INT )


--IF OBJECT_ID('tempdb..#Workinginsert') IS NOT NULL
--	DROP TABLE #workinginsert
		
--	CREATE TABLE #workinginsert --TABLE	 
--		(SSID	NVARCHAR(250)
--		,GroupID INT
--		,QueueID INT )



IF OBJECT_ID('tempdb..#tempQueue') IS NOT NULL
	DROP TABLE #tempQueue
		
	CREATE TABLE #tempQueue--TABLE	 
		([APIName] [VARCHAR](100) NOT NULL,
		[APIEntity] [VARCHAR](100) NOT NULL,
		[EndpointName] [VARCHAR](100) NOT NULL,
		[SourceID] [VARCHAR](100) NOT NULL,
		[MemberID] [VARCHAR](100) NOT NULL,
		[Json_Payload] [NVARCHAR](MAX) null,
		[httpAction] [NVARCHAR](100) NOT NULL,
		[Description] [VARCHAR](MAX) NULL
		,GroupID INT
		,QueueInsertVal UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL)

--can change ceiling count to 1 if it needs to be sent over in single record firm and not bulk
DECLARE @groups INT = (SELECT CEILING(COUNT(1) / 500) FROM   ods.Eloqua_Contacts_Outbound_Merge WHERE etl__createddate  > = GETDATE()  -3 )
--DECLARE @groupsinsert INT = (SELECT CEILING(COUNT(1) /500 ) FROM  [ods].[Eloqua_Contacts_Insert] )
 
INSERT INTO #working
( SSID, GroupID)
SELECT [emailprimary], CASE WHEN @groups = 0 THEN 1 ELSE NTILE(@groups) OVER(ORDER BY ETL__CreatedDate) END groupid FROM  ods.Eloqua_Contacts_Outbound_Merge  WHERE ETL__CreatedDate >= GETDATE() -3

--IF @groupsinsert = 0
--BEGIN

--INSERT INTO #workinginsert
--( SSID, GroupID)
--SELECT [email], '1'  FROM [ods].[Eloqua_Contacts_Insert] --WHERE QueueID IS NULL

--END
--ELSE 
--BEGIN

--INSERT INTO #workinginsert
--( SSID, GroupID)
--SELECT [email],  CASE WHEN @groupsinsert = 0 THEN 1 ELSE NTILE(@groupsinsert)OVER(ORDER BY ETL__CreatedDate) END groupid   FROM [ods].[Eloqua_Contacts_Insert]

--END




--Selects all Eloqua contacts that dont meet criteria for upserts/inserts
IF OBJECT_ID('tempdb..#eloquadeletes') IS NOT NULL
	DROP TABLE #eloquadeletes
SELECT c.id,c.EmailAddress, row_number() OVER(ORDER BY emailprimary) RowNumber
into #eloquadeletes
FROM ods.Eloqua_Contact c
LEFT OUTER JOIN ods.ETL_ActiveEloquacontacts m
ON m.emailprimary = c.EmailAddress
LEFT OUTER JOIN ods.API_OutboundQueue a
ON a.SourceID = c.id AND a.IsCompleted = 1--a.Queue_ProcessDate >= GETDATE() -7
WHERE m.emailprimary IS NULL
AND a.SourceID IS null
AND c.ETL_IsDeleted = 0





--SELECT c.* FROM #eloquadeletes e
--   JOIN ods.Eloqua_Contact c
--   ON c.ID = e.id

--   SELECT * FROM ods.Eloqua_Contact
--   WHERE ETL_IsDeleted = 0


----SELECT COUNT(*) FROM ods.ETL_ActiveEloquacontacts

DECLARE @max INT = (SELECT MAX(groupid) FROM #working)
--DECLARE @maxinsert INT = (SELECT MAX(groupid) FROM #workinginsert)
DECLARE @count INT = 1
--DECLARE @countinsert INT = 1
DECLARE @loadcount INT = (SELECT COUNT(*) FROM ods.Eloqua_Contacts_Outbound_Merge WHERE ETL__CreatedDate >= GETDATE() -3 ) 
--DECLARE @loadcountinsert INT = (SELECT COUNT(*) FROM [ods].[Eloqua_Contacts_Insert]) 




--INSERT INTO #tempQueue (APIName,APIEntity,EndpointName,SourceID,MemberID, Json_Payload,httpAction,[Description], GroupID)
--SELECT 'Eloqua' APIName, 'Delete' APIEntity, 'data/contact'EndpointName,a.id SourceID ,'Delete' MemberID, '' Json_payload ,'Delete' httpAction ,'Deletes of Contacts in Eloqua' [Description] ,'1000000' GroupID
-- FROM   #eloquadeletes a





WHILE @count < @max
 AND @loadcount >0
begin

INSERT INTO #tempQueue (APIName,APIEntity,EndpointName,SourceID,MemberID, Json_Payload,httpAction,[Description], GroupID)
--upserts
SELECT 'api' APIName, 'Upsert' APIEntity, 'contacts/imports/281/data'EndpointName, 'Bulk' SourceID ,'Bulk' MemberID,
( SELECT   a.emailprimary								AS 	[C_EmailAddress]
         , a.SSB_CRMSYSTEM_CONTACT_ID					AS 	[C_SSB_CRMSYSTEM_CONTACT_ID11]
         , a.SSB_CRMSYSTEM_ACCT_ID						AS 	[C_SSB_CRMSYSTEM_ACCT_ID1]
         , a.ArchticsID									AS 	[C_Archtics_Account_ID1]
         , a.Comp_FirstName								AS 	[C_Comp_FirstName1]
         , a.Comp_MiddleName							AS 	[C_Comp_MiddleName1]
         , a.Comp_LastName								AS 	[C_Comp_LastName1]
         , a.Comp_Suffix								AS 	[C_Comp_Suffix1]
         , a.Comp_Address1								AS 	[C_Comp_Address11]
         , a.Comp_Address2								AS 	[C_Comp_Address21]
         , a.Comp_address3								AS 	[C_Comp_Address31]
         , a.Comp_address4								AS 	[C_Comp_Address41]
         , a.Comp_Addressprimarycity					AS 	[C_Comp_Addressprimarycity1]
         , a.Comp_addressprimarystate					AS 	[C_Comp_addressprimarystate1]
         , a.Comp_addressprimaryzip						AS 	[C_Comp_addressprimaryzip1]
         , a.Comp_addressprimarycountry					AS 	[C_Comp_addressprimarycountry1]
         , a.Comp_Birthday								AS 	[C_Comp_Birthday1]
         , a.Comp_PhonePrimary							AS 	[C_Comp_PhonePrimary1]
         , a.Comp_PhoneHome								AS 	[C_Comp_PhoneHome1]
         , a.Comp_PhoneCell								AS 	[C_Comp_PhoneCell1]
         , a.Comp_PhoneBusiness							AS 	[C_Comp_PhoneBusiness1]
         , a.Comp_PhoneFax								AS 	[C_Comp_PhoneFax1]
         , a.Comp_Title									AS 	[C_Comp_Title1]
         , a.AccountID									AS 	[C_SFDCAccountID]
         , a.ContactID									AS 	[C_SFDCContactID]
         , a.DateCreated								AS 	[C_DateCreated]
         , a.DateModified								AS 	[C_DateModified]
         , a.[Source]									AS 	[C_Lead_Source___Original1]
         , a.Source_FirstName							AS 	[C_FirstName]
         , a.Source_MiddleName							AS 	[C_Middle_Name1]
         , a.Source_LastName							AS 	[C_LastName]
         , a.Source_Suffix								AS 	[C_Suffix1]
         , a.Source_Address1							AS 	[C_Address1]
         , a.Source_Address2							AS 	[C_Address2]
         , a.Source_address3							AS 	[C_Address3]
         , a.Source_address4							AS 	[C_Address41]
         , a.Source_Addressprimarycity					AS 	[C_City]
         , a.Source_Addressprimarystate					AS 	[C_State_Prov]
         , a.Source_Addressprimaryzip					AS 	[C_Zip_Postal]
         , a.Source_Addressprimarycountry				AS 	[C_Country]
         , a.Source_Birthday							AS 	[C_Birth_Date1]
         , a.Source_PhonePrimary						AS 	[C_Day_Phone1]
         , a.Source_PhoneHome							AS 	[C_Evening_Phone1]
         , a.Source_PhoneCell							AS 	[C_MobilePhone]
         , a.Source_PhoneBusiness						AS 	[C_BusPhone]
         , a.Source_PhoneFax							AS 	[C_Fax]
         , a.Source_Title								AS 	[C_Title]
         , a.ETL_DeltaHashKey							AS 	[C_ETL_DeltaHashKey1]
         , a.ETL__CreatedDate							AS 	[C_ETL__CreatedDate1]
         ,a.UnsubscribedWithRecentEngagement			AS 	[C_UnsubscribedWithRecentEngagement1]
         , a.RepName									AS 	[C_Salesperson]
         , a.RepEmail									AS 	[C_Rep___Ticket_Services__email_1]
         , a.RepPhone									AS 	[C_Rep___Ticket_Services__phone_1]
         , a.BirthMonth									AS 	[C_Birth_Month1]
         , a.BirthYear									AS 	[C_Birthday___This_Year13]
         , a.SharePartnerFlag							AS 	[C_Sharepartner_Flag1]
         , a.RepGroupSales								AS 	[C_Rep___Group_Sales11]
         , a.BrokerFlag									AS 	[C_Broker_Flag1]
         , a.GroupLeaderFlag							AS 	[C_Group_Leader_Flag1]
         , a.SFDCLeadScore								AS 	[C_SFDC_Lead_Score1]
         , a.LastEngagementDate							AS 	[C_Last_Engagement_Date1]
         , a.LastEngagementType							AS 	[C_Last_Engagement_Type1]
         , a.AccountTypeDescription						AS 	[C_Account_Type_Description1]

 FROM   ods.Eloqua_Contacts_Outbound_Merge  a
 JOIN #working b ON a.[emailprimary] = b.SSID
 WHERE b.GroupID = @count
 and a.ETL__CreatedDate >= (Getdate()-3)

 FOR JSON PATH) AS json_payload
 ,'Upsert' httpAction
  ,'This is a write back to Eloqua' [Description]
  ,@count GroupID 


SET @count = @count +1

END



--WHILE @countinsert <= @maxinsert
--AND @loadcountinsert >0
--BEGIN

--INSERT INTO #tempQueue (APIName,APIEntity,EndpointName,SourceID,MemberID, Json_Payload,httpAction,[Description], GroupID)
------inserts
--SELECT 'Eloqua' APIName, 'Insert' APIEntity, 'contacts/imports/281/data'EndpointName, 'Bulk' SourceID ,'Bulk' MemberID,
--( SELECT   a.email					           AS 	[C_EmailAddress]
--         , a.SSB_CRMSYSTEM_CONTACT_ID			AS 	[C_SSB_CRMSYSTEM_CONTACT_ID11]
--         , a.SSB_CRMSYSTEM_ACCT_ID				AS 	[C_SSB_CRMSYSTEM_ACCT_ID1]
--         , a.ArchticsID							AS 	[C_Archtics_Account_ID1]
--         , a.FirstName							AS 	[C_Comp_FirstName1]
--         , a.MiddleName							AS 	[C_Comp_MiddleName1]
--         , a.LastName							AS 	[C_Comp_LastName1]
--         , a.Suffix								AS 	[C_Comp_Suffix1]
--         , a.Address1							AS 	[C_Comp_Address11]
--         , a.Address2							AS 	[C_Comp_Address21]
--         , a.Address3							AS 	[C_Comp_Address31]
--         , a.address4							AS 	[C_Comp_Address41]
--         , a.Addressprimarycity					AS 	[C_Comp_Addressprimarycity1]
--         , a.addressprimarystate					AS 	[C_Comp_addressprimarystate1]
--         , a.addressprimaryzip					AS 	[C_Comp_addressprimaryzip1]
--         , a.addressprimarycountry				AS 	[C_Comp_addressprimarycountry1]
--         , a.Birthday							AS 	[C_Comp_Birthday1]
--         , a.PhonePrimary						AS 	[C_Comp_PhonePrimary1]
--         , a.PhoneHome							AS 	[C_Comp_PhoneHome1]
--         , a.PhoneCell							AS 	[C_Comp_PhoneCell1]
--         , a.PhoneBusiness						AS 	[C_Comp_PhoneBusiness1]
--         , a.PhoneFax							AS 	[C_Comp_PhoneFax1]
--         , a.Title								AS 	[C_Comp_Title1]
--         , a.AccountID							AS 	[C_SFDCAccountID]
--         , a.ContactID							AS 	[C_SFDCContactID]
--         , a.DateCreated							AS 	[C_DateCreated]
--         , a.DateModified						AS 	[C_DateModified]
--         , a.[Source]							AS 	[C_Lead_Source___Original1]
--         , a.RankedFirstName						AS 	[C_FirstName]
--         , a.RankedMiddleName					AS 	[C_Middle_Name1]
--         , a.RankedLastName						AS 	[C_LastName]
--         , a.RankedSuffix						AS 	[C_Suffix1]
--         , a.RankedAddress1						AS 	[C_Address1]
--         , a.RankedAddress2						AS 	[C_Address2]
--         , a.Rankedaddress3						AS 	[C_Address3]
--         , a.Rankedaddress4						AS 	[C_Address41]
--         , a.RankedAddressprimarycity			AS 	[C_City]
--         , a.RankedAddressprimarystate			AS 	[C_State_Prov]
--         , a.RankedAddressprimaryzip				AS 	[C_Zip_Postal]
--         , a.RankedAddressprimarycountry		AS 	[C_Country]
--         , a.RankedBirthday						AS 	[C_Birth_Date1]
--         , a.RankedPhonePrimary					AS 	[C_Day_Phone1]
--         , a.RankedPhoneHome						AS 	[C_Evening_Phone1]
--         , a.RankedPhoneCell						AS 	[C_MobilePhone]
--         , a.RankedPhoneBusiness					AS 	[C_BusPhone]
--         , a.RankedPhoneFax						AS 	[C_Fax]
--         , a.RankedTitle							AS 	[C_Title]
--         , NULL									AS [C_UnsubscribedWithRecentEngagement1]
--         , a.[Rep NAME]							AS 	[C_Salesperson]
--         , a.[Rep Email]							AS 	[C_Rep___Ticket_Services__email_1]
--         , a.[Rep Phone]							AS 	[C_Rep___Ticket_Services__phone_1]
--         , a.[Birth Month]						AS 	[C_Birth_Month1]
--         , a.[Birth Year]						AS 	[C_Birthday___This_Year13]
--         , a.[Share Partner Flag]				AS 	[C_Sharepartner_Flag1]
--         , a.[Rep - Group Sales]					AS 	[C_Rep___Group_Sales11]
--         , a.[Broker Flag]						AS 	[C_Broker_Flag1]
--         , a.[Group Leader Flag]					AS 	[C_Group_Leader_Flag1]
--         , a.[SFDC Lead Score]					AS 	[C_SFDC_Lead_Score1]
--         , a.[Last Engagement Date]				AS 	[C_Last_Engagement_Date1]
--         , a.[Last Engagement Type]				AS 	[C_Last_Engagement_Type1]
--         , a.[Account Type Description]			AS 	[C_Account_Type_Description1]

--FROM    [ods].[Eloqua_Contacts_Insert] a
--JOIN #workinginsert b ON a.[email] = b.SSID
--WHERE b.GroupID = @countinsert
--AND a.email <>''
-- FOR JSON PATH) AS json_payload
--  ,'Insert' httpAction
--  ,'This is a write back to Eloqua' [Description]
--  ,@countinsert GroupID 





--SET @countinsert = @countinsert +1
--END



INSERT INTO  ods.API_OutboundQueue
	(APIName,
    APIEntity,
    EndpointName,
    SourceID,
    MemberID,
    Json_Payload,
    httpAction,
    [Description]
	)
SELECT 
	APIName,
    APIEntity,
    EndpointName,
    SourceID,
	MemberID,
    Json_Payload,
    httpAction,
    [Description]
FROM #tempQueue


--SELECT QueueID, x.JSON_Array
--FROM ods.API_OutboundQueue
--CROSS APPLY (SELECT item JSON_Array FROM dbo.split(JSON_payload,'{'))x
--WHERE QueueID IN(973177)


--SELECT * FROM ods.API_OutboundQueue
--WHERE IsCompleted = 0


--SELECT CAST(Queue_CreatedOn AS DATE) date, COUNT(*) 
--FROM ods.API_OutboundQueue
--WHERE APIEntity = 'insert'
--GROUP BY CAST(Queue_CreatedOn AS DATE) 
--ORDER BY CAST(Queue_CreatedOn AS DATE)  desc


--SELECT CAST(Queue_CreatedOn AS DATE) date, COUNT(*) 
--FROM ods.API_OutboundQueue
--WHERE APIEntity = 'delete'
--GROUP BY CAST(Queue_CreatedOn AS DATE) 
--ORDER BY CAST(Queue_CreatedOn AS DATE)  DESC

--SELECT CAST(Queue_CreatedOn AS DATE) date, COUNT(*) 
--FROM ods.API_OutboundQueue
--WHERE APIEntity = 'upsert'
--GROUP BY CAST(Queue_CreatedOn AS DATE) 
--ORDER BY CAST(Queue_CreatedOn AS DATE)  desc

--select * from ods.API_OutboundQueue where IsCompleted = 0

GO
