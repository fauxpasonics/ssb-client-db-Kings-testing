SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE VIEW [etl].[vw_sync_ods_SkiData_User_Profiles] AS (
	
SELECT * FROM ods.SkiData_User_Profiles (NOLOCK)

)



GO
