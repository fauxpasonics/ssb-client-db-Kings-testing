SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- =============================================
-- Author:		Ismail Fuseini
-- Create date: 11/07/2016
-- Description:	Executes Order Stored Procedures
-- =============================================
CREATE PROCEDURE [apietl].[Load_Appetize_Orders_Combo]
AS
    BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
        SET NOCOUNT ON;

		SELECT GETDATE()

      EXEC apietl.[Load_Appetize_Orders];

      EXEC apietl.[Load_Appetize_Order_Details];

    END;




GO
