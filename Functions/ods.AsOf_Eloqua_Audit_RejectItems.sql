SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_Eloqua_Audit_RejectItems] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_Eloqua_Audit_RejectItems] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[SyncUri] [nvarchar](25) NULL,
[Logs_items_syncUri] [nvarchar](25) NULL,
[Logs_items_count] [int] NULL,
[Logs_items_severity] [nvarchar](25) NULL,
[Logs_items_statusCode] [nvarchar](25) NULL,
[Logs_items_message] [nvarchar](500) NULL,
[Logs_items_createdAt] [datetime] NULL,
[ETL_CreatedOn] [datetime] NOT NULL,
[ETL_CreatedBy] NVARCHAR(400) NOT NULL,
[ETL_UpdatedOn] [datetime] NOT NULL,
[ETL_UpdatedBy] NVARCHAR(400) NOT NULL
)

AS
BEGIN

DECLARE @EndDate DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS datetime2(0))))
SET @AsOfDate = (SELECT CAST(@AsOfDate AS datetime2(0)))

INSERT INTO @Results
SELECT [SyncUri],[Logs_items_syncUri],[Logs_items_count],[Logs_items_severity],[Logs_items_statusCode],[Logs_items_message],[Logs_items_createdAt],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [SyncUri],[Logs_items_syncUri],[Logs_items_count],[Logs_items_severity],[Logs_items_statusCode],[Logs_items_message],[Logs_items_createdAt],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[Eloqua_Audit_RejectItems] t
	UNION ALL
	SELECT [SyncUri],[Logs_items_syncUri],[Logs_items_count],[Logs_items_severity],[Logs_items_statusCode],[Logs_items_message],[Logs_items_createdAt],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_Eloqua_Audit_RejectItems]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
