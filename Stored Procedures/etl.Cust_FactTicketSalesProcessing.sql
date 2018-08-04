SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







CREATE PROCEDURE [etl].[Cust_FactTicketSalesProcessing]
    (
      @BatchId INT = 0
    , @LoadDate DATETIME = NULL
    , @Options NVARCHAR(MAX) = NULL
    )
AS
    BEGIN

	

	
---- NEW ----
		
        UPDATE  fts
        SET     fts.DimTicketTypeId = 1
              , fts.DimPlanTypeId = 1
--SELECT DISTINCT PriceCode.PriceCode
        FROM    #stgFactTicketSales fts
                INNER JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
        WHERE   --2015 Rules
				(fts.DimSeasonId = 43
                AND PriceCode.PC3 IN ( 'N', 'L', 'D' )
                AND NOT ( ISNULL(PC3,'') = 'N' AND ISNULL(PC4,'') IN ( '8', '9', 'W' ) ))
				or
				--2016/17 and 17/18 Rules
				(fts.DimSeasonId IN (46,85)
				 AND PC3 = 'N')
				 
				
		

---- RENEWAL ----
		
        UPDATE  fts
        SET     fts.dimtickettypeid = 1
              , fts.dimplantypeid = 2
--select distinct priceCode
        FROM    #stgFactTicketSales fts
                INNER JOIN dbo.DimPriceCode pricecode ON pricecode.DimPriceCodeId = fts.dimpricecodeid
                JOIN dbo.DimPlan dimplan ON dimplan.DimPlanId = fts.dimplanid
        WHERE   --2015 Rules
				(fts.dimseasonid = 43
                AND pricecode.PC3 IN ( 'A', 'B', 'C', 'D', 'K', 'R' )
                AND dimplan.PlanCode NOT IN ( '15KFL15', '15KFL11', '15KFL5' )
                AND NOT ( ISNULL(PC3,'') = 'A' AND ISNULL(PC4, '') = '' )
                AND NOT ( ISNULL(PC3,'') = 'A' AND ISNULL(PC4,'') IN ( 'Y', 'Z' ) )
                AND NOT ( ISNULL(PC3,'') = 'K' AND ISNULL(PC4,'') = 'K' )
                AND NOT ( ISNULL(PC3,'') = 'B' AND ISNULL(PC4,'') IN ( 'K', 'O' ) ))
				or
				--2016/17 and 17/18 Rules
				(fts.DimSeasonId  IN (46,85)
				 AND PC3 IN ( 'K', 'V' ))



---- ADD ON ----
		
        UPDATE  fts
        SET     fts.DimTicketTypeId = 1
              , fts.DimPlanTypeId = 3
--SELECT *
        FROM    #stgFactTicketSales fts
                INNER JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
        WHERE   --2015 Rules
				(fts.DimSeasonId = 43
                AND PriceCode.PC3 = 'T')
				or
				--2016/17 and 17/18 Rules
				(fts.DimSeasonId IN (46,85)
				 AND PC3 = 'T')


---- NO PLAN ----
		
--UPDATE fts
--SET fts.DimTicketTypeId = 1
--, fts.DimPlanTypeId = 4
----SELECT *
--FROM    #stgFactTicketSales fts
--        INNER JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
--WHERE   fts.DimSeasonId = 43
--		AND (
--			 PriceCode.PC3 IN ('D','U')
--		     OR (PriceCode.PC3 = 'V' AND PriceCode.PC4 NOT IN ('E','Z')
--			))
        --AND fts.UpdatedDate >= @FactLoadRunTime


------------------------------------------ Partial - Starting Five ------------------------------------------------------------


----NO PLAN----
		
        UPDATE  fts
        SET     fts.DimTicketTypeId = 2
              , fts.DimPlanTypeId = 5
--SELECT *
        FROM    #stgFactTicketSales fts
                INNER JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
                JOIN dbo.DimPlan DimPlan ON DimPlan.DimPlanId = fts.DimPlanId
        WHERE   fts.DimSeasonId = 43
                AND ( ( PriceCode.PC3 = 'M'
                        AND PriceCode.PC4 IN ( 'N', 'O' )
                      )
                      OR DimPlan.PlanCode = '15KMFIVE'
                    )
        --AND fts.UpdatedDate >= @FactLoadRunTime


