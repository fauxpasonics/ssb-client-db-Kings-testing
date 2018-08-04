SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





CREATE PROCEDURE [etl].[Load_ods_EloquaCustom_EmailGroupMembers]
(
	@BatchId INT = 0,
	@Options NVARCHAR(MAX) = NULL
)
AS 

BEGIN
/**************************************Comments***************************************
**************************************************************************************
Mod #:  1
Name:     SSBCLOUD\dhorstman
Date:     03/10/2016
Comments: Initial creation
*************************************************************************************/

DECLARE @RunTime DATETIME = GETDATE()

DECLARE @ExecutionId uniqueidentifier = newid();
DECLARE @ProcedureName NVARCHAR(255) = OBJECT_SCHEMA_NAME(@@PROCID) + '.' + OBJECT_NAME(@@PROCID);
DECLARE @SrcRowCount INT = ISNULL((SELECT CONVERT(VARCHAR, COUNT(*)) FROM src.EloquaCustom_EmailGroupMembers),'0');	
DECLARE @SrcDataSize NVARCHAR(255) = '0'

BEGIN TRY 

PRINT 'Execution Id: ' + CONVERT(NVARCHAR(100),@ExecutionId)

SELECT CAST(NULL AS BINARY(32)) ETL_DeltaHashKey, EmailGroup, ContactID, EmailAddress, TSSC_TempField25, TSSC_TempField2GroupDate, PURLName, SFDC_OpportunityID, TSSC_TempField04_1127_STMPurchaserName, TSSC_TempField10_1127_Name, FirstName, LastName, Company, Archtics_AccountID, BusinessPhone, DayPhone, Zip_or_PostalCode, City, Address1, Address2, Address3, Salesperson, BirthDate, BirthMonth, Interest_Kings, Interest_OtherSportingEvents, Interest_Concerts, Interest_FamilyShows, PURLName_MSETotalAccesscom, TotalAccessMember, LastWebsiteVisit, DateCreated, AddDate, CustomerStatus, FavoritePlayer, State_or_Province, Title, Country, FavoriteMatchUp1, FavoriteMatchUp2, zzSFDCAccountID, zzSFDCContactID, zzSFDCLeadID, SubAR, [TSSC_TempField53_S&PGame], SAS_RequestTime, NewCCKReps, TemporarySegment, TSSC_TempField5_1127_NumberOfBobbleheads, FirstAndLastName, PURLName_KingsTicketSavecom, AccountType, RenewalPURLLogin, RenewalPURLID, TSSC_TempField_KNXVoucher, SourceDescription, TSSC_TempField_INDV1, TSSC_TempField18_BobbleSelection, TSSC_TempField_INDV2, TSSC_TempField19, TSSC_TempField24_CorpLink, SFDC_Kingscom_ActivityFlag, SFDC_ESCcom_ActivityFlag, SFDC_Last7DayActivityFlag, EngagementStatus, STH_Tracking, FEP_Time, NumberOfTickets, PlanType, TrackingNumber
INTO #SrcData
FROM (
	SELECT EmailGroup, ContactID, EmailAddress, TSSC_TempField25, TSSC_TempField2GroupDate, PURLName, SFDC_OpportunityID, TSSC_TempField04_1127_STMPurchaserName, TSSC_TempField10_1127_Name, FirstName, LastName, Company, Archtics_AccountID, BusinessPhone, DayPhone, Zip_or_PostalCode, City, Address1, Address2, Address3, Salesperson, BirthDate, BirthMonth, Interest_Kings, Interest_OtherSportingEvents, Interest_Concerts, Interest_FamilyShows, PURLName_MSETotalAccesscom, TotalAccessMember, LastWebsiteVisit, DateCreated, AddDate, CustomerStatus, FavoritePlayer, State_or_Province, Title, Country, FavoriteMatchUp1, FavoriteMatchUp2, zzSFDCAccountID, zzSFDCContactID, zzSFDCLeadID, SubAR, [TSSC_TempField53_S&PGame], SAS_RequestTime, NewCCKReps, TemporarySegment, TSSC_TempField5_1127_NumberOfBobbleheads, FirstAndLastName, PURLName_KingsTicketSavecom, AccountType, RenewalPURLLogin, RenewalPURLID, TSSC_TempField_KNXVoucher, SourceDescription, TSSC_TempField_INDV1, TSSC_TempField18_BobbleSelection, TSSC_TempField_INDV2, TSSC_TempField19, TSSC_TempField24_CorpLink, SFDC_Kingscom_ActivityFlag, SFDC_ESCcom_ActivityFlag, SFDC_Last7DayActivityFlag, EngagementStatus, STH_Tracking, FEP_Time, NumberOfTickets, PlanType, TrackingNumber
		, ROW_NUMBER() OVER(PARTITION BY ContactId, EmailGroup ORDER BY ETL_ID) RowRank
	FROM src.EloquaCustom_EmailGroupMembers
) a
WHERE RowRank = 1


