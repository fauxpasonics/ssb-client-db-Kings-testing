SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE VIEW  [ro].[vw_SkiData_URLs]		
AS	    

WITH URL_CTE 
AS
(
SELECT d.ssb_crmsystem_contact_ID, s.userID, s.AvatarURL
FROM Ods.Skidata_UserAvatar s
JOIN [dbo].[dimcustomerssbid] d
ON d.ssid = CAST(s.userid AS VARCHAR)
WHERE d.sourcesystem = 'SkiData'

)


SELECT c.id, c.ssb_crmsystem_contact_ID__c, u.userid, u.avatarURL 
FROM URL_CTE U
JOIN KingsCI_Reporting.[Prodcopy].[Contact] c
ON u.ssb_crmsystem_contact_ID = c.ssb_crmsystem_contact_ID__c 





GO
