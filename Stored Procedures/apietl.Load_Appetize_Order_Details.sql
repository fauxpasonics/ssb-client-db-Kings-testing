SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- =============================================
--  Load Appetize Orders sProc
-- =============================================

CREATE PROCEDURE [apietl].[Load_Appetize_Order_Details]
AS
    MERGE dbo.Appetize_Order_Details AS TARGET
    USING
        (
          SELECT    oo.order_id
                  , ooi.id
                  , ooi.name
                  , CAST(ooi.cost AS NUMERIC(13, 4)) AS cost
                  , ooi.type
                  , ooi.row_id
                  , CAST(ooi.quantity AS NUMERIC(13, 4)) AS quantity
                  , ooi.add_price_override
                  , ooiai.product_id AS [addtional_item_product_id]
                  , ooiai.name AS [addtional_item_name]
                  , CAST(ooiai.cost AS NUMERIC(13, 4)) AS addtional_item_cost
          FROM      apietl.Appetize_Orders_orders_items_2 AS ooi
                    INNER JOIN apietl.Appetize_Orders_orders_1 AS oo ON oo.ETL__Appetize_Orders_orders_id = ooi.ETL__Appetize_Orders_orders_id
                    LEFT JOIN apietl.Appetize_Orders_orders_items_additional_items_3 AS ooiai ON ooiai.ETL__Appetize_Orders_orders_items_id = ooi.ETL__Appetize_Orders_orders_items_id
        ) AS SOURCE
    ON ( TARGET.order_id = SOURCE.order_id
         AND TARGET.id = SOURCE.id
       )
    WHEN NOT MATCHED THEN
        INSERT ( order_id
               , id
               , name
               , cost
               , type
               , row_id
               , quantity
               , add_price_override
               , addtional_item_product_id
               , addtional_item_name
               , addtional_item_cost
               )
        VALUES ( SOURCE.order_id
               , SOURCE.id
               , SOURCE.name
               , SOURCE.cost
               , SOURCE.type
               , SOURCE.row_id
               , SOURCE.quantity
               , SOURCE.add_price_override
               , SOURCE.addtional_item_product_id
               , SOURCE.addtional_item_name
               , SOURCE.addtional_item_cost
               )
    OUTPUT
        $action
      , GETDATE() LOG_DATE
      , Inserted.order_id
      , Inserted.id
      , Inserted.name
      , Inserted.cost
      , Inserted.type
      , Inserted.row_id
      , Inserted.quantity
      , Inserted.add_price_override
      , Inserted.addtional_item_product_id
      , Inserted.addtional_item_name
      , Inserted.addtional_item_cost
	  , Deleted.order_id
      , Deleted.id
      , Deleted.name
      , Deleted.cost
      , Deleted.type
      , Deleted.row_id
      , Deleted.quantity
      , Deleted.add_price_override
      , Deleted.addtional_item_product_id
      , Deleted.addtional_item_name
      , Deleted.addtional_item_cost
        INTO dbo.Audit_Appetize_Order_Details;





GO