UPDATE #SrcData
SET ETL_DeltaHashKey = HASHBYTES('sha2_256', ISNULL(RTRIM(AccountType),'DBNULL_TEXT') + ISNULL(RTRIM(AddDate),'DBNULL_TEXT') + ISNULL(RTRIM(Address1),'DBNULL_TEXT') + ISNULL(RTRIM(Address2),'DBNULL_TEXT') + ISNULL(RTRIM(Address3),'DBNULL_TEXT') + ISNULL(RTRIM(Archtics_AccountID),'DBNULL_TEXT') + ISNULL(RTRIM(BirthDate),'DBNULL_TEXT') + ISNULL(RTRIM(BirthMonth),'DBNULL_TEXT') + ISNULL(RTRIM(BusinessPhone),'DBNULL_TEXT') + ISNULL(RTRIM(City),'DBNULL_TEXT') + ISNULL(RTRIM(Company),'DBNULL_TEXT') + ISNULL(RTRIM(ContactID),'DBNULL_TEXT') + ISNULL(RTRIM(Country),'DBNULL_TEXT') + ISNULL(RTRIM(CustomerStatus),'DBNULL_TEXT') + ISNULL(RTRIM(DateCreated),'DBNULL_TEXT') + ISNULL(RTRIM(DayPhone),'DBNULL_TEXT') + ISNULL(RTRIM(EmailAddress),'DBNULL_TEXT') + ISNULL(RTRIM(EmailGroup),'DBNULL_TEXT') + ISNULL(RTRIM(EngagementStatus),'DBNULL_TEXT') + ISNULL(RTRIM(FavoriteMatchUp1),'DBNULL_TEXT') + ISNULL(RTRIM(FavoriteMatchUp2),'DBNULL_TEXT') + ISNULL(RTRIM(FavoritePlayer),'DBNULL_TEXT') + ISNULL(RTRIM(FEP_Time),'DBNULL_TEXT') + ISNULL(RTRIM(FirstAndLastName),'DBNULL_TEXT') + ISNULL(RTRIM(FirstName),'DBNULL_TEXT') + ISNULL(RTRIM(Interest_Concerts),'DBNULL_TEXT') + ISNULL(RTRIM(Interest_FamilyShows),'DBNULL_TEXT') + ISNULL(RTRIM(Interest_Kings),'DBNULL_TEXT') + ISNULL(RTRIM(Interest_OtherSportingEvents),'DBNULL_TEXT') + ISNULL(RTRIM(LastName),'DBNULL_TEXT') + ISNULL(RTRIM(LastWebsiteVisit),'DBNULL_TEXT') + ISNULL(RTRIM(NewCCKReps),'DBNULL_TEXT') + ISNULL(RTRIM(NumberOfTickets),'DBNULL_TEXT') + ISNULL(RTRIM(PlanType),'DBNULL_TEXT') + ISNULL(RTRIM(PURLName),'DBNULL_TEXT') + ISNULL(RTRIM(PURLName_KingsTicketSavecom),'DBNULL_TEXT') + ISNULL(RTRIM(PURLName_MSETotalAccesscom),'DBNULL_TEXT') + ISNULL(RTRIM(RenewalPURLID),'DBNULL_TEXT') + ISNULL(RTRIM(RenewalPURLLogin),'DBNULL_TEXT') + ISNULL(RTRIM(Salesperson),'DBNULL_TEXT') + ISNULL(RTRIM(SAS_RequestTime),'DBNULL_TEXT') + ISNULL(RTRIM(SFDC_ESCcom_ActivityFlag),'DBNULL_TEXT') + ISNULL(RTRIM(SFDC_Kingscom_ActivityFlag),'DBNULL_TEXT') + ISNULL(RTRIM(SFDC_Last7DayActivityFlag),'DBNULL_TEXT') + ISNULL(RTRIM(SFDC_OpportunityID),'DBNULL_TEXT') + ISNULL(RTRIM(SourceDescription),'DBNULL_TEXT') + ISNULL(RTRIM(State_or_Province),'DBNULL_TEXT') + ISNULL(RTRIM(STH_Tracking),'DBNULL_TEXT') + ISNULL(RTRIM(SubAR),'DBNULL_TEXT') + ISNULL(RTRIM(TemporarySegment),'DBNULL_TEXT') + ISNULL(RTRIM(Title),'DBNULL_TEXT') + ISNULL(RTRIM(TotalAccessMember),'DBNULL_TEXT') + ISNULL(RTRIM(TrackingNumber),'DBNULL_TEXT') + ISNULL(RTRIM(TSSC_TempField_INDV1),'DBNULL_TEXT') + ISNULL(RTRIM(TSSC_TempField_INDV2),'DBNULL_TEXT') + ISNULL(RTRIM(TSSC_TempField_KNXVoucher),'DBNULL_TEXT') + ISNULL(RTRIM(TSSC_TempField04_1127_STMPurchaserName),'DBNULL_TEXT') + ISNULL(RTRIM(TSSC_TempField10_1127_Name),'DBNULL_TEXT') + ISNULL(RTRIM(TSSC_TempField18_BobbleSelection),'DBNULL_TEXT') + ISNULL(RTRIM(TSSC_TempField19),'DBNULL_TEXT') + ISNULL(RTRIM(TSSC_TempField24_CorpLink),'DBNULL_TEXT') + ISNULL(RTRIM(TSSC_TempField25),'DBNULL_TEXT') + ISNULL(RTRIM(TSSC_TempField2GroupDate),'DBNULL_TEXT') + ISNULL(RTRIM(TSSC_TempField5_1127_NumberOfBobbleheads),'DBNULL_TEXT') + ISNULL(RTRIM([TSSC_TempField53_S&PGame]),'DBNULL_TEXT') + ISNULL(RTRIM(Zip_or_PostalCode),'DBNULL_TEXT') + ISNULL(RTRIM(zzSFDCAccountID),'DBNULL_TEXT') + ISNULL(RTRIM(zzSFDCContactID),'DBNULL_TEXT') + ISNULL(RTRIM(zzSFDCLeadID),'DBNULL_TEXT'))