------------------------------------------ Partial - Weekend ------------------------------------------------------------



----NO PLAN----
		
        UPDATE  fts
        SET     fts.DimTicketTypeId = 3
              , fts.DimPlanTypeId = 5
--SELECT *
        FROM    #stgFactTicketSales fts
                INNER JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
                JOIN dbo.DimPlan DimPlan ON DimPlan.DimPlanId = fts.DimPlanId
        WHERE   fts.DimSeasonId = 43
                AND ( ( PriceCode.PC3 = 'M'
                        AND PriceCode.PC4 IN ( 'W', '2' )
                      )
                      OR DimPlan.PlanCode = '15KPW'
                    )
        --AND fts.UpdatedDate >= @FactLoadRunTime



------------------------------------------ Partial - Big Game ------------------------------------------------------------

----NO PLAN----
		
        UPDATE  fts
        SET     fts.DimTicketTypeId = 4
              , fts.DimPlanTypeId = 5
--SELECT *
        FROM    #stgFactTicketSales fts
                INNER JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
                JOIN dbo.DimPlan DimPlan ON DimPlan.DimPlanId = fts.DimPlanId
        WHERE   fts.DimSeasonId = 43
                AND ( ( PriceCode.PC3 = 'M'
                        AND PriceCode.PC4 IN ( 'B', '1' )
                      )
                      OR DimPlan.PlanCode = '15KPW'
                    )
        --AND fts.UpdatedDate >= @FactLoadRunTime


------------------------------------------ Half Plan A ------------------------------------------------------------

----NEW----
		
        UPDATE  fts
        SET     fts.DimTicketTypeId = 5
              , fts.DimPlanTypeId = 1
--SELECT *
        FROM    #stgFactTicketSales fts
                INNER JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
                JOIN dbo.DimPlan DimPlan ON DimPlan.DimPlanId = fts.DimPlanId
        WHERE   fts.DimSeasonId = 43
                AND PriceCode.PC3 = 'H'
                AND PriceCode.PC4 = 'N'
                AND DimPlan.PlanCode LIKE '15KHA%'
        --AND fts.UpdatedDate >= @FactLoadRunTime


----RENEWAL----
		
        UPDATE  fts
        SET     fts.DimTicketTypeId = 5
              , fts.DimPlanTypeId = 2
--SELECT *
        FROM    #stgFactTicketSales fts
                INNER JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
                JOIN dbo.DimPlan DimPlan ON DimPlan.DimPlanId = fts.DimPlanId
        WHERE   fts.DimSeasonId = 43
                AND PriceCode.PC3 = 'H'
                AND PriceCode.PC4 IN ( 'R', 'K' )
                AND DimPlan.PlanCode LIKE '15KHA%'
        --AND fts.UpdatedDate >= @FactLoadRunTime


------------------------------------------ Half Plan B ------------------------------------------------------------

----NEW----
		
        UPDATE  fts
        SET     fts.DimTicketTypeId = 6
              , fts.DimPlanTypeId = 1
--SELECT *
        FROM    #stgFactTicketSales fts
                INNER JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
                JOIN dbo.DimPlan DimPlan ON DimPlan.DimPlanId = fts.DimPlanId
        WHERE   fts.DimSeasonId = 43
                AND PriceCode.PC3 = 'H'
                AND PriceCode.PC4 = 'N'
                AND DimPlan.PlanCode LIKE '15KHB%'
        --AND fts.UpdatedDate >= @FactLoadRunTime


----RENEWAL----
		
        UPDATE  fts
        SET     fts.DimTicketTypeId = 6
              , fts.DimPlanTypeId = 2
