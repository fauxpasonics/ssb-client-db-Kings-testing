SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [etl].[SFDC_Update_DimCustomer_MatchKey]

AS
BEGIN

 SELECT A.customer_matchkey,  
     Split.a.value('.', 'VARCHAR(100)') AS SF_Archtics_ID  
	 Into #Matchups
 FROM  (SELECT customer_matchkey,  
         CAST ('<M>' + REPLACE(CASE WHEN SourceSystem = 'Kings PC_SFDC Contact' THEN ExtAttribute6
									WHEN SourceSystem = 'Kings PC_SFDC Account' THEN ExtAttribute5
									END, ',', '</M><M>') + '</M>' AS XML) AS String  
     FROM  dbo.DimCustomer
	 WHERE ((SourceSystem = 'Kings PC_SFDC Contact' AND customer_matchkey IS NOT NULL And ExtAttribute6 IS NOT NULL and Isbusiness = 1)
	 OR (SourceSystem = 'Kings PC_SFDC Account' AND customer_matchkey IS NOT NULL And ExtAttribute5 IS NOT NULL and Isbusiness = 0))
	 AND isdeleted = 0
	  ) AS A CROSS APPLY String.nodes ('/M') AS Split(a)

CREATE NONCLUSTERED INDEX IX_AccountID
ON #Matchups (customer_matchkey)

Update  a
	SET customer_matchkey = b.customer_matchkey
from dbo.dimcustomer a
JOIN #Matchups b on CAST(a.AccountID as varchar(50)) = b.SF_Archtics_ID
	AND a.SourceSystem = 'TM'
	AND a.CustomerType ='Primary'
	AND ISNULL(a.customer_matchkey,'') <> ISNULL(SF_Archtics_ID,'')

END
GO
