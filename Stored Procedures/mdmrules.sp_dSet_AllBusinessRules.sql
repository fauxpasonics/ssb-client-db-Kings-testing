SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROC [mdmrules].[sp_dSet_AllBusinessRules]
AS

--EXEC mdmrules.[sp_DSET_Gather]

DECLARE @Criteria table (CriteriaID int, Criteria varchar(50))
Insert into @Criteria
Select 4, 'Archtics- Suite/Loft'
UNION ALL
Select 5, 'Season Ticket Holder - Current Year'
UNION ALL
Select 6, 'Archtics - PartialPlan - Current Year'
UNION ALL
Select 7, 'Archtics - Group Seats - Current Year'
UNION ALL
Select 8, 'Archtics - Single Game - Current Year'
UNION ALL
Select 9, 'Archtics - Most Recently Updated'
UNION ALL
Select 10, 'CRM - Most Recently Updated'
UNION ALL
Select 11, 'Eloqua - Most Recently Updated'
;



--TM Base
with cteTM as (
SELECT fts.dimcustomerid, 
CASE WHEN fts.[DimTicketTypeId] = 18  THEN 4 --'Suite/Loft' 
	WHEN fts.[DimTicketTypeId] =  1 THEN 5 --'STH' 
	WHEN dtt.TicketTypeDesc = 'Partial Plan' THEN 6 --'PartialPlan' 
	WHEN fts.[DimTicketTypeId] = 13 THEN 7 --'GroupSeats' 
	WHEN fts.[DimTicketTypeId] IN (12,14,15) THEN 8 --'SingleGame' 
	 ELSE 0 
	 END as CriteriaID,
MAX(dd.[CalDate]) MaxSaleDate
FROM dbo.FactTicketSales fts
JOIN dbo.DimTicketType dtt ON dtt.DimTicketTypeId = fts.DimTicketTypeId
JOIN dbo.DimPlanType dpt ON dpt.DimPlanTypeId = fts.DimPlanTypeId
JOIN dbo.DimSeatType dst ON dst.DimSeatTypeId = fts.DimSeatTypeId
JOIN dbo.[DimDate] dd ON fts.[DimDateId] = dd.[DimDateId]
where fts.[DimTicketTypeId] NOT IN (-1,0)
GROUP BY fts.dimcustomerid, 
CASE WHEN fts.[DimTicketTypeId] = 18  THEN 4 --'Suite/Loft' 
	WHEN fts.[DimTicketTypeId] =  1 THEN 5 --'STH' 
	WHEN dtt.TicketTypeDesc = 'Partial Plan' THEN 6 --'PartialPlan' 
	WHEN fts.[DimTicketTypeId] = 13 THEN 7 --'GroupSeats' 
	WHEN fts.[DimTicketTypeId] IN (12,14,15) THEN 8 --'SingleGame' 
	 ELSE 0 
	 END),

--Dates
cteUpdatedDate as (
SELECT [b].[DimCustomerId], MAX(UpdateDate) Max_UpdateDate, 9 CriteriaID --'Archtics' 
FROM ods.TM_Journal a 
INNER JOIN dbo.[vwDimCustomer_ModAcctId] b ON [a].[acct_id] = b.accountid AND b.[CustomerType] = 'Primary'
GROUP BY [b].[DimCustomerId]
UNION ALL
SELECT [b].[DimCustomerId], MAX(LastModifiedDate) LastModifiedDate, 10 CriteriaID --CRM
FROM KingsCI_Reporting.ProdCopy.Account a 
INNER JOIN dbo.[vwDimCustomer_ModAcctId] b ON a.id = b.[SSID] AND b.sourcesystem = 'Kings PC_SFDC Account' AND b.[IsDeleted] = 0
GROUP BY [b].[DimCustomerId]
UNION ALL
SELECT [b].[DimCustomerId], MAX(UpdatedAt) UpdatedAt, 11 CriteriaID --Eloqua
FROM ods.Eloqua_Contact a 
INNER JOIN dbo.[vwDimCustomer_ModAcctId] b ON a.id = b.ssid AND b.[SourceSystem] = 'Eloqua Kings'
GROUP BY [b].[DimCustomerId]
)

--SELECT DISTINCT [SourceSystem] FROM dbo.[vwDimCustomer_ModAcctId]
--SELECT CriteriaID, COUNT(*) FROM [cteTogether] GROUP BY CriteriaID

--Final Select
SELECT DimCustomerID, CriteriaID, CriteriaValue
FROM 
	(
		--Select DimCustomerID,b.CriteriaID, CAST(1 AS VARCHAR(50)) CriteriaValue
		Select DimCustomerID,b.CriteriaID, CAST(LTRIM(STR(YEAR(MaxSaleDate))) + '-' + CASE WHEN LEN(LTRIM(STR(MONTH(a.MaxSaleDate)))) = 1 THEN '0' + LTRIM(STR(MONTH(a.MaxSaleDate))) ELSE LTRIM(STR(MONTH(a.MaxSaleDate))) END
			 + '-' + CASE WHEN LEN(LTRIM(STR(Day(a.MaxSaleDate)))) = 1 THEN '0' + LTRIM(STR(Day(a.MaxSaleDate))) ELSE LTRIM(STR(Day(a.MaxSaleDate))) END AS VARCHAR(50)) AS  CriteriaValue
		from [cteTM] a
		Join @Criteria b ON [b].[CriteriaID] = [a].[CriteriaID]
		UNION ALL
		Select DimCustomerID,b.CriteriaID, CAST(LTRIM(STR(YEAR(Max_UpdateDate))) + '-' + CASE WHEN LEN(LTRIM(STR(MONTH(a.Max_UpdateDate)))) = 1 THEN '0' + LTRIM(STR(MONTH(a.Max_UpdateDate))) ELSE LTRIM(STR(MONTH(a.Max_UpdateDate))) END
			 + '-' + CASE WHEN LEN(LTRIM(STR(Day(a.Max_UpdateDate)))) = 1 THEN '0' + LTRIM(STR(Day(a.Max_UpdateDate))) ELSE LTRIM(STR(Day(a.Max_UpdateDate))) END AS VARCHAR(50)) AS  CriteriaValue
		--CAST(LTRIM(STR(YEAR())) + '-' + LTRIM(STR(MONTH(a.Max_UpdateDate))) + '-' + LTRIM(STR(DAY(Max_UpdateDate))) AS VARCHAR(50)) 
		from [cteUpdatedDate] a
		Join @Criteria b ON [b].[CriteriaID] = [a].[CriteriaID]
		)x



GO