--SELECT *
        FROM    #stgFactTicketSales fts
                INNER JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
                JOIN dbo.DimPlan DimPlan ON DimPlan.DimPlanId = fts.DimPlanId
        WHERE   fts.DimSeasonId = 43
                AND PriceCode.PC3 = 'H'
                AND PriceCode.PC4 IN ( 'R', 'K' )
                AND DimPlan.PlanCode LIKE '15KHB%'
        --AND fts.UpdatedDate >= @FactLoadRunTime

/*===========================================================================================================================
												2015-Specific Partials
===========================================================================================================================*/

------------------------------------------ Partial - 2 Gm Bobble ------------------------------------------------------------


----PARTIAL----
		
        UPDATE  fts
        SET     fts.DimTicketTypeId = 7
              , fts.DimPlanTypeId = 5
--SELECT *
        FROM    #stgFactTicketSales fts
                INNER JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
                JOIN dbo.DimPlan DimPlan ON DimPlan.DimPlanId = fts.DimPlanId
        WHERE   fts.DimSeasonId = 43
                AND ( ( PriceCode.PC3 = 'B'
                        AND PriceCode.PC4 IN ( 'K', 'O' )
                      )
                      OR DimPlan.PlanCode = '15BOBBLE'
                    )
        --AND fts.UpdatedDate >= @FactLoadRunTime
		
------------------------------------------ Partial - 5 Gm Dec ------------------------------------------------------------

----PARTIAL----
		
        UPDATE  fts
        SET     fts.DimTicketTypeId = 8
              , fts.DimPlanTypeId = 5
--SELECT *
        FROM    #stgFactTicketSales fts
                INNER JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
                JOIN dbo.DimPlan DimPlan ON DimPlan.DimPlanId = fts.DimPlanId
        WHERE   fts.DimSeasonId = 43
                AND DimPlan.PlanCode = '15DECPAS'
		--AND fts.UpdatedDate >= @FactLoadRunTime


------------------------------------------ Partial - 8 Gm Nov ------------------------------------------------------------

----PARTIAL----
		
        UPDATE  fts
        SET     fts.DimTicketTypeId = 9
              , fts.DimPlanTypeId = 5
--SELECT *
        FROM    #stgFactTicketSales fts
                INNER JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
                JOIN dbo.DimPlan DimPlan ON DimPlan.DimPlanId = fts.DimPlanId
        WHERE   fts.DimSeasonId = 43
                AND DimPlan.PlanCode = '15NOVPAS'
		--AND fts.UpdatedDate >= @FactLoadRunTime



------------------------------------------ Partial - Uncategorized ------------------------------------------------------------

----NO PLAN----
		
        UPDATE  fts
        SET     fts.DimTicketTypeId = 10
              , fts.DimPlanTypeId = 5
			  
--SELECT DISTINCT PriceCode
        FROM    #stgFactTicketSales fts
                INNER JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
                JOIN dbo.DimPlan DimPlan ON DimPlan.DimPlanId = fts.DimPlanId
        WHERE   fts.DimSeasonId = 43
                AND ( PriceCode.PC3 = 'F'
                      OR ( PriceCode.PC3 = 'M'
                           AND ISNULL(PriceCode.PC4, '') = ''
                         )
                      OR PriceCode LIKE '__AZ'
                      OR DimPlan.PlanCode IN ( '15KFL15', '15KFL11', '15KFL5' )
                      OR ( PC3 = 'N'
                           AND PC4 IN ( '8', '9' )
                         )
                    )
		--AND fts.UpdatedDate >= @FactLoadRunTime

/*===========================================================================================================================
												2016-Specific Partials
===========================================================================================================================*/

----FLEX----


        UPDATE  fts
        SET     fts.DimTicketTypeId = 20	
              , fts.DimPlanTypeId = 5
        FROM    #stgFactTicketSales fts
                INNER JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
                JOIN dbo.DimPlan DimPlan ON DimPlan.DimPlanId = fts.DimPlanId
        WHERE   fts.dimseasonid in (46,85)
                AND PC3 = 'F'

----HALF----
		
        UPDATE  fts
        SET     fts.DimTicketTypeId = 21
              , fts.DimPlanTypeId = 5

        FROM    #stgFactTicketSales fts
                INNER JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
                JOIN dbo.DimPlan DimPlan ON DimPlan.DimPlanId = fts.DimPlanId
        WHERE   fts.dimseasonid in (46,85)
                AND PC3 = 'H'
