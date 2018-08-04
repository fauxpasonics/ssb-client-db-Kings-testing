SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE PROCEDURE [etl].[sp_CRMInteg_RecentCustData]
AS
-- Truncate Table etl.SFDCProcess_RecentCustData 
--INSERT INTO etl.SFDCProcess_RecentCustData (SSID, MaxTransDate, Team)
--SELECT CAST(a.SSID AS VARCHAR(100)) SSID, MAX([SSUpdatedDate]) MaxTransDate,'Coyotes-TM' Team
--FROM coyotes.dbo.dimCustomer a 
--WHERE a.SourceSystem='TM'
--GROUP BY a.SSID

TRUNCATE TABLE etl.CRMProcess_RecentCustData

DECLARE @Client VARCHAR(50)
SET @Client = 'Kings-TM'

SELECT x.dimcustomerid, MAX(x.maxtransdate) maxtransdate, x.team
INTO #tmpTicketSales
FROM (
SELECT f.DimCustomerID, MAX(dd.CalDate) MaxTransDate , @Client Team
--Select * 
FROM dbo.FactTicketSales f WITH(NOLOCK)
INNER JOIN dbo.DimDate  dd WITH(NOLOCK) ON dd.DimDateId = f.DimDateId
WHERE dd.CalDate >= DATEADD(YEAR, -2, GETDATE()+2)
GROUP BY f.[DimCustomerId]

UNION ALL 

SELECT dc.DimCustomerID, MAX(add_datetime) MaxTransDate , @Client Team
--Select * 
FROM rpt.vw_RetailTicketBase rtb WITH (NOLOCK)
INNER JOIN dbo.DimCustomer dc WITH (NOLOCK) 
	ON dc.AccountId=rtb.acct_id
	AND dc.CustomerType='Primary'
	AND dc.SourceSystem='TM'
WHERE add_datetime >= DATEADD(YEAR, -2, GETDATE()+2)
GROUP BY dc.[DimCustomerId]




UNION ALL

SELECT dc.dimcustomerid, MAX(tex.add_datetime) MaxTransDate, @client Team
FROM Kings.ods.TM_Tex tex WITH (NOLOCK)
LEFT JOIN Kings.dbo.dimcustomer dc WITH (NOLOCK) ON tex.assoc_acct_id = dc.accountid AND dc.customertype = 'Primary' AND dc.sourcesystem = 'TM'
WHERE tex.add_datetime >= DATEADD(YEAR, -2, GETDATE()+2)
GROUP BY dc.dimcustomerid
) x
GROUP BY x.[DimCustomerId], x.Team

INSERT INTO etl.CRMProcess_RecentCustData (SSID, MaxTransDate, Team)
SELECT SSID, [MaxTransDate], Team FROM [#tmpTicketSales] a 
INNER JOIN dbo.[vwDimCustomer_ModAcctId] b ON [b].[DimCustomerId] = [a].[DimCustomerId]


----DECLARE @Client VARCHAR(50)
--SET @Client = 'Raiders-GP'

--SELECT x.custnmbr SSID , MAX(x.maxtransdate) maxtransdate, x.team
--INTO #tmpmerchSales
--FROM (
--SELECT f.custnmbr, MAX(f.DOCDATE) MaxTransDate , @Client Team
----Select * 
--FROM ods.GP_Transactions f WITH(NOLOCK)
--WHERE f.DOCDATE >= DATEADD(YEAR, -2, GETDATE()+2)
--GROUP BY f.custnmbr
--) x
--GROUP BY x.custnmbr, x.Team

--INSERT INTO etl.CRMProcess_RecentCustData (SSID, MaxTransDate, Team)
--SELECT SSID, [MaxTransDate], Team FROM [#tmpmerchSales] a 


GO
