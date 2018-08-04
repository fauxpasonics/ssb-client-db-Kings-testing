SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE PROCEDURE [etl].[SSB_Sync_MergeGenerator_Dev]
     @Target VARCHAR(256),
     @Source VARCHAR(256),
     @Target_Key VARCHAR(256),
     @Source_Key VARCHAR(256),
     @Proc_Name VARCHAR(256)
AS
/**************************************Comments***************************************
**************************************************************************************
Mod #:		1
Name:		ssbcloud\dschaller
Date:		01/19/2015
Comments:	This sproc creates merge logic dynamically based on values passed into sproc.

Mod #:		2
Name:		ssbcloud\dhorstman
Date:		12/31/2015
Comments:	Added 2 more VARCHAR(MAX) variables to handle extremely wide tables that overran
			the limitations of one variable.

Mod #:		3
Name:		ssbcloud\dhorstman
Date:		01/14/2016
Comments:	ETL_ID is no longer an identity column on target tables, so include it in the
			list of updated/inserted columns.

*************************************************************************************/
--Variables that will need to be passed into the sproc
--DECLARE
--     @Target VARCHAR(256),
--     @Source VARCHAR(256),
--     @Target_Key VARCHAR(256),
--     @Source_Key VARCHAR(256),
--     @Proc_Name VARCHAR(256)

--SET @Target = 'ods.TI_PatronMDM_Athletics'
--SET @Source = 'etl.vw_src_TI_PatronMDM_Athletics'
--SET @Target_Key = 'Patron'
--SET @Source_Key = 'Patron'
--SET @Proc_Name = 'ETL.ods_Load_TI_PatronMDM_Athletics'

--Variables that will stay in sproc contents
DECLARE
     @SQL VARCHAR(MAX),
	 @SQL2 VARCHAR(MAX),
	 @SQL3 VARCHAR(MAX)

DECLARE
	 @ColString VARCHAR(MAX)
SET
	 @ColString = 
	 ( SELECT STUFF ((
                    SELECT ', ' + name 
                    FROM sys.columns
                    WHERE object_id = OBJECT_ID(@Source) -- and name not in ('ETL_ID')	DCH 2016-01-14		
					ORDER BY column_id		
                    FOR XML PATH('')), 1, 1, '') 
	 )

DECLARE
	 @HashSyntax VARCHAR(MAX)

DECLARE	 @HashTbl TABLE (HashSyntax VARCHAR(MAX))
INSERT @HashTbl (HashSyntax)
EXEC  [etl].[SSB_HashFieldSyntax] @Source--, 'ETL_ID'		DCH 2016-01-14

SET @HashSyntax = (SELECT TOP 1 HashSyntax FROM @HashTbl)

DECLARE
	 @JoinString VARCHAR(MAX)
SET @JoinString = 
	(
		SELECT STUFF ((
        SELECT ' and ' + match  
        FROM
		(
			SELECT a.id, 'myTarget.' + a.Item + ' = mySource.' + b.Item AS match
			FROM dbo.Split_DS (@Target_Key, ',') a INNER JOIN
			dbo.Split_DS (@Source_Key, ',') b ON a.ID = b.ID
		)	x	
		ORDER BY id		
        FOR XML PATH('')), 1, 5, '')
	)

	DECLARE @SqlStringMax AS VARCHAR(MAX) = ''
	DECLARE @SchemaName  AS VARCHAR(255) = [dbo].[fnGetValueFromDelimitedString](@Source, '.' ,1)
	DECLARE @Table AS VARCHAR(255) = [dbo].[fnGetValueFromDelimitedString](@Source, '.' ,2)

	
	SELECT @SqlStringMax = @sqlStringMax + 'OR ISNULL(mySource.' + COLUMN_NAME + ','''') <> ' + 'ISNULL(myTarget.' + COLUMN_NAME + ','''') '
	FROM INFORMATION_SCHEMA.COLUMNS
	WHERE TABLE_SCHEMA = @SchemaName AND TABLE_NAME = @Table
	AND ISNULL(CHARACTER_MAXIMUM_LENGTH, 0) < 0
