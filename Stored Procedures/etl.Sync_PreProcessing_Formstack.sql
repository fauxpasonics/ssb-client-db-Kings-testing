SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE PROCEDURE [etl].[Sync_PreProcessing_Formstack]
AS
BEGIN


EXEC etl.FormStack_Dynamic_parse;


IF EXISTS (select * from INFORMATION_SCHEMA.tables where CONCAT(TABLE_SCHEMA,'.',TABLE_NAME) = 'ods.Formstack_Parsed_CustomerData')
BEGIN
	ALTER TABLE ods.Formstack_Parsed_CustomerData ALTER COLUMN DynamicData nvarchar(4000) NULL
END;


END



GO
