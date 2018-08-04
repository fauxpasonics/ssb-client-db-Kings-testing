SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [ods].[vw_NBA_Fan_AccountID_TicketTypePurchaseRevenue] AS 

SELECT pvt.* 
FROM (
	SELECT x.ssid
	,x.TicketTypeName 
	, SUM(x.TotalRevenue) [TotalRevenue]
	FROM (
		SELECT ss.ssid 
		, dtt.TicketTypeName, dtt.TicketTypeClass
		, f.QtySeat, f.TotalRevenue, f.IsSingleEvent, f.IsRenewal
		FROM [ods].[vw_NBA_Fan_AccountID_Guids] ss
		INNER JOIN dbo.FactTicketSales f WITH (NOLOCK) ON f.SSID_acct_id = ss.AccountId
		INNER JOIN dbo.DimTicketType dtt WITH (NOLOCK) ON dtt.DimTicketTypeId = f.DimTicketTypeId
	) x 
	GROUP BY x.ssid, x.TicketTypeName
	) p
PIVOT (SUM(TotalRevenue) FOR TicketTypeName IN (
[Unknown],[Full Season],[Starting Five Partial Pack],[Weekend Partial Pack],[Big Game Package],[Half Season A],
[Half Season B],[2 Game Bobble],[December Pass 5 Games],[November Pass 8 Games],[Uncategorized Partial],[Parking],
[Single Game],[Group],[Fundraising],[Misc],[Last 11 Games],[Suite],[Flex],[Half Season],[Quarter Season],[Mini Plan],[Experience Pass]
)
)pvt


GO
