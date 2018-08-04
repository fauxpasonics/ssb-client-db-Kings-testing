SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create view [mdmrules].[vw_CriteriaValues_Flat] AS SELECT DimCustomerID, [11],[8],[7],[6],[10],[9],[4],[5] 
			FROM  
            (SELECT DimCustomerID, CriteriaID, CriteriaValue 
				FROM mdmrules.tbl_CriteriaValues) AS SourceTable
            PIVOT 
            (
                 MAX(CriteriaValue)
                 FOR CriteriaID in ([11],[8],[7],[6],[10],[9],[4],[5])
            ) p 
GO
