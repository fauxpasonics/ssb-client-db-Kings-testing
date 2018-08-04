SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROC [etl].[Facebook_Lead_Dynamic_parse] AS



	DECLARE @input TABLE (id NVARCHAR(25) NOT NULL, XmlData XML)
INSERT INTO @input --VALUES (395088657,'<DynamicData><Child1Name>first = TESTING 2last = TESTING FROM SSB</Child1Name><NumberOfChildren>1</NumberOfChildren><Child1Birthday>Mar 01, 2008</Child1Birthday><Child1Gender>Female</Child1Gender></DynamicData>')
SELECT id, dynamicdata FROM Kings.stg.Facebook_Leads
SELECT id,
    XC.value('local-name(.)', 'varchar(50)') Header,
    XC.value('(.)[1]', 'varchar(50)') FieldValue
INTO  #tempsss
FROM
    @input
CROSS APPLY
    XmlData.nodes('/DynamicData/*') AS XT(XC);


DROP TABLE [ods].[Facebook_Leads_Attribute_Values];



        DECLARE @cols AS NVARCHAR(MAX)
              , @query AS NVARCHAR(MAX)

        SELECT @cols = STUFF((   SELECT   ',' + QUOTENAME(Header)
                                 FROM     #tempsss
                                 GROUP BY Header
                                 ORDER BY Header
                                 FOR XML PATH(''), TYPE
                             ).value('.', 'NVARCHAR(MAX)')
                           , 1
                           , 1
                           , ''
                            )

        SET @query = 'SELECT      ID
								,' + @cols + ' 
					  INTO [ods].[Facebook_Leads_Attribute_Values]
					  FROM 
					 (
						SELECT id
								, Header
								,FieldValue
						FROM #Tempsss
					) x
					PIVOT 
					(
						MIN(FieldValue)
						FOR Header IN (' + @cols + ' )
					) p'

        EXECUTE ( @query )

		DROP TABLE ods.Facebook_Lead_Parsed_CustomerData;

		SELECT f.SessionId,
               f.RecordCreateDate,
               f.Processed,
               f.DynamicData,
               f.id AS SubmissionID,
               f.created_time,
               f.ad_id,
               f.ad_name,
               f.adset_id,
               f.adset_name,
               f.campaign_id,
               f.campaign_name,
               f.form_id,
               f.is_organic,
               f.email,
               f.first_name,
               f.last_name,
               f.full_name,
               f.zip_code,
               f.phone_number,
               f.City,
               f.State,
               f.form_name,
			   a.*	
		INTO ods.Facebook_Lead_Parsed_CustomerData
		FROM stg.Facebook_Leads f
		LEFT JOIN [ods].[Facebook_Leads_Attribute_Values]a ON a.id = f.id	
      


GO
