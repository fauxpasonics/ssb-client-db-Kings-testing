SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [preods].[Eloqua_Audit_RejectResults]
AS

SELECT DISTINCT

	CONVERT(NVARCHAR(25),[SyncUri]) [SyncUri_K]
	,CONVERT(int,[Rejects_totalResults]) [Rejects_totalResults]
	,CONVERT(int,[Rejects_limit]) [Rejects_limit]
	,CONVERT(int,[Rejects_offset]) [Rejects_offset]
	,CONVERT(int,[Rejects_count]) [Rejects_count]
	,CONVERT(NVARCHAR(10),[Rejects_hasMore]) [Rejects_hasMore]
FROM [src].[Eloqua_audit] WITH (NOLOCK)
where rejects_totalresults is not null
GO
