SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE VIEW [etl].[vw_sync_ods_SkiData_User_Roles] AS (
	
SELECT * FROM ods.SkiData_User_Roles (NOLOCK)

)



GO