----QRTR----
		
        UPDATE  fts
        SET     fts.DimTicketTypeId = 22
              , fts.DimPlanTypeId = 5
        FROM    #stgFactTicketSales fts
                INNER JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
                JOIN dbo.DimPlan DimPlan ON DimPlan.DimPlanId = fts.DimPlanId
        WHERE   fts.dimseasonid in (46,85)
                AND PC3 = 'Q'

----MINI----
		
        UPDATE  fts
        SET     fts.DimTicketTypeId = 23
              , fts.DimPlanTypeId = 5
        FROM   #stgFactTicketSales fts
                INNER JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
                JOIN dbo.DimPlan DimPlan ON DimPlan.DimPlanId = fts.DimPlanId
        WHERE   fts.dimseasonid in (46,85)
                AND PC3 = 'M'

----EXPERIENCE----
	
		
        UPDATE  fts
        SET     fts.DimTicketTypeId = 23
              , fts.DimPlanTypeId = 5
        FROM    #stgFactTicketSales fts
                INNER JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
                JOIN dbo.DimPlan DimPlan ON DimPlan.DimPlanId = fts.DimPlanId
        WHERE   fts.dimseasonid in (46,85)
                AND PC3 = 'X'
				AND PC4 LIKE '[0-9]'

------------------------------------------ Parking ------------------------------------------------------------

----NO PLAN----
		
        UPDATE  fts
        SET     fts.DimTicketTypeId = 11
              , fts.DimPlanTypeId = 4
--SELECT *
        FROM    #stgFactTicketSales fts
                INNER JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
                JOIN dbo.DimPlan DimPlan ON DimPlan.DimPlanId = fts.DimPlanId
        WHERE   fts.DimSeasonId = 43
                AND DimPlan.PlanCode = '15KBPK'
		--AND fts.UpdatedDate >= @FactLoadRunTime



------------------------------------------ Single ------------------------------------------------------------

----NO PLAN----
		
        UPDATE  fts
        SET     fts.DimTicketTypeId = 12
              , fts.DimPlanTypeId = 4
--SELECT DISTINCT PriceCode
        FROM    #stgFactTicketSales fts
                INNER JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
        WHERE   --2015 Rules
				(fts.DimSeasonId = 43
                AND ( ( PriceCode.PC3 IN ( 'A', 'S', 'V', '1', '*', 'Y' )
                        AND ISNULL(PriceCode.PC4, '') = ''
                      )
                      OR ( PriceCode.PC3 = 'P'
                           AND PriceCode.PC4 = 'P'
                         )
                      OR ( PriceCode.PC3 = 'A'
                           AND PriceCode.PC4 IN ( 'Y' )
                         )
                      OR ( LEN(PriceCode.PriceCode) = 2
                           AND fts.CompName = 'Not Comp'
                         )
                      OR PriceCode.PriceCode = '__GY'
                      OR PriceCode.PC3 IN ( 'V', 'P', 'S' )
                      OR ( PriceCode.PC3 = 'K'
                           AND PriceCode.PC4 = 'K'
                         )
                      OR ( PC3 = 'N'
                           AND PC4 = 'W'
                         )
                      OR ( PC3 = 'Z'
                           AND PC4 IN ( '1', 'Z' )
                         )
                      OR ( ( PC1 LIKE '[D-R]'
                             OR PC1 LIKE '[T-Z]'
                           )
                           AND PC2 = '1'
                           AND ISNULL(PC3, '') = ''
                           AND ISNULL(PC4, '') = ''
                         )
                      OR ( PC1 = 'F'
                           AND PC2 = '1'
                           AND PC3 = '2'
                           AND PC4 = '1'
                         )
                      OR ( PC1 = 'N'
                           AND PC2 = '1'
                           AND PC3 = '2'
                           AND PC4 = '2'
                         )
                      OR ( PC1 = 'S'
                           AND PC2 = '2'
                           AND PC3 = 'Y'
                           AND ISNULL(PC4, '') = ''
                         )
                      OR ( PC1 LIKE '[B-Z]'
                           AND PC1 NOT IN ( 'E', 'G', 'J', 'X' )
                           AND PC2 = '2'
                           AND ISNULL(PC3, '') = ''
                           AND ISNULL(PC4, '') = ''
                         )
                      OR ( PC3 = '2'
                           AND PC4 IN ( '1', '2' )
                         )
                      OR ( PC3 = 'G'
                           AND PC4 = '0'
                         )
                    )
				AND NOT ( ISNULL(pc3,'') = '1' AND ISNULL(pc4, '') = '0')		
				AND NOT ( ISNULL(pc3,'') = 'R' AND ISNULL(pc4, '') = 'Z')		
				AND NOT ( ISNULL(pc3,'') IN ( '5', 'B' ) AND ISNULL(pc4, '') = ''))
				OR --2016 Rules
				(fts.DimSeasonId IN (46,85)
				 AND ((PC3 LIKE '[0-9]' AND PC4 LIKE '[0-9]')	--Single Game Archtics
					  OR PC3 = 'V'								--VIP/Internal Single Game
					  OR PC3 = 'Y'								--Single Game Promo/GAM
					  OR PC3 = 'B'								--Broker
					  OR (PC3 = 'X' AND PC4 LIKE '[A-Z]')		--Experience Pass One
					  OR PC3 = 'U' 								--Experience Upgrade
					  OR PC3 = 'P' 								--Partner Add-On
					  --OR PC3 = 'S' 								--Other 3rd Party --Moved to Groups per Tom 20161202
					  OR (PC3 IS NULL AND PC4 IS NULL)          --Host Single Games
					  ))


		