--	AND COLUMN_NAME NOT IN ('ETL_ID')	DCH 2016-01-14

	
SELECT @SQL = 
'CREATE PROCEDURE ' + @Proc_Name + CHAR(10) + 
'(
	@BatchId NVARCHAR(50) = NULL,
	@Client NVARCHAR(255) = NULL,
	@Options nvarchar(MAX) = NULL,
	@OptionsFormat nvarchar(50) = ''KeyValue''
)
AS 

BEGIN
/**************************************Comments***************************************
**************************************************************************************
Mod #:  1
Name:     ' + CURRENT_USER + '
Date:     ' + CONVERT(VARCHAR, GETDATE(), 101) + '
Comments: Initial creation
*************************************************************************************/

SET @BatchId = ISNULL(@BatchId, CONVERT(NVARCHAR(50), NEWID()))
SET @Client = ISNULL(@Client, DB_NAME())

DECLARE @RunTime DATETIME = GETDATE()

DECLARE @ExecutionId uniqueidentifier = newid();
DECLARE @ProcedureName nvarchar(255) = OBJECT_SCHEMA_NAME(@@PROCID) + ''.'' + OBJECT_NAME(@@PROCID);
DECLARE @SrcRowCount int = ISNULL((SELECT CONVERT(varchar, COUNT(*)) FROM ' + @Source + '),''0'');	
DECLARE @SrcDataSize NVARCHAR(255) = ''0''

/*Load Options into a temp table*/
SELECT Col1 AS OptionKey, Col2 as OptionValue INTO #Options FROM [dbo].[SplitMultiColumn](@Options, ''='', '';'')