CREATE NONCLUSTERED INDEX IDX_Load_Key ON #SrcData (ContactId, EmailGroup)
CREATE NONCLUSTERED INDEX IDX_ETL_DeltaHashKey ON #SrcData (ETL_DeltaHashKey)


MERGE ods.EloquaCustom_EmailGroupMembers AS myTarget
USING (
	SELECT * FROM #SrcData
) AS mySource
ON myTarget.ContactId = mySource.ContactId
AND myTarget.EmailGroup = mySource.EmailGroup

WHEN MATCHED AND (
     ISNULL(mySource.ETL_DeltaHashKey,-1) <> ISNULL(myTarget.ETL_DeltaHashKey, -1)
	 OR myTarget.ETL_IsDeleted = 1
)
THEN UPDATE SET
      myTarget.[ETL_UpdatedDate] = @RunTime
	 ,myTarget.ETL_IsDeleted = 0
	 ,myTarget.ETL_DeletedDate = NULL
     ,myTarget.[ETL_DeltaHashKey] = mySource.[ETL_DeltaHashKey]
     ,myTarget.[EmailAddress] = mySource.[EmailAddress]
     ,myTarget.[TSSC_TempField25] = mySource.[TSSC_TempField25]
     ,myTarget.[TSSC_TempField2GroupDate] = mySource.[TSSC_TempField2GroupDate]
     ,myTarget.[PURLName] = mySource.[PURLName]
     ,myTarget.[SFDC_OpportunityID] = mySource.[SFDC_OpportunityID]
     ,myTarget.[TSSC_TempField04_1127_STMPurchaserName] = mySource.[TSSC_TempField04_1127_STMPurchaserName]
     ,myTarget.[TSSC_TempField10_1127_Name] = mySource.[TSSC_TempField10_1127_Name]
     ,myTarget.[FirstName] = mySource.[FirstName]
     ,myTarget.[LastName] = mySource.[LastName]
     ,myTarget.[Company] = mySource.[Company]
     ,myTarget.[Archtics_AccountID] = mySource.[Archtics_AccountID]
     ,myTarget.[BusinessPhone] = mySource.[BusinessPhone]
     ,myTarget.[DayPhone] = mySource.[DayPhone]
     ,myTarget.[Zip_or_PostalCode] = mySource.[Zip_or_PostalCode]
     ,myTarget.[City] = mySource.[City]
     ,myTarget.[Address1] = mySource.[Address1]
     ,myTarget.[Address2] = mySource.[Address2]
     ,myTarget.[Address3] = mySource.[Address3]
     ,myTarget.[Salesperson] = mySource.[Salesperson]
     ,myTarget.[BirthDate] = mySource.[BirthDate]
     ,myTarget.[BirthMonth] = mySource.[BirthMonth]
     ,myTarget.[Interest_Kings] = mySource.[Interest_Kings]
     ,myTarget.[Interest_OtherSportingEvents] = mySource.[Interest_OtherSportingEvents]
     ,myTarget.[Interest_Concerts] = mySource.[Interest_Concerts]
     ,myTarget.[Interest_FamilyShows] = mySource.[Interest_FamilyShows]
     ,myTarget.[PURLName_MSETotalAccesscom] = mySource.[PURLName_MSETotalAccesscom]
     ,myTarget.[TotalAccessMember] = mySource.[TotalAccessMember]
     ,myTarget.[LastWebsiteVisit] = mySource.[LastWebsiteVisit]
     ,myTarget.[DateCreated] = mySource.[DateCreated]
     ,myTarget.[AddDate] = mySource.[AddDate]
     ,myTarget.[CustomerStatus] = mySource.[CustomerStatus]
     ,myTarget.[FavoritePlayer] = mySource.[FavoritePlayer]
     ,myTarget.[State_or_Province] = mySource.[State_or_Province]
     ,myTarget.[Title] = mySource.[Title]
     ,myTarget.[Country] = mySource.[Country]
     ,myTarget.[FavoriteMatchUp1] = mySource.[FavoriteMatchUp1]
     ,myTarget.[FavoriteMatchUp2] = mySource.[FavoriteMatchUp2]
     ,myTarget.[zzSFDCAccountID] = mySource.[zzSFDCAccountID]
     ,myTarget.[zzSFDCContactID] = mySource.[zzSFDCContactID]
     ,myTarget.[zzSFDCLeadID] = mySource.[zzSFDCLeadID]
     ,myTarget.[SubAR] = mySource.[SubAR]
     ,myTarget.[TSSC_TempField53_S&PGame] = mySource.[TSSC_TempField53_S&PGame]
     ,myTarget.[SAS_RequestTime] = mySource.[SAS_RequestTime]
     ,myTarget.[NewCCKReps] = mySource.[NewCCKReps]
     ,myTarget.[TemporarySegment] = mySource.[TemporarySegment]
     ,myTarget.[TSSC_TempField5_1127_NumberOfBobbleheads] = mySource.[TSSC_TempField5_1127_NumberOfBobbleheads]
     ,myTarget.[FirstAndLastName] = mySource.[FirstAndLastName]
     ,myTarget.[PURLName_KingsTicketSavecom] = mySource.[PURLName_KingsTicketSavecom]
     ,myTarget.[AccountType] = mySource.[AccountType]
     ,myTarget.[RenewalPURLLogin] = mySource.[RenewalPURLLogin]
     ,myTarget.[RenewalPURLID] = mySource.[RenewalPURLID]
     ,myTarget.[TSSC_TempField_KNXVoucher] = mySource.[TSSC_TempField_KNXVoucher]
     ,myTarget.[SourceDescription] = mySource.[SourceDescription]
     ,myTarget.[TSSC_TempField_INDV1] = mySource.[TSSC_TempField_INDV1]
     ,myTarget.[TSSC_TempField18_BobbleSelection] = mySource.[TSSC_TempField18_BobbleSelection]
     ,myTarget.[TSSC_TempField_INDV2] = mySource.[TSSC_TempField_INDV2]
     ,myTarget.[TSSC_TempField19] = mySource.[TSSC_TempField19]
     ,myTarget.[TSSC_TempField24_CorpLink] = mySource.[TSSC_TempField24_CorpLink]
     ,myTarget.[SFDC_Kingscom_ActivityFlag] = mySource.[SFDC_Kingscom_ActivityFlag]
     ,myTarget.[SFDC_ESCcom_ActivityFlag] = mySource.[SFDC_ESCcom_ActivityFlag]
     ,myTarget.[SFDC_Last7DayActivityFlag] = mySource.[SFDC_Last7DayActivityFlag]
     ,myTarget.[EngagementStatus] = mySource.[EngagementStatus]
     ,myTarget.[STH_Tracking] = mySource.[STH_Tracking]
     ,myTarget.[FEP_Time] = mySource.[FEP_Time]
     ,myTarget.[NumberOfTickets] = mySource.[NumberOfTickets]
	 ,myTarget.[PlanType] = mySource.[PlanType]
	 ,myTarget.[TrackingNumber] = mySource.[TrackingNumber]


