SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE VIEW [etl].[vw_sync_ods_SkiData_RewardRedemptions] AS (
	
SELECT * FROM ods.SkiData_RewardRedemptions (NOLOCK)

)



GO