------------------------------------------ Group ------------------------------------------------------------

----NO PLAN----
		
        UPDATE  fts
        SET     fts.DimTicketTypeId = 13
              , fts.DimPlanTypeId = 4
--SELECT distinct pricecode
        FROM    #stgFactTicketSales fts
                INNER JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
        WHERE   --2015 Rules
				(fts.DimSeasonId = 43
                AND ( ISNULL(PC3,'') IN ( 'Z', 'G' )
					  OR ( ISNULL(PC3,'') = '1' AND ISNULL(PC4,'') = '0' )
					  OR ( ISNULL(PC3,'') IN ( '5', 'B' ) AND ISNULL(PC4, '') = '')
					  )
                AND PriceCode <> '__GY'
				AND NOT ( ISNULL(PC3,'') = 'G' AND ISNULL(PC4,'') = '0' ) 
				AND NOT ( ISNULL(PC3,'') = 'Z' AND ISNULL(PC4,'') IN ( '1', 'Z' ) )
				AND NOT ( ISNULL(PC3, '') = '' AND ISNULL(PC4, '') = '' ))
				OR
				--2016 Rules
				(fts.DimSeasonId in (46,85)
				 AND (PC3 = 'G'		--Traditional Group
					  OR PC3 = 'Z'  --Group Promo
					  OR PC3 = 'S'  --Other 3rd Party --Moved from Single per Tom 20161202
					  ))
		


------------------------------------------ Fundraiser ------------------------------------------------------------

----NO PLAN----
		
        UPDATE  fts
        SET     fts.DimTicketTypeId = 14
              , fts.DimPlanTypeId = 4
--SELECT *
        FROM    #stgFactTicketSales fts
                INNER JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
        WHERE   --2015 Rules
				(fts.DimSeasonId = 43
                AND ( ( PriceCode.PC3 = 'E'
                        AND ISNULL(PriceCode.PC4, '') <> ''
                      )
                      OR ( PriceCode IN ( 'ZV', 'ZL' ) )
                    ))
				OR
				--2016/17 Rules
				(fts.DimSeasonId IN (46,85)
				 AND (PC3 = 'E'		--Pre Flip
					  OR PC3 = 'D'	--Post Flip
					  )
				)
		



------------------------------------------ Misc ------------------------------------------------------------