DECLARE @DisableDelete nvarchar(5) = ISNULL((SELECT OptionValue FROM #Options WHERE OptionKey = ''DisableDelete''),''true'')

BEGIN TRY 

PRINT ''Execution Id: '' + CONVERT(NVARCHAR(100),@ExecutionId)

EXEC etl.CreateEventLogRecord @Batchid, @Client, ''Info'', @ProcedureName, ''Merge Load'', ''Procedure Processing'', ''Start'', @ExecutionId
EXEC etl.CreateEventLogRecord @Batchid, @Client, ''Info'', @ProcedureName, ''Merge Load'', ''Src Row Count'', @SrcRowCount, @ExecutionId
EXEC etl.CreateEventLogRecord @Batchid, @Client, ''Info'', @ProcedureName, ''Merge Load'', ''Src DataSize'', @SrcDataSize, @ExecutionId


SELECT ROW_NUMBER() OVER(ORDER BY ETL_ID) RowIndex
, * 
INTO #data
FROM ' + @Source + '

CREATE NONCLUSTERED INDEX IDX_RowIndex ON #data (RowIndex)

DECLARE @RecordCount INT = (SELECT COUNT(*) FROM #data)
DECLARE @StartIndex INT = 1, @PageCount INT = 25000
DECLARE @EndIndex INT = (@StartIndex + @PageCount - 1)

WHILE @StartIndex <= @RecordCount
BEGIN

SELECT CAST(NULL AS BINARY(32)) ETL_Sync_DeltaHashKey
, ' + @ColString + '
INTO #SrcData
FROM #data
WHERE RowIndex BETWEEN @StartIndex AND @EndIndex

EXEC etl.CreateEventLogRecord @Batchid, @Client, ''Info'', @ProcedureName, ''Merge Load'', ''Src Table Setup'', ''Temp Table Loaded'', @ExecutionId

UPDATE #SrcData
SET ETL_Sync_DeltaHashKey = ' + @HashSyntax + '

EXEC etl.CreateEventLogRecord @Batchid, @Client, ''Info'', @ProcedureName, ''Merge Load'', ''Src Table Setup'', ''ETL_Sync_DeltaHashKey Set'', @ExecutionId

CREATE NONCLUSTERED INDEX IDX_Load_Key ON #SrcData (' + @Source_Key + ')
CREATE NONCLUSTERED INDEX IDX_ETL_Sync_DeltaHashKey ON #SrcData (ETL_Sync_DeltaHashKey)

EXEC etl.CreateEventLogRecord @Batchid, @Client, ''Info'', @ProcedureName, ''Merge Load'', ''Src Table Setup'', ''Temp Table Indexes Created'', @ExecutionId

EXEC etl.CreateEventLogRecord @Batchid, @Client, ''Info'', @ProcedureName, ''Merge Load'', ''Merge Statement Execution'', ''Start'', @ExecutionId
';

-------------------------------------------------------------------------------------------------

SELECT @SQL2 = 
'MERGE ' + @Target + ' AS myTarget

USING (
	SELECT * FROM #SrcData
) AS mySource
    
	ON ' + @JoinString + '

WHEN MATCHED AND (
     ISNULL(mySource.ETL_Sync_DeltaHashKey,-1) <> ISNULL(myTarget.ETL_Sync_DeltaHashKey, -1)
	 ' + @SqlStringMax + '
)
THEN UPDATE SET
      ' +
          STUFF ((
                    SELECT ',myTarget.[' + name + '] = mySource.[' + name + ']' + CHAR(10) + '     '
                           
						FROM sys.columns
						WHERE object_id = OBJECT_ID(@Target)
         --                AND (name NOT LIKE 'ETL[_]%'
         --                     OR name = 'ETL_Sync_DeltaHashKey'
							  --OR name = 'ETL_SourceFileName'
         --                     OR name = 'ETL_UpdatedDate')
						ORDER BY column_id
                    FOR XML PATH('')), 1, 1, '')  +
'

--WHEN NOT MATCHED BY SOURCE AND @DisableDelete = ''false'' THEN DELETE

';

-------------------------------------------------------------------------------------------------

SELECT @SQL3 = 
'WHEN NOT MATCHED BY Target
THEN INSERT
     (' + 
          STUFF ((
                    SELECT ',[' + name + ']' + CHAR(10) + '     '
						FROM sys.columns
						WHERE object_id = OBJECT_ID(@Target)
--                         AND name <> 'ETL_ID'		DCH 2016-01-14
					ORDER BY column_id
                    FOR XML PATH('')), 1, 1, '') + ')
VALUES
     (' +
          STUFF ((
                    SELECT ',mySource.[' + name + ']' + CHAR(10) + '     '
						FROM sys.columns
						WHERE object_id = OBJECT_ID(@Target)
--                         AND name <> 'ETL_ID'		DCH 2016-01-14
					ORDER BY column_id
                    FOR XML PATH('')), 1, 1, '') + ')
;


DROP TABLE #SrcData

SET @StartIndex = @EndIndex + 1
SET @EndIndex = @EndIndex + @PageCount

--EXEC etl.CreateEventLogRecord @Batchid, @Client, ''Info'', @ProcedureName, ''Merge Load'', ''Merge Statement Execution'', ''Complete'', @ExecutionId

END --End Of Paging Loop


END TRY 
BEGIN CATCH 

	DECLARE @ErrorMessage nvarchar(4000) = ERROR_MESSAGE();
	DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
	DECLARE @ErrorState INT = ERROR_STATE();
			
	PRINT @ErrorMessage
	EXEC etl.CreateEventLogRecord @Batchid, @Client, ''Error'', @ProcedureName, ''Merge Load'', ''Merge Error'', @ErrorMessage, @ExecutionId
	EXEC etl.CreateEventLogRecord @Batchid, @Client, ''Info'', @ProcedureName, ''Merge Load'', ''Procedure Processing'', ''Complete'', @ExecutionId

	RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)

END CATCH

EXEC etl.CreateEventLogRecord @Batchid, @Client, ''Info'', @ProcedureName, ''Merge Load'', ''Procedure Processing'', ''Complete'', @ExecutionId


END

GO'

SELECT @SQL AS [SQL], @SQL2 AS [SQL2], @SQL3 AS [SQL3]

select @SQL + @SQL2 + @SQL3



GO
