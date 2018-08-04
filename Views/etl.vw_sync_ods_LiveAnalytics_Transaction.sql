SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE VIEW [etl].[vw_sync_ods_LiveAnalytics_Transaction] AS (
	
SELECT * FROM ods.LiveAnalytics_Transaction (NOLOCK)

)




GO