----NO PLAN----
		
        UPDATE  fts
        SET     fts.DimTicketTypeId = 15
              , fts.DimPlanTypeId = 4, fts.updateddate = GETDATE()
--SELECT *
        FROM    dbo.FactTicketSales fts
                INNER JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
        WHERE   fts.DimSeasonId IN (43,46,85)
                AND ISNULL(dimtickettypeID, -1) = -1


------------------------------------------ Suite ------------------------------------------------------------

        UPDATE  fts
        SET     fts.DimTicketTypeId = 18
              , fts.DimPlanTypeId = 6
              , fts.DimSeatTypeId = 7
--SELECT *
        FROM    #stgFactTicketSales fts
                INNER JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
                JOIN dbo.DimPlan DimPlan ON DimPlan.DimPlanId = fts.DimPlanId
        WHERE   fts.DimSeasonId = 53

/****************************************** Fact Tags ****************************************************************/

        UPDATE  f
        SET     f.IsComp = 1
        FROM    #stgFactTicketSales f
        WHERE   f.TotalRevenue = 0
                AND f.IsComp = 0


        UPDATE  f
        SET     f.IsComp = 0
        FROM    #stgFactTicketSales f
        WHERE   (f.TotalRevenue <> 0
                AND f.IsComp = 1)
				OR CompName = 'Not Comp'



        UPDATE  f
        SET     f.IsPlan = 1
              , f.IsPartial = 0
              , f.IsSingleEvent = 0
              , f.IsGroup = 0
        FROM    #stgFactTicketSales f
                INNER JOIN dbo.DimTicketType dtt ON f.DimTicketTypeId = dtt.DimTicketTypeId
        WHERE   dtt.TicketTypeCode = 'FS'


        UPDATE  f
        SET     f.IsPlan = 1
              , f.IsPartial = 1
              , f.IsSingleEvent = 0
              , f.IsGroup = 0
        FROM    #stgFactTicketSales f
                INNER JOIN dbo.DimTicketType dtt ON f.DimTicketTypeId = dtt.DimTicketTypeId
        WHERE   dtt.TicketTypeDesc = 'Partial Plan'



        UPDATE  f
        SET     f.IsPlan = 0
              , f.IsPartial = 0
              , f.IsSingleEvent = 1
              , f.IsGroup = 0
        FROM    #stgFactTicketSales f
                INNER JOIN dbo.DimTicketType dtt ON f.DimTicketTypeId = dtt.DimTicketTypeId
        WHERE   dtt.TicketTypeCode IN ( 'SG', 'F' )


        UPDATE  f
        SET     f.IsPlan = 0
              , f.IsPartial = 0
              , f.IsSingleEvent = 1
              , f.IsGroup = 1
        FROM    #stgFactTicketSales f
                INNER JOIN dbo.DimTicketType dtt ON f.DimTicketTypeId = dtt.DimTicketTypeId
        WHERE   dtt.TicketTypeCode = 'G'



        UPDATE  f
        SET     f.IsPremium = 0
        FROM    #stgFactTicketSales f
                INNER JOIN dbo.DimTicketType dtt ON f.DimTicketTypeId = dtt.DimTicketTypeId
                INNER JOIN dbo.DimSeatType dst ON f.DimSeatTypeId = dst.DimSeatTypeId
        WHERE   dst.SeatTypeCode IN ( 'LOWER', 'UPPER', 'SRO' )


        UPDATE  f
        SET     f.IsPremium = 1
        FROM    #stgFactTicketSales f
                INNER JOIN dbo.DimSeatType dst ON f.DimSeatTypeId = dst.DimSeatTypeId
        WHERE   dst.SeatTypeCode NOT IN ( 'LOWER', 'UPPER', 'SRO' )



        UPDATE  f
        SET     f.IsRenewal = 1
        FROM    #stgFactTicketSales f
                INNER JOIN dbo.DimPlanType dpt ON f.DimPlanTypeId = dpt.DimPlanTypeId
        WHERE   dpt.PlanTypeCode = 'RENEW'


        UPDATE  f
        SET     f.IsRenewal = 0
        FROM    #stgFactTicketSales f
                INNER JOIN dbo.DimPlanType dpt ON f.DimPlanTypeId = dpt.DimPlanTypeId
        WHERE   dpt.PlanTypeCode <> 'RENEW'

