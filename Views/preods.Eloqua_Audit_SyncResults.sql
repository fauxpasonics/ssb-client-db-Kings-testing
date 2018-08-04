SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [preods].[Eloqua_Audit_SyncResults]
AS

SELECT DISTINCT

	CONVERT(NVARCHAR(25),[SyncUri]) [SyncUri_K]
	,CONVERT(int,[Logs_totalResults]) [Logs_totalResults]
	,CONVERT(int,[Logs_limit]) [Logs_limit]
	,CONVERT(int,[Logs_offset]) [Logs_offset]
	,CONVERT(int,[Logs_count]) [Logs_count]
	,CONVERT(NVARCHAR(10),[Logs_hasMore]) [Logs_hasMore]
FROM [src].[Eloqua_audit] WITH (NOLOCK)
where logs_totalresults is not null
GO
