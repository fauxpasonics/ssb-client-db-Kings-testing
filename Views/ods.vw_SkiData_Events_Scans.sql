SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [ods].[vw_SkiData_Events_Scans] AS (

	SELECT   u.UserID as LRSUserID
			, null as TeamUniqueID
			, null as TicketAccountID
			, null as TicketUserID
			, sp.pointactivityID As PointActivityID
			, sp.PointActivitytitle as PointActivity
			, fa.ScanDateTime as AwardDate
			, Case When sp.pointActivityID = '1160' then 1 
				   When sp.pointactivitytitle like '%purchase%' then ht.transaction_amount end as StaticPoints
			, Case When sp.pointActivityID = '1160' then 1 
				   When sp.pointactivitytitle like '%purchase%' then 15   End  as PointFactor
			, 'SSB' as Source
			, null as SourceID
			, null as SubAccountID
			, null as FriendlyDescription
			, concat(ht.primaryact, + '-', ht.seatinfo) as [Note]


	FROM dbo.dimcustomer dc
	join [ods].[SkiData_Users] u on u.ticketaccountID = dc.AccountID
	join [ods].[SkiData_Points] sp on sp.ticketAccountID = u.ticketAccountID
	join ods.Host_Trans ht on ht.EMAIL = u.email
	join dbo.FactAttendance fa on fa.SSID_acct_id = u.TicketAccountID


	WHERE dc.CustomerType = 'primary'

	)



GO
