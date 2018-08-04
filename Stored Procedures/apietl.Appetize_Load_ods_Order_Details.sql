SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE PROCEDURE [apietl].[Appetize_Load_ods_Order_Details]
AS
    MERGE ods.Appetize_Order_Details AS TARGET
    USING
        (
			SELECT
				TRY_CAST(oo.order_id AS INT) order_id, TRY_CAST(ooi.id AS INT) id, ooi.name, TRY_CAST(ooi.cost AS DECIMAL(18, 6)) cost, type, TRY_CAST(ooi.row_id AS INT) row_id,
				TRY_CAST(ooi.quantity AS DECIMAL(18, 6)) quantity, TRY_CAST(ooi.add_price_override AS BIT) add_price_override
				, CAST(NULL AS INT) AS [addtional_item_product_id]
				, CAST(NULL AS NVARCHAR(255)) AS [addtional_item_name]
				, CAST(NULL AS DECIMAL(18,6)) AS addtional_item_cost
			FROM
				apietl.o_orders_items_2 AS ooi
				INNER JOIN apietl.o_orders_1 AS oo ON oo.o_orders_id = ooi.o_orders_id
        ) AS SOURCE
    ON ( TARGET.order_id = SOURCE.order_id
         AND TARGET.id = SOURCE.id
       )
    WHEN NOT MATCHED THEN
        INSERT ( ETL__UpdatedDate
			   , order_id
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
        VALUES ( GETDATE()
			   , SOURCE.order_id
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
;

   -- OUTPUT
   --     $action
   --   , GETDATE() LOG_DATE
   --   , Inserted.order_id
   --   , Inserted.id
   --   , Inserted.name
   --   , Inserted.cost
   --   , Inserted.type
   --   , Inserted.row_id
   --   , Inserted.quantity
   --   , Inserted.add_price_override
   --   , Inserted.addtional_item_product_id
   --   , Inserted.addtional_item_name
   --   , Inserted.addtional_item_cost
	  --, Deleted.order_id
   --   , Deleted.id
   --   , Deleted.name
   --   , Deleted.cost
   --   , Deleted.type
   --   , Deleted.row_id
   --   , Deleted.quantity
   --   , Deleted.add_price_override
   --   , Deleted.addtional_item_product_id
   --   , Deleted.addtional_item_name
   --   , Deleted.addtional_item_cost
   --     INTO dbo.Audit_Appetize_Order_Details;







GO
