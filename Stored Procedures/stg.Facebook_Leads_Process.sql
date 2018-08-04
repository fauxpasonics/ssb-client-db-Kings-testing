SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--------------  IN SSBRPPRODUCTION DB


--Data Source=ssbdwdev01.cloud.ssbinfo.com;Initial Catalog=kings;User ID=svcssbrp;Password=xjSCKUxvxP^vio1$;
--Data Source=ssbcidw05.cloud.ssbinfo.com;Initial Catalog=kings;User ID=svcssbrp;Password=m2tDiqAXzk42ps;

--SELECT *
--FROM dbo.[Tenant] t
--WHERE [t].[TenantName] LIKE '%sacramento king%'
--ORDER BY [t].[TenantName]


--SELECT *
--FROM [api].[UploadFileType] uft
--INNER JOIN [dbo].[Tenant] t ON [t].[TenantID] = [uft].[TenantId]
--WHERE t.[TenantName] LIKE '%chief%'
--AND uft.[Name] LIKE '%facebook%'
--ORDER BY [uft].[Name]



--INSERT INTO [api].[UploadFileType]
--([TenantId], [DataSource], [Name], [Description], [TableName], [SprocName], [Active], [ParentJsonNode], [TypeName])
--SELECT '46567F2B-8D7C-4F70-8782-EB00ED9FE9AB',
--'Data Source=ssbdwdev01.cloud.ssbinfo.com;Initial Catalog=kings;User ID=svcssbrp;Password=xjSCKUxvxP^vio1$;',
--'Kings Facebook Leads - DEVELOPMENT', 'Kings Facebook Leads - DEVELOPMENT',
--[TableName], [SprocName], [Active], [ParentJsonNode], [TypeName]
--FROM [api].[UploadFileType]
--WHERE [UploadFileTypeId] = '1993BBB1-5A63-4A6B-BECC-B033A84C45DD'




--INSERT INTO [api].[UploadFileType]
--([TenantId], [DataSource], [Name], [Description], [TableName], [SprocName], [Active], [ParentJsonNode], [TypeName])
--SELECT '46567F2B-8D7C-4F70-8782-EB00ED9FE9AB',
--'Data Source=ssbcidw05.cloud.ssbinfo.com;Initial Catalog=kings;User ID=svcssbrp;Password=m2tDiqAXzk42ps;',
--'Kings Facebook Leads - PRODUCTION', 'Kings Facebook Leads - PRODUCTION',
--[TableName], [SprocName], [Active], [ParentJsonNode], [TypeName]
--FROM [api].[UploadFileType]
--WHERE [UploadFileTypeId] = '4D23E729-DC21-47C6-882F-51E8AA0BD1B6'



--SELECT *
--FROM [api].[UploadFileType] uft
--INNER JOIN [dbo].[Tenant] t ON [t].[TenantID] = [uft].[TenantId]
--WHERE t.[TenantName] LIKE '%king%'
--AND uft.[Name] LIKE '%facebook%'
--ORDER BY [uft].[Name]


--SELECT *
--FROM [api].[UploadFileColumn]
--WHERE [UploadFileTypeId] = '1993BBB1-5A63-4A6B-BECC-B033A84C45DD'
--ORDER BY [ColumnOrder]



--INSERT INTO [api].[UploadFileColumn]
--([UploadFileTypeId], [Name], [Description], [DataTypeDatabase], [DataTypeDotNet], [Required], [ColumnOrder], [Mappable])
--SELECT 'A81E4300-B743-44F7-85EE-8D08157AE0C8',
--[Name], [Description], [DataTypeDatabase], [DataTypeDotNet], [Required], [ColumnOrder], [Mappable]
--FROM [api].[UploadFileColumn]
--WHERE [UploadFileTypeId] = '1993BBB1-5A63-4A6B-BECC-B033A84C45DD'



--INSERT INTO [api].[UserKey]
--([ApiKey], [OperationId], [UserName], [Active])
--VALUES
--(NEWID(), 'C6B1E302-1620-4EF9-B216-19E3A20FF790', 'Kings - Service Account - Zapier - PRODUCTION', 1)


--SELECT *
--FROM [api].[UserKey]
--WHERE [UserName] LIKE 'Kings - Service Account - Zapier - %'
--ORDER BY [UserName], [OperationId]


--INSERT INTO [api].[UserKey]
--([ApiKey], [OperationId], [UserName], [Active])
--VALUES
--('469F9DBF-B92B-4006-8FFC-03BEC64CD296', 'E61BF426-DEF2-4400-B37F-FA0C964BB4AD', 'Kings - Service Account - Zapier - PRODUCTION', 1)