WHEN NOT MATCHED BY SOURCE
AND myTarget.ETL_IsDeleted = 0
THEN UPDATE SET
		myTarget.[ETL_IsDeleted] = 1
		,myTarget.[ETL_DeletedDate] = @RunTime

    
WHEN NOT MATCHED BY TARGET
THEN INSERT
     ([ETL_CreatedDate]
     ,[ETL_UpdatedDate]
     ,[ETL_IsDeleted]
     ,[ETL_DeletedDate]
     ,[ETL_DeltaHashKey]
	 ,[EmailGroup]
     ,[ContactID]
     ,[EmailAddress]
     ,[TSSC_TempField25]
     ,[TSSC_TempField2GroupDate]
     ,[PURLName]
     ,[SFDC_OpportunityID]
     ,[TSSC_TempField04_1127_STMPurchaserName]
     ,[TSSC_TempField10_1127_Name]
     ,[FirstName]
     ,[LastName]
     ,[Company]
     ,[Archtics_AccountID]
     ,[BusinessPhone]
     ,[DayPhone]
     ,[Zip_or_PostalCode]
     ,[City]
     ,[Address1]
     ,[Address2]
     ,[Address3]
     ,[Salesperson]
     ,[BirthDate]
     ,[BirthMonth]
     ,[Interest_Kings]
     ,[Interest_OtherSportingEvents]
     ,[Interest_Concerts]
     ,[Interest_FamilyShows]
     ,[PURLName_MSETotalAccesscom]
     ,[TotalAccessMember]
     ,[LastWebsiteVisit]
     ,[DateCreated]
     ,[AddDate]
     ,[CustomerStatus]
     ,[FavoritePlayer]
     ,[State_or_Province]
     ,[Title]
     ,[Country]
     ,[FavoriteMatchUp1]
     ,[FavoriteMatchUp2]
     ,[zzSFDCAccountID]
     ,[zzSFDCContactID]
     ,[zzSFDCLeadID]
     ,[SubAR]
     ,[TSSC_TempField53_S&PGame]
     ,[SAS_RequestTime]
     ,[NewCCKReps]
     ,[TemporarySegment]
     ,[TSSC_TempField5_1127_NumberOfBobbleheads]
     ,[FirstAndLastName]
     ,[PURLName_KingsTicketSavecom]
     ,[AccountType]
     ,[RenewalPURLLogin]
     ,[RenewalPURLID]
     ,[TSSC_TempField_KNXVoucher]
     ,[SourceDescription]
     ,[TSSC_TempField_INDV1]
     ,[TSSC_TempField18_BobbleSelection]
     ,[TSSC_TempField_INDV2]
     ,[TSSC_TempField19]
     ,[TSSC_TempField24_CorpLink]
     ,[SFDC_Kingscom_ActivityFlag]
     ,[SFDC_ESCcom_ActivityFlag]
     ,[SFDC_Last7DayActivityFlag]
     ,[EngagementStatus]
     ,[STH_Tracking]
     ,[FEP_Time]
     ,[NumberOfTickets]
	 ,[PlanType]
	 ,[TrackingNumber]
     )
