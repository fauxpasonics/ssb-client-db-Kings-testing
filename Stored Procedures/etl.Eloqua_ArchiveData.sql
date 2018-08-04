SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







CREATE PROCEDURE [etl].[Eloqua_ArchiveData]
AS
BEGIN


--	only run this sproc on Sunday
IF (select datepart(WEEKDAY,GETDATE())) <> 1
	GOTO ExitSproc;



declare @ArchiveDate datetime
;

set @ArchiveDate = (select convert(datetime,DATEADD(month,-18,convert(date,GETDATE()))))
;


--	EmailSend	-------------------------------------------------------------------------
select *
into #tmp_ActivityEmailSend
from ods.Eloqua_ActivityEmailSend
where CreatedAt < @ArchiveDate
;

insert archive.Eloqua_ActivityEmailSend (
	ETL_CreatedDate, ETL_UpdatedDate, ETL_IsDeleted, ETL_DeletedDate, ETL_DeltaHashKey
	, ID, Name, CreatedAt, Type, AssetName, AssetId, AssetType, ContactId, EmailName, EmailWebLink
	, EmailRecipientId, SubjectLine, EmailAddress, CampaignId, ETL_ArchiveDate
	)
select ETL_CreatedDate, ETL_UpdatedDate, ETL_IsDeleted, ETL_DeletedDate, ETL_DeltaHashKey
	, ID, Name, CreatedAt, Type, AssetName, AssetId, AssetType, ContactId, EmailName, EmailWebLink
	, EmailRecipientId, SubjectLine, EmailAddress, CampaignId, GETDATE() as ETL_ArchiveDate
from #tmp_ActivityEmailSend
;

delete a
from ods.Eloqua_ActivityEmailSend a
join #tmp_ActivityEmailSend b
on a.ID = B.ID
;

drop table #tmp_ActivityEmailSend
;



--	EmailOpen	-------------------------------------------------------------------------
select *
into #tmp_ActivityEmailOpen
from ods.Eloqua_ActivityEmailOpen
where CreatedAt < @ArchiveDate
;

insert archive.Eloqua_ActivityEmailOpen (
	ETL_CreatedDate, ETL_UpdatedDate, ETL_IsDeleted, ETL_DeletedDate, ETL_DeltaHashKey, ID, Name, CreatedAt, Type, AssetName, AssetId
	, AssetType, ContactId, EmailName, EmailWebLink, EmailRecipientId, IPAddress, SubjectLine, CampaignId, ETL_ArchiveDate
	)
select ETL_CreatedDate, ETL_UpdatedDate, ETL_IsDeleted, ETL_DeletedDate, ETL_DeltaHashKey, ID, Name, CreatedAt, Type, AssetName, AssetId
, AssetType, ContactId, EmailName, EmailWebLink, EmailRecipientId, IPAddress, SubjectLine, CampaignId, GETDATE() as ETL_ArchiveDate
from #tmp_ActivityEmailOpen
;

delete a
from ods.Eloqua_ActivityEmailOpen a
join #tmp_ActivityEmailOpen b
on a.ID = B.ID
;

drop table #tmp_ActivityEmailOpen
;



--	PageView	-------------------------------------------------------------------------
select *
into #tmp_ActivityPageView
from ods.Eloqua_ActivityPageView
where CreatedAt < @ArchiveDate
;

insert archive.Eloqua_ActivityPageView (
	ETL_CreatedDate, ETL_UpdatedDate, ETL_IsDeleted, ETL_DeletedDate, ETL_DeltaHashKey, ID, CreatedAt, Type, ContactId, IPAddress, Url
	, CampaignId, ReferrerUrl, VisitorId, VisitorExternalId, WebVisitId, IsWebTrackingOptedIn, ETL_ArchiveDate
)
select ETL_CreatedDate, ETL_UpdatedDate, ETL_IsDeleted, ETL_DeletedDate, ETL_DeltaHashKey, ID, CreatedAt, Type, ContactId, IPAddress, Url
	, CampaignId, ReferrerUrl, VisitorId, VisitorExternalId, WebVisitId, IsWebTrackingOptedIn, GETDATE() as ETL_ArchiveDate
from #tmp_ActivityPageView
;

delete a
from ods.Eloqua_ActivityPageView a
join #tmp_ActivityPageView b
on a.ID = B.ID
;

drop table #tmp_ActivityPageView
;



ExitSproc:


END





GO