--INSERT INTO [api].[UploadFileApiKey]
--([UploadFileTypeId], [ApiKey])
--VALUES
--  ('F0565578-381A-49E8-80F0-CFECF7E7A095', '3CA97F76-6D9B-42DE-BDDF-93F5D089D25B')
--, ('A81E4300-B743-44F7-85EE-8D08157AE0C8', '469F9DBF-B92B-4006-8FFC-03BEC64CD296')




--------------  IN DESTINATION DB


--CREATE TABLE [stg].[Facebook_Leads](
--	[SessionId] [uniqueidentifier] NULL,
--	[RecordCreateDate] [datetime] NOT NULL DEFAULT GETUTCDATE(),
--	[Processed] [bit] NOT NULL DEFAULT 0,
--	[DynamicData] [xml] NULL,
--	[id] [nvarchar](100) NULL,
--	[created_time] [datetime] NULL,
--	[ad_id] [nvarchar](100) NULL,
--	[ad_name] [nvarchar](100) NULL,
--	[adset_id] [nvarchar](100) NULL,
--	[adset_name] [nvarchar](200) NULL,
--	[campaign_id] [nvarchar](100) NULL,
--	[campaign_name] [nvarchar](200) NULL,
--	[form_id] [nvarchar](100) NULL,
--	[is_organic] [bit] NULL,
--	[email] [nvarchar](200) NULL,
--	[first_name] [nvarchar](100) NULL,
--	[last_name] [nvarchar](100) NULL,
--	[full_name] [nvarchar](200) NULL,
--	[zip_code] [nvarchar](50) NULL,
--	[phone_number] [nvarchar](50) NULL,
--	[City] [nvarchar](200) NULL,
--	[State] [nvarchar](200) NULL,
--	[form_name] [nvarchar](200) NULL
--)


--CREATE TYPE [stg].[Facebook_Leads_Type] AS TABLE(
--	[SessionId] [UNIQUEIDENTIFIER] NULL,
--	[DynamicData] [XML] NULL,
--	[id] [NVARCHAR](100) NULL,
--	[created_time] [DATETIME] NULL,
--	[ad_id] [NVARCHAR](100) NULL,
--	[ad_name] [NVARCHAR](100) NULL,
--	[adset_id] [NVARCHAR](100) NULL,
--	[adset_name] [NVARCHAR](200) NULL,
--	[campaign_id] [NVARCHAR](100) NULL,
--	[campaign_name] [NVARCHAR](200) NULL,
--	[form_id] [NVARCHAR](100) NULL,
--	[is_organic] [BIT] NULL,
--	[email] [NVARCHAR](200) NULL,
--	[first_name] [NVARCHAR](100) NULL,
--	[last_name] [NVARCHAR](100) NULL,
--	[full_name] [NVARCHAR](200) NULL,
--	[zip_code] [NVARCHAR](50) NULL,
--	[phone_number] [NVARCHAR](50) NULL,
--	[City] [nvarchar](200) NULL,
--	[State] [nvarchar](200) NULL,
--	[form_name] [nvarchar](200) NULL
--)
--GO

CREATE PROCEDURE [stg].[Facebook_Leads_Process]  
    @DataTable [stg].[Facebook_Leads_Type] READONLY  
AS  
BEGIN  
  
	DECLARE @finalXml  XML  
  
	BEGIN TRY  
  
		DECLARE @recordCount INT  
		SELECT @recordCount = COUNT(*)  
			FROM @DataTable  
			  
		INSERT INTO [stg].[Facebook_Leads] 
		([SessionId], [DynamicData], [id], [created_time], [ad_id], [ad_name], [adset_id], [adset_name], [campaign_id], [campaign_name],
		[form_id], [is_organic], [email], [first_name], [last_name], [full_name], [zip_code], [phone_number], [City], [State], [form_name])
		SELECT [SessionId], [DynamicData], [id], [created_time], [ad_id], [ad_name], [adset_id], [adset_name], [campaign_id], [campaign_name],
		[form_id], [is_organic], [email], [first_name], [last_name], [full_name], [zip_code], [phone_number], [City], [State], [form_name]  
		FROM @DataTable  
		  
		SET @finalXml = '<Root><ResponseInfo><Success>true</Success><RecordsInserted>' + CAST(@recordCount AS NVARCHAR(10)) + '</RecordsInserted></ResponseInfo></Root>'  
  
	END TRY  
  
  
	BEGIN CATCH  
	  
		-- TODO: Better error messaging here  
		SET @finalXml = '<Root><ResponseInfo><Success>false</Success><ErrorMessage>There was an error attempting to upload this data.</ErrorMessage></ResponseInfo></Root>'  
  
	END CATCH  
  
  
	-- Return response  
	SELECT CAST(@finalXml AS XML)  
  
END
GO
