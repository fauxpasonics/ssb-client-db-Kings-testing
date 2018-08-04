SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


create PROCEDURE [rpt].[rptCust_TMSuspectDupes]
AS


-- Archtics Suspect Dupes
/*
select s.SSB_CRMSYSTEM_CONTACT_ID, d.SSID, FirstName, LastName, AddressPrimaryStreet, AddressPrimaryCity, AddressPrimarySuite, 
AddressPrimaryState, AddressPrimaryZip, PhoneHome, PhoneCell, EmailPrimary, CustomerType, case when SSB_CRMSYSTEM_PRIMARY_FLAG = 1 then 'True' else 'False' end as IsPrimary
INTO rpt.TMSuspectDupes
FROM DimCustomer d
inner join dimcustomerssbid s
on d.DimCustomerId = s.DimCustomerId
inner join
(select SSB_CRMSYSTEM_CONTACT_ID
from dimcustomerssbid s
where s.SourceSystem='TM'
group by SSB_CRMSYSTEM_CONTACT_ID
having count(*)>1) dupe
on s.SSB_CRMSYSTEM_CONTACT_ID = dupe.SSB_CRMSYSTEM_CONTACT_ID
where d.SourceSystem = 'TM'
order by s.SSB_CRMSYSTEM_CONTACT_ID
*/

SELECT
*
FROM rpt.TMSuspectDupes
GO
