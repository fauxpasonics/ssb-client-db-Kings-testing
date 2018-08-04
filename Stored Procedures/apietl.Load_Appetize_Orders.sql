SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		Ismail Fuseini
-- Create date: 11/09/2016
-- Description:	Load Appetize Orders for APIETLQD
-- =============================================
CREATE PROCEDURE [apietl].[Load_Appetize_Orders]
AS
    BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
        SET NOCOUNT ON;
	
    -- Insert statements for procedure here
        MERGE dbo.Appetize_Orders AS TARGET
        USING
            (
              SELECT    oo.order_id
                      , ooc.id
                      , ooc.name
                      , ooc.email
                      , ooc.mobile
                      , ooc.level
                      , ooc.section
                      , ooc.row
                      , ooc.seat
                      , oo.user_seat_id
                      , oo.order_source
                      , CAST(oo.total AS DECIMAL(13, 4)) AS total
                      , CAST(oo.original_subtotal AS DECIMAL(13, 4)) AS original_subtotal
                      , CAST(oo.tip AS DECIMAL(13, 4)) AS tip
                      , CAST(oo.fee AS DECIMAL(13, 4)) AS fee
                      , CAST(oo.tax AS DECIMAL(13, 4)) AS tax
                      , oo.status
                      , oo.vendor_id
                      , oo.vendor_name
                      , oo.order_mode
                      , oo.payment_type
                      , oo.timezone
                      , CAST(oo.order_date AS DATETIME2) AS order_date
                      , CAST(oo.date_modified AS DATETIME2) AS date_modified
                      , CAST(oo.date_completed AS DATETIME2) AS date_completed
                      , oo.offline_mode
                      , oo.device_token
                      , oo.card_type
              FROM      apietl.Appetize_Orders_orders_1 AS oo
                        INNER JOIN apietl.Appetize_Orders_orders_customer_2 AS ooc ON ooc.ETL__Appetize_Orders_orders_id = oo.ETL__Appetize_Orders_orders_id
            ) AS SOURCE
        ON ( TARGET.order_id = SOURCE.order_id
             AND TARGET.id = SOURCE.id
             AND TARGET.order_date = SOURCE.order_date
           )
        WHEN NOT MATCHED THEN
            INSERT ( order_id
                   , id
                   , name
                   , email
                   , mobile
                   , level
                   , section
                   , row
                   , seat
                   , user_seat_id
                   , order_source
                   , total
                   , original_subtotal
                   , tip
                   , fee
                   , tax
                   , status
                   , vendor_id
                   , vendor_name
                   , order_mode
                   , payment_type
                   , timezone
                   , order_date
                   , date_modified
                   , date_completed
                   , offline_mode
                   , device_token
                   , card_type
                   )
            VALUES ( SOURCE.order_id
                   , SOURCE.id
                   , SOURCE.name
                   , SOURCE.email
                   , SOURCE.mobile
                   , SOURCE.level
                   , SOURCE.section
                   , SOURCE.row
                   , SOURCE.seat
                   , SOURCE.user_seat_id
                   , SOURCE.order_source
                   , SOURCE.total
                   , SOURCE.original_subtotal
                   , SOURCE.tip
                   , SOURCE.fee
                   , SOURCE.tax
                   , SOURCE.status
                   , SOURCE.vendor_id
                   , SOURCE.vendor_name
                   , SOURCE.order_mode
                   , SOURCE.payment_type
                   , SOURCE.timezone
                   , SOURCE.order_date
                   , SOURCE.date_modified
                   , SOURCE.date_completed
                   , SOURCE.offline_mode
                   , SOURCE.device_token
                   , SOURCE.card_type
                   )
        OUTPUT
            $action
          , GETDATE() LOG_DATE
          , Inserted.order_id
          , Inserted.id
          , Inserted.name
          , Inserted.email
          , Inserted.mobile
          , Inserted.level
          , Inserted.section
          , Inserted.row
          , Inserted.seat
          , Inserted.user_seat_id
          , Inserted.order_source
          , Inserted.total
          , Inserted.original_subtotal
          , Inserted.tip
          , Inserted.fee
          , Inserted.tax
          , Inserted.status
          , Inserted.vendor_id
          , Inserted.vendor_name
          , Inserted.order_mode
          , Inserted.payment_type
          , Inserted.timezone
          , Inserted.order_date
          , Inserted.date_modified
          , Inserted.date_completed
          , Inserted.offline_mode
          , Inserted.device_token
          , Inserted.card_type
          , Deleted.order_id
          , Deleted.id
          , Deleted.name
          , Deleted.email
          , Deleted.mobile
          , Deleted.level
          , Deleted.section
          , Deleted.row
          , Deleted.seat
          , Deleted.user_seat_id
          , Deleted.order_source
          , Deleted.total
          , Deleted.original_subtotal
          , Deleted.tip
          , Deleted.fee
          , Deleted.tax
          , Deleted.status
          , Deleted.vendor_id
          , Deleted.vendor_name
          , Deleted.order_mode
          , Deleted.payment_type
          , Deleted.timezone
          , Deleted.order_date
          , Deleted.date_modified
          , Deleted.date_completed
          , Deleted.offline_mode
          , Deleted.device_token
          , Deleted.card_type
            INTO dbo.Audit_Appetize_Orders;

    END;

GO
