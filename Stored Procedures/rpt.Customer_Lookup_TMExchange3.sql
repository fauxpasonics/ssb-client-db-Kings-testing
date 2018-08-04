SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



--EXEC rpt.Customer_Lookup_TMExchange3 '578162'
create  PROCEDURE [rpt].[Customer_Lookup_TMExchange3] (@CustomerId INT)
WITH RECOMPILE
AS
    BEGIN

        SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

        SELECT  ssbid.SSB_CRMSYSTEM_CONTACT_ID
			,DimCustomer.DimCustomerId
			,DimCustomer.FirstName + ' ' + DimCustomer.LastName CustName
              , Tex.season_year
              , Tex.event_name
			  , Event.Team Opponent 
              , Tex.event_time
              , Tex.event_date
              , Tex.section_name
              , Tex.row_name
              , Tex.seat_num
              , Tex.last_seat
              , Tex.num_seats
			  ,CASE WHEN ISNUMERIC(Tex.Orig_purchase_price) = 0 THEN 0 ELSE
					CAST(Tex.Orig_purchase_price AS NUMERIC (18,2) )  * Tex.num_seats end AS Orig_purchase_price
              , Tex.te_purchase_price
			  , Tex.te_purchase_price - CASE WHEN ISNUMERIC(Tex.Orig_purchase_price) = 0 THEN 0 ELSE
					  CAST(Tex.Orig_purchase_price AS NUMERIC) * Tex.num_seats END  AS Difference
        FROM    ods.TM_Tex Tex
                INNER JOIN dbo.DimCustomer DimCustomer WITH ( NOLOCK ) ON DimCustomer.AccountId = CAST(Tex.assoc_acct_id AS VARCHAR(100))
                INNER JOIN dbo.dimcustomerssbid ssbid WITH ( NOLOCK ) ON ssbid.DimCustomerId = DimCustomer.DimCustomerId
				INNER JOIN ods.TM_Evnt Event WITH ( NOLOCK ) ON Event.Event_id = Tex.event_id
        WHERE   Tex.activity_name = 'TE Resale'
                --AND ssbid.SSB_CRMSYSTEM_CONTACT_ID = @Contact_ID
				AND DimCustomer.DimCustomerId = @CustomerId
        ORDER BY DimCustomer.DimCustomerId,Tex.season_year
              , Tex.event_name

    END



GO