/****************************************** Seat Type ****************************************************************/

        UPDATE  fts
        SET     DimseatTypeId = 1
        FROM    #stgFactTicketSales fts
                INNER JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
                JOIN dbo.DimPlan DimPlan ON DimPlan.DimPlanId = fts.DimPlanId
        WHERE   fts.DimSeasonId IN ( 53, 43 )
                AND PC1 IN ( 'A' )


        UPDATE  fts
        SET     DimseatTypeId = 2
        FROM    #stgFactTicketSales fts
                INNER JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
                JOIN dbo.DimPlan DimPlan ON DimPlan.DimPlanId = fts.DimPlanId
        WHERE   fts.DimSeasonId IN ( 53, 43 )
                AND ( PC1 IN ( 'B' )
                      OR PC1 = 'D'
                      AND PC2 = '1'
                    )

        UPDATE  fts
        SET     DimseatTypeId = 3
        FROM    #stgFactTicketSales fts
                INNER JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
                JOIN dbo.DimPlan DimPlan ON DimPlan.DimPlanId = fts.DimPlanId
        WHERE   fts.DimSeasonId IN ( 53, 43 )
                AND ( PC1 IN ( 'C' )
                      OR PC1 = 'D'
                      AND PC2 = '2'
                    )

        UPDATE  fts
        SET     DimseatTypeId = 4
        FROM    #stgFactTicketSales fts
                INNER JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
                JOIN dbo.DimPlan DimPlan ON DimPlan.DimPlanId = fts.DimPlanId
        WHERE   fts.DimSeasonId IN ( 53, 43 )
                AND PC1 IN ( 'E' )
		        
        UPDATE  fts
        SET     DimSeatTypeId = 5
        FROM    #stgFactTicketSales fts
                INNER JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
                JOIN dbo.DimPlan DimPlan ON DimPlan.DimPlanId = fts.DimPlanId
        WHERE   fts.DimSeasonId IN ( 53, 43 )
                AND ( ( PC1 LIKE '[F-R]'
                        OR PC1 LIKE '[T-Z]'
                      )
                      AND PC2 = '1'
                    ) 
		
        UPDATE  fts
        SET     DimSeatTypeId = 6
        FROM    #stgFactTicketSales fts
                INNER JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
                JOIN dbo.DimPlan DimPlan ON DimPlan.DimPlanId = fts.DimPlanId
        WHERE   fts.DimSeasonId IN ( 53, 43 )
                AND ( ( PC1 LIKE '[J-R]'
                        OR PC1 LIKE '[T-Z]'
                      )
                      AND PC2 = '2'
                    )

        UPDATE  fts
        SET     DimSeatTypeId = 7
        FROM    #stgFactTicketSales fts
                INNER JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
                JOIN dbo.DimPlan DimPlan ON DimPlan.DimPlanId = fts.DimPlanId
        WHERE   fts.DimSeasonId IN ( 53, 43 )
                AND PC1 = 'S'
                AND PC2 <> '2'

        UPDATE  fts
        SET     DimSeatTypeId = 8
        FROM    #stgFactTicketSales fts
                INNER JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
                JOIN dbo.DimPlan DimPlan ON DimPlan.DimPlanId = fts.DimPlanId
        WHERE   fts.DimSeasonId IN ( 53, 43 )
                AND ( PC1 LIKE '[F-I]'
                      AND PC2 = '2'
                    ) 

        UPDATE  fts
        SET     DimSeatTypeId = 8
        FROM    #stgFactTicketSales fts
                INNER JOIN dbo.DimPriceCode PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
                JOIN dbo.DimPlan DimPlan ON DimPlan.DimPlanId = fts.DimPlanId
        WHERE   fts.DimSeasonId IN ( 53, 43 )
                AND PC1 = 'S'
                AND PC2 = '2' 

                      

    END
























































GO
