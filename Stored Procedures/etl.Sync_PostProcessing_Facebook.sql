SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE PROCEDURE [etl].[Sync_PostProcessing_Facebook]
AS
BEGIN


IF EXISTS (select * from INFORMATION_SCHEMA.tables where CONCAT(TABLE_SCHEMA,'.',TABLE_NAME) = 'ods.Facebook_Lead_Parsed_CustomerData')
BEGIN
	ALTER TABLE ods.Facebook_Lead_Parsed_CustomerData ALTER COLUMN DynamicData XML NULL
END;


END


GO
