SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE [stg].[FormStack_Submissions_Process]
 @DataTable [stg].[FormStack_Submissions_Type] READONLY
AS
BEGIN

DECLARE @finalXml XML

BEGIN TRY

DECLARE @recordCount INT
SELECT @recordCount = COUNT(*)
FROM @DataTable

INSERT INTO [stg].[FormStack_Submissions]
([SessionId], [DynamicData], [SourceSystem], [SubmissionID],
[FirstName], [LastName], [FullName], [Email], [AddressLine1],
[AddressLine2], [AddressCity], [AddressState], [AddressZip],
[PhoneHome], [PhoneCell], [PhoneBusiness], [FormName],
[SubmissionDateTime], [BirthDate], [URL], [Misc])
SELECT [SessionId], [DynamicData], [SourceSystem], [SubmissionID],
[FirstName], [LastName], [FullName], [Email], [AddressLine1],
[AddressLine2], [AddressCity], [AddressState], [AddressZip],
[PhoneHome], [PhoneCell], [PhoneBusiness], [FormName],
[SubmissionDateTime], [BirthDate], [URL], [Misc]
FROM @DataTable

SET @finalXml =
'<Root><ResponseInfo><Success>true</Success><RecordsInserted>' +
CAST(@recordCount AS NVARCHAR(10)) + '</RecordsInserted></ResponseInfo></Root>'
END TRY


BEGIN CATCH

-- TODO: Better error messaging here
SET @finalXml =
'<Root><ResponseInfo><Success>false</Success><ErrorMessage>There was an error
attempting to upload this data.</ErrorMessage></ResponseInfo></Root>'

END CATCH


-- Return response
SELECT CAST(@finalXml AS XML)

END
GO
