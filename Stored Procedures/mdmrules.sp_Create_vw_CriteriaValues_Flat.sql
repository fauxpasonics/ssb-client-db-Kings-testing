SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [mdmrules].[sp_Create_vw_CriteriaValues_Flat]

AS

DECLARE @cols AS NVARCHAR(MAX),
    @query  AS NVARCHAR(MAX);

SET @cols = STUFF((SELECT distinct ',' + QUOTENAME(c.CriteriaID) 
            FROM mdmrules.tbl_CriteriaValues c			
            FOR XML PATH(''), TYPE
            ).value('.', 'NVARCHAR(MAX)') 
        ,1,1,'')

set @query = 'SELECT DimCustomerID, ' + @cols + ' 
			FROM  
            (SELECT DimCustomerID, CriteriaID, CriteriaValue 
				FROM mdmrules.tbl_CriteriaValues) AS SourceTable
            PIVOT 
            (
                 MAX(CriteriaValue)
                 FOR CriteriaID in (' + @cols + ')
            ) p '

			

begin tran

declare @sql nvarchar(max) = 
    '
		IF EXISTS (Select 1 from Sys.views WHERE name = ''vw_CriteriaValues_Flat'')
	BEGIN
		DROP VIEW mdmrules.vw_CriteriaValues_Flat
	END
      exec (''create view mdmrules.vw_CriteriaValues_Flat AS '+ 
			@query + ''')';

exec (@sql);
print(@sql);

rollback tran
GO
