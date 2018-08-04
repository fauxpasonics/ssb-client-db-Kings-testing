SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE PROC [etl].[FormStack_Dynamic_parse] AS



	DECLARE @input TABLE (SubmissionID NVARCHAR(25) NOT NULL, XmlData XML)
INSERT INTO @input --VALUES (395088657,'<DynamicData><Child1Name>first = TESTING 2last = TESTING FROM SSB</Child1Name><NumberOfChildren>1</NumberOfChildren><Child1Birthday>Mar 01, 2008</Child1Birthday><Child1Gender>Female</Child1Gender></DynamicData>')
SELECT SubmissionID, dynamicdata FROM Kings.stg.FormStack_Submissions
SELECT SubmissionID,
    XC.value('local-name(.)', 'varchar(50)') Header,
    XC.value('(.)[1]', 'varchar(50)') FieldValue
INTO  #temp
FROM
    @input
CROSS APPLY
    XmlData.nodes('/DynamicData/*') AS XT(XC);


DROP TABLE [ods].[FormStack_Attribute_Values];



        DECLARE @cols AS NVARCHAR(MAX)
              , @query AS NVARCHAR(MAX)

        SELECT @cols = STUFF((   SELECT   ',' + QUOTENAME(Header)
                                 FROM     #temp
                                 GROUP BY Header
                                 ORDER BY Header
                                 FOR XML PATH(''), TYPE
                             ).value('.', 'NVARCHAR(MAX)')
                           , 1
                           , 1
                           , ''
                            )

        SET @query = 'SELECT      SubmissionID
								,' + @cols + ' 
					  INTO [ods].[FormStack_Attribute_Values]
					  FROM 
					 (
						SELECT SubmissionID
								, Header
								,FieldValue
						FROM #Temp
					) x
					PIVOT 
					(
						MIN(FieldValue)
						FOR Header IN (' + @cols + ' )
					) p'

        EXECUTE ( @query )

		DROP TABLE ods.Formstack_Parsed_CustomerData;

		SELECT f.SessionId,
               f.RecordCreateDate,
               f.Processed,
               f.DynamicData,
               f.SourceSystem,
               f.SubmissionID AS SubmissonsID,
               f.FirstName,
               f.LastName,
               f.FullName,
               f.Email,
               f.AddressLine1,
               f.AddressLine2,
               f.AddressCity,
               f.AddressState,
               f.AddressZip,
               f.PhoneHome,
               f.PhoneCell,
               f.PhoneBusiness,
               f.FormName,
               f.SubmissionDateTime,
               f.BirthDate,
               f.URL,
               f.Misc,
			   a.*	
		INTO ods.Formstack_Parsed_CustomerData
		FROM stg.FormStack_Submissions f
		LEFT JOIN  [ods].[FormStack_Attribute_Values]a ON a.submissionID = f.SubmissionID	
      


GO
