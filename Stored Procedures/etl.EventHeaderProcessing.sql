SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		Fuseini, Ismail
-- Create date:  16/05/03
-- =============================================
CREATE PROCEDURE [etl].[EventHeaderProcessing]
    (
      @BatchId INT = 0
    , @LoadDate DATETIME = NULL
    , @Options NVARCHAR(MAX) = NULL
    )
AS
    BEGIN

	/*
		Kings Events 2015-16
		Season - 43
		FEP - 52
		Parking - 42
	*/

	--Preseason and Regular Season
        DECLARE @EventHeaderStart INT;
        SET @EventHeaderStart = 0;
        UPDATE  dbo.DimEvent
        SET     @EventHeaderStart = DimEventHeaderId = @EventHeaderStart + 1
        WHERE   DimSeasonId = 43;

	--Parking
        DECLARE @EventHeaderStartPark INT;
        SET @EventHeaderStartPark = 0;
        UPDATE  dbo.DimEvent
        SET     @EventHeaderStartPark = DimEventHeaderId = @EventHeaderStartPark
                + 1
        WHERE   DimSeasonId = 42;


	--Fan Experience Packages
        DECLARE @EventHeaderStartFEP INT;
        SET @EventHeaderStartFEP = 0;
        UPDATE  dbo.DimEvent
        SET     @EventHeaderStartFEP = DimEventHeaderId = @EventHeaderStartFEP
                + 1
        WHERE   DimSeasonId = 52;

	/*
		Kings Events 2014-15
					Season - 20
		Parking - 21
		FEP - 30
	*/

	--Preseason and Regular Season
        DECLARE @1EventHeaderStart INT;
        SET @1EventHeaderStart = 265;
        UPDATE  dbo.DimEvent
        SET     @1EventHeaderStart = DimEventHeaderId = @1EventHeaderStart + 1
        WHERE   DimSeasonId = 20;


	--Parking
        DECLARE @1EventHeaderStartPark INT;
        SET @1EventHeaderStartPark = 265;
        UPDATE  dbo.DimEvent
        SET     @1EventHeaderStartPark = DimEventHeaderId = @1EventHeaderStartPark
                + 1
        WHERE   DimSeasonId = 21;


	--Fan Experience Packages
        DECLARE @1EventHeaderStartFEP INT;
        SET @1EventHeaderStartFEP = 265;
        UPDATE  dbo.DimEvent
        SET     @1EventHeaderStartFEP = DimEventHeaderId = @1EventHeaderStartFEP
                + 1
        WHERE   DimSeasonId = 30;

		
	/*
		Kings Events 2013-14
				Season - 9
		Parking - 8
		FEP - 18
	
	*/

	--Preseason and Regular Season
        DECLARE @2EventHeaderStart INT;
        SET @2EventHeaderStart = 221;
        UPDATE  dbo.DimEvent
        SET     @2EventHeaderStart = DimEventHeaderId = @2EventHeaderStart + 1
        WHERE   DimSeasonId = 9;

	--Parking
        DECLARE @2EventHeaderStartPark INT;
        SET @2EventHeaderStartPark = 221;
        UPDATE  dbo.DimEvent
        SET     @2EventHeaderStartPark = DimEventHeaderId = @2EventHeaderStartPark
                + 1
        WHERE   DimSeasonId = 8;

	--Fan Experience Packages
        DECLARE @2EventHeaderStartFEP INT;
        SET @2EventHeaderStartFEP = 221;
        UPDATE  dbo.DimEvent
        SET     @2EventHeaderStartFEP = DimEventHeaderId = @2EventHeaderStartFEP
                + 1
        WHERE   DimSeasonId = 18;


		
	/*
		Kings Events 2012-13
		Season - 19
		Parking - 1
		FEP - 18
		Suites - 3
	*/

	--Preseason and Regular Season
        DECLARE @3EventHeaderStart INT;
        SET @3EventHeaderStart = 177;
        UPDATE  dbo.DimEvent
        SET     @3EventHeaderStart = DimEventHeaderId = @3EventHeaderStart + 1
        WHERE   DimSeasonId = 19;

		--Suites
        DECLARE @3EventHeaderStartSuite INT;
        SET @3EventHeaderStartSuite = 177;
        UPDATE  dbo.DimEvent
        SET     @3EventHeaderStartSuite = DimEventHeaderId = @3EventHeaderStartSuite
                + 1
        WHERE   DimSeasonId = 3;

	--Parking
        DECLARE @3EventHeaderStartPark INT;
        SET @3EventHeaderStartPark = 177;
        UPDATE  dbo.DimEvent
        SET     @3EventHeaderStartPark = DimEventHeaderId = @3EventHeaderStartPark
                + 1
        WHERE   DimSeasonId = 1;


	--Fan Experience Packages
        DECLARE @3EventHeaderStartFEP INT;
        SET @3EventHeaderStartFEP = 177;
        UPDATE  dbo.DimEvent
        SET     @3EventHeaderStartFEP = DimEventHeaderId = @3EventHeaderStartFEP
                + 1
        WHERE   DimSeasonId = 18;

	/*
		Sleep Train Arena Events 2015
		Using the MajoryCategoryTM for Event Groupings

	*/
		-- Arts
        UPDATE  dbo.DimEvent
        SET     DimEventHeaderId = 43
        WHERE   DimSeasonId IN ( 17, 29 )
                AND YEAR(EventDate) >= 2015
                AND YEAR(EventDate) < 2016;

		-- Concerts
        UPDATE  dbo.DimEvent
        SET     DimEventHeaderId = 44
        WHERE   DimSeasonId = 55;

		-- Family
        UPDATE  dbo.DimEvent
        SET     DimEventHeaderId = 45
        WHERE   DimSeasonId IN ( 22, 23, 24, 35, 41, 45, 48, 51 );

		-- Sports
        UPDATE  dbo.DimEvent
        SET     DimEventHeaderId = 46
        WHERE   DimSeasonId IN ( 36, 38, 49, 50, 31, 57, 40, 47 );


	/*
		Sleep Train Arena Events 2014
		Using the MajoryCategoryTM for Event Groupings

	*/
		-- Arts
        UPDATE  dbo.DimEvent
        SET     DimEventHeaderId = 330
        WHERE   DimSeasonId IN ( 17 )
                AND YEAR(EventDate) >= 2014
                AND YEAR(EventDate) < 2015;

		-- Concerts
        UPDATE  dbo.DimEvent
        SET     DimEventHeaderId = 331
        WHERE   DimSeasonId IN ( 4, 32, 37 );

		-- Family
        UPDATE  dbo.DimEvent
        SET     DimEventHeaderId = 332
        WHERE   DimSeasonId IN ( 13, 25, 26, 28 );

		-- Sports
        UPDATE  dbo.DimEvent
        SET     DimEventHeaderId = 333
        WHERE   DimSeasonId IN ( 27 );


			/*
		Sleep Train Arena Events 2013
		Using the MajoryCategoryTM for Event Groupings

	*/
		-- Arts
        UPDATE  dbo.DimEvent
        SET     DimEventHeaderId = 334
        WHERE   DimSeasonId IN ( 17 )
                AND YEAR(EventDate) >= 2013
                AND YEAR(EventDate) < 2014;

		-- Concerts
        UPDATE  dbo.DimEvent
        SET     DimEventHeaderId = 335
        WHERE   DimSeasonId = 55;

		-- Family
        UPDATE  dbo.DimEvent
        SET     DimEventHeaderId = 336
        WHERE   DimSeasonId IN ( 6 );

		-- Sports
        UPDATE  dbo.DimEvent
        SET     DimEventHeaderId = 337
        WHERE   DimSeasonId IN ( 36, 38, 49, 50, 31, 57, 40, 47 );


			/*
		Sleep Train Arena Events 2012
		Using the MajoryCategoryTM for Event Groupings

	*/
		-- Concerts
        UPDATE  dbo.DimEvent
        SET     DimEventHeaderId = 321
        WHERE   DimSeasonId IN ( 5, 17 )
                AND YEAR(EventDate) >= 2012
                AND YEAR(EventDate) < 2013
				AND MajorCategoryTM = 'Concerts';

    END;
GO
