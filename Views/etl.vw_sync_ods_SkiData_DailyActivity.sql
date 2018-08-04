SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE VIEW [etl].[vw_sync_ods_SkiData_DailyActivity] AS (
	
SELECT * FROM ods.SkiData_DailyActivity (NOLOCK)

)



GO
