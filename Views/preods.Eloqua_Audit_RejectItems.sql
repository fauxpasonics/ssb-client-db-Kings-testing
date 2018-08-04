SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [preods].[Eloqua_Audit_RejectItems]
AS

SELECT DISTINCT

	CONVERT(NVARCHAR(25),[SyncUri]) [SyncUri_K]
	,CONVERT(NVARCHAR(25),[Logs_items_syncUri]) [Logs_items_syncUri]
	,CONVERT(int,[Logs_items_count]) [Logs_items_count]
	,CONVERT(NVARCHAR(25),[Logs_items_severity]) [Logs_items_severity]
	,CONVERT(NVARCHAR(25),[Logs_items_statusCode]) [Logs_items_statusCode_K]
	,CONVERT(NVARCHAR(500),[Logs_items_message]) [Logs_items_message_K]
	,CONVERT(datetime,[Logs_items_createdAt]) [Logs_items_createdAt]
FROM [src].[Eloqua_audit] WITH (NOLOCK)
where logs_items_syncuri is not null
GO
