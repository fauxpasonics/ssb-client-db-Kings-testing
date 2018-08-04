SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE PROCEDURE [etl].[Sync_PreProcessing_Facebook]
AS
BEGIN


EXEC etl.Facebook_Lead_Dynamic_parse;


IF EXISTS (select * from INFORMATION_SCHEMA.tables where CONCAT(TABLE_SCHEMA,'.',TABLE_NAME) = 'ods.Facebook_Lead_Parsed_CustomerData')
BEGIN
	ALTER TABLE ods.Facebook_Lead_Parsed_CustomerData ALTER COLUMN DynamicData nvarchar(4000) NULL
END;


END


GO
