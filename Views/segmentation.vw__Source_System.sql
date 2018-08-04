SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





CREATE  VIEW  [segmentation].[vw__Source_System] AS (

SELECT  dc.SSB_CRMSYSTEM_CONTACT_ID
		, dc.SourceSystem CustomerSourceSystem


FROM    [dbo].[vwDimCustomer_ModAcctId] dc

WHERE dc.SourceSystem NOT IN ('TM', 'Kings PC_SFDC Account', 'Kings PC_SFDC Contact', 'Eloqua Kings')


) 





























GO
