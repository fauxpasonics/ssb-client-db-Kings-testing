SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE VIEW  [ods].[vw_NBA_Fan_AccountID_Guids] AS

SELECT n.SSB_CRMSYSTEM_CONTACT_ID, t.AccountId, nba.ssid --, fan.*  
FROM dbo.vwDimCustomer_ModAcctId t
JOIN (
	SELECT SSB_CRMSYSTEM_CONTACT_ID 
	FROM dbo.vwDimCustomer_ModAcctId 
	WHERE SourceSystem ='NBA_FanData'
	) n 	ON n.SSB_CRMSYSTEM_CONTACT_ID = t.SSB_CRMSYSTEM_CONTACT_ID 	AND t.CustomerType = 'primary' AND t.SourceSystem = 'TM'
JOIN dbo.vwDimCustomer_ModAcctId nba ON nba.SSB_CRMSYSTEM_CONTACT_ID = n.SSB_CRMSYSTEM_CONTACT_ID AND nba.SourceSystem = 'NBA_fandata'
GROUP BY n.SSB_CRMSYSTEM_CONTACT_ID,
         t.AccountId,
         nba.SSID
	







--SELECT s.SSID, s.SSB_CRMSYSTEM_CONTACT_ID, t.AccountId 
--FROM (
--	SELECT f.teamPartnerSystemCustomerID, n.SSID, n.SSB_CRMSYSTEM_CONTACT_ID
--	FROM ods.NBA_Fan_Data_Sharing f 
--	INNER JOIN dbo.vwDimCustomer_ModAcctId n ON n.SSID = f.teamPartnerSystemCustomerID
--	WHERE 1 = 1
--	AND n.SourceSystem = 'NBA_fandata'
--	) s 
--INNER JOIN dbo.vwDimCustomer_ModAcctId t ON t.SSB_CRMSYSTEM_ACCT_ID = s.SSB_CRMSYSTEM_CONTACT_ID
--WHERE t.CustomerType = 'primary' AND t.SourceSystem = 'TM'



--GO


GO
