SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [mdmrules].[sp_DSET_Gather]
AS

DECLARE @Sprocs TABLE (
UID INT IDENTITY(1,1) PRIMARY KEY
, SPROCName VARCHAR(200) 
)

INSERT INTO @Sprocs
        ( [SPROCName] )
SELECT b.name + '.' + a.[name] SPROCs 
FROM sys.[procedures] a 
INNER JOIN sys.schemas b ON [b].[schema_id] = [a].[schema_id]
WHERE b.name = 'mdmrules'
AND a.name like 'sp_dSet%'
AND a.name <> 'sp_DSET_Gather'

DECLARE @Loop INT, @LoopCounter INT
DECLARE @SprocName VARCHAR(200)
DECLARE @INSERT VARCHAR(200), @SQL NVARCHAR(4000)
SET @LoopCounter = 1
SET @Loop = (SELECT MAX(UID) FROM @Sprocs)

SET @INSERT = N'INSERT INTO mdmrules.[tbl_CriteriaValues]
	        ( 
				[DimCustomerID] ,
				[CriteriaID] ,
				[CriteriaValue] 
	        ) '

TRUNCATE TABLE mdmrules.[tbl_CriteriaValues]

WHILE @Loop >= @LoopCounter
BEGIN

	SET @SprocName = (SELECT SPROCName FROM @Sprocs WHERE UID = @LoopCounter)

	SET @SQL = @INSERT + ' EXEC ' + @SprocName
	--PRINT @SQL
	EXEC(@SQL)
	SET @LoopCounter = @LoopCounter + 1
END


EXEC [mdmrules].[sp_Create_vw_CriteriaValues_Flat]
GO