VALUES
     (@RunTime	--ETL_CreatedDate
     ,@RunTime	--ETL_UpdateddDate
     ,0			--ETL_IsDeleted
     ,NULL		--ETL_DeletedDate
     ,mySource.[ETL_DeltaHashKey]
	 ,mySource.[EmailGroup]
     ,mySource.[ContactID]
     ,mySource.[EmailAddress]
     ,mySource.[TSSC_TempField25]
     ,mySource.[TSSC_TempField2GroupDate]
     ,mySource.[PURLName]
     ,mySource.[SFDC_OpportunityID]
     ,mySource.[TSSC_TempField04_1127_STMPurchaserName]
     ,mySource.[TSSC_TempField10_1127_Name]
     ,mySource.[FirstName]
     ,mySource.[LastName]
     ,mySource.[Company]
     ,mySource.[Archtics_AccountID]
     ,mySource.[BusinessPhone]
     ,mySource.[DayPhone]
     ,mySource.[Zip_or_PostalCode]
     ,mySource.[City]
     ,mySource.[Address1]
     ,mySource.[Address2]
     ,mySource.[Address3]
     ,mySource.[Salesperson]
     ,mySource.[BirthDate]
     ,mySource.[BirthMonth]
     ,mySource.[Interest_Kings]
     ,mySource.[Interest_OtherSportingEvents]
     ,mySource.[Interest_Concerts]
     ,mySource.[Interest_FamilyShows]
     ,mySource.[PURLName_MSETotalAccesscom]
     ,mySource.[TotalAccessMember]
     ,mySource.[LastWebsiteVisit]
     ,mySource.[DateCreated]
     ,mySource.[AddDate]
     ,mySource.[CustomerStatus]
     ,mySource.[FavoritePlayer]
     ,mySource.[State_or_Province]
     ,mySource.[Title]
     ,mySource.[Country]
     ,mySource.[FavoriteMatchUp1]
     ,mySource.[FavoriteMatchUp2]
     ,mySource.[zzSFDCAccountID]
     ,mySource.[zzSFDCContactID]
     ,mySource.[zzSFDCLeadID]
     ,mySource.[SubAR]
     ,mySource.[TSSC_TempField53_S&PGame]
     ,mySource.[SAS_RequestTime]
     ,mySource.[NewCCKReps]
     ,mySource.[TemporarySegment]
     ,mySource.[TSSC_TempField5_1127_NumberOfBobbleheads]
     ,mySource.[FirstAndLastName]
     ,mySource.[PURLName_KingsTicketSavecom]
     ,mySource.[AccountType]
     ,mySource.[RenewalPURLLogin]
     ,mySource.[RenewalPURLID]
     ,mySource.[TSSC_TempField_KNXVoucher]
     ,mySource.[SourceDescription]
     ,mySource.[TSSC_TempField_INDV1]
     ,mySource.[TSSC_TempField18_BobbleSelection]
     ,mySource.[TSSC_TempField_INDV2]
     ,mySource.[TSSC_TempField19]
     ,mySource.[TSSC_TempField24_CorpLink]
     ,mySource.[SFDC_Kingscom_ActivityFlag]
     ,mySource.[SFDC_ESCcom_ActivityFlag]
     ,mySource.[SFDC_Last7DayActivityFlag]
     ,mySource.[EngagementStatus]
     ,mySource.[STH_Tracking]
     ,mySource.[FEP_Time]
     ,mySource.[NumberOfTickets]
	 ,mySource.[PlanType]
	 ,mySource.[TrackingNumber]
     )
;



DECLARE @MergeInsertRowCount INT = ISNULL((SELECT CONVERT(VARCHAR, COUNT(*)) FROM ods.EloquaCustom_EmailGroupMembers WHERE ETL_CreatedDate >= @RunTime AND ETL_UpdatedDate = ETL_CreatedDate),'0');	
DECLARE @MergeUpdateRowCount INT = ISNULL((SELECT CONVERT(VARCHAR, COUNT(*)) FROM ods.EloquaCustom_EmailGroupMembers WHERE ETL_UpdatedDate >= @RunTime AND ETL_UpdatedDate > ETL_CreatedDate),'0');	


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
