SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE PROCEDURE [etl].[Appetize_Load_Items]
AS
BEGIN

    MERGE ods.Appetize_Items AS TARGET
    USING
        (
SELECT 
TRY_CAST(i.id AS INT) item_id, TRY_CAST(parentItemId AS INT) parentItemId, TRY_CAST(unique_id AS INT) unique_id, TRY_CAST(vendor_id AS INT) vendor_id, TRY_CAST(subvendor_id AS INT) subvendor_id, TRY_CAST(assignment_id AS INT) assignment_id, TRY_CAST(category_group_id AS INT) category_group_id, category_name, i.name, description, TRY_CAST(show_desc AS BIT) show_desc, TRY_CAST(cost AS NUMERIC(18,6)) cost, i.type, TRY_CAST(is_alcohol AS BIT) is_alcohol, TRY_CAST(status AS INT) status, TRY_CAST(restrict_single_modifier AS BIT) restrict_single_modifier, TRY_CAST(track_inventory AS BIT) track_inventory, TRY_CAST(inventory_amount AS INT) inventory_amount, TRY_CAST(sold_out AS BIT) sold_out, TRY_CAST(mark_as_sold_out AS BIT) mark_as_sold_out, TRY_CAST(_sold_out AS BIT) _sold_out, TRY_CAST(show_in_browse AS BIT) show_in_browse, is_clickable, TRY_CAST(require_additional AS BIT) require_additional, TRY_CAST(original_bundle_cost AS DECIMAL(18,6)) original_bundle_cost, TRY_CAST(add_price_override AS BIT) add_price_override, TRY_CAST(upsell_item_id AS INT) upsell_item_id, barcode, sku, TRY_CAST(active_start AS DATETIME) active_start, TRY_CAST(active_end AS DATETIME) active_end, TRY_CAST(wizard AS INT) wizard, TRY_CAST(isOpenPrice AS BIT) isOpenPrice, TRY_CAST(isWeightItem AS BIT) isWeightItem, weightUnits, TRY_CAST(last_update AS DATETIME) last_update, tax_group, item_group, NULL secondary_item_group
FROM      apietl.Appetize_Items_0 AS i
INNER JOIN apietl.Appetize_Items_item_group_1 AS iig ON iig.ETL__Appetize_Items_id = i.ETL__Appetize_Items_id
          --SELECT    i.id AS item_id
          --        , i.parentItemId
          --        , i.unique_id
          --        , i.vendor_id
          --        , i.subvendor_id
          --        , i.assignment_id
          --        , i.category_group_id
          --        , i.category_name
          --        , i.name
          --        , i.description
          --        , i.show_desc
          --        , CAST(i.cost AS DECIMAL(13, 4)) AS cost
          --        , i.type
          --        , i.is_alcohol
          --        , i.status
          --        , i.restrict_single_modifier
          --        , i.track_inventory
          --        , i.inventory_amount
          --        , i.sold_out
          --        , i.mark_as_sold_out
          --        , i._sold_out
          --        , i.show_in_browse
          --        , i.is_clickable
          --        , i.require_additional
          --        , i.original_bundle_cost
          --        , i.add_price_override
          --        , i.upsell_item_id
          --        , i.barcode
          --        , i.sku
          --        , i.active_start
          --        , i.active_end
          --        , i.wizard
          --        , i.isOpenPrice
          --        , i.isWeightItem
          --        , i.weightUnits
          --        , CAST(i.last_update AS DATETIME2) AS last_update
          --        , i.tax_group
          --        , NULL AS item_group
          --        , NULL AS secondary_item_group
          --FROM      apietl.i_0 AS i
          --          INNER JOIN apietl.i_item_group_1 AS iig ON iig.i_id = i.i_id
          --        --  LEFT JOIN apietl.i_item_group_2_1 AS iig2 ON iig2.i_id = i.i_id
        ) AS SOURCE
    ON ( TARGET.item_id = SOURCE.item_id
         AND TARGET.vendor_id = SOURCE.vendor_id
       )
    WHEN NOT MATCHED BY TARGET THEN
        INSERT (
			   ETL__UpdatedDate
			   , item_id
               , parentItemId
               , unique_id
               , vendor_id
               , subvendor_id
               , assignment_id
               , category_group_id
               , category_name
               , name
               , description
               , show_desc
               , cost
               , type
               , is_alcohol
               , status
               , restrict_single_modifier
               , track_inventory
               , inventory_amount
               , sold_out
               , mark_as_sold_out
               , _sold_out
               , show_in_browse
               , is_clickable
               , require_additional
               , original_bundle_cost
               , add_price_override
               , upsell_item_id
               , barcode
               , sku
               , active_start
               , active_end
               , wizard
               , isOpenPrice
               , isWeightItem
               , weightUnits
               , last_update
               , tax_group
               , item_group
               , secondary_item_group
               )
        VALUES ( 
			   GETDATE()
			   , SOURCE.item_id
               , SOURCE.parentItemId
               , SOURCE.unique_id
               , SOURCE.vendor_id
               , SOURCE.subvendor_id
               , SOURCE.assignment_id
               , SOURCE.category_group_id
               , SOURCE.category_name
               , SOURCE.name
               , SOURCE.description
               , SOURCE.show_desc
               , SOURCE.cost
               , SOURCE.type
               , SOURCE.is_alcohol
               , SOURCE.status
               , SOURCE.restrict_single_modifier
               , SOURCE.track_inventory
               , SOURCE.inventory_amount
               , SOURCE.sold_out
               , SOURCE.mark_as_sold_out
               , SOURCE._sold_out
               , SOURCE.show_in_browse
               , SOURCE.is_clickable
               , SOURCE.require_additional
               , SOURCE.original_bundle_cost
               , SOURCE.add_price_override
               , SOURCE.upsell_item_id
               , SOURCE.barcode
               , SOURCE.sku
               , SOURCE.active_start
               , SOURCE.active_end
               , SOURCE.wizard
               , SOURCE.isOpenPrice
               , SOURCE.isWeightItem
               , SOURCE.weightUnits
               , SOURCE.last_update
               , SOURCE.tax_group
               , SOURCE.item_group
               , SOURCE.secondary_item_group
               );

    --OUTPUT
    --    $action
    --  , GETDATE() LOG_DATE
    --  , Inserted.item_id
    --  , Inserted.parentItemId
    --  , Inserted.unique_id
    --  , Inserted.vendor_id
    --  , Inserted.subvendor_id
    --  , Inserted.assignment_id
    --  , Inserted.category_group_id
    --  , Inserted.category_name
    --  , Inserted.name
    --  , Inserted.description
    --  , Inserted.show_desc
    --  , Inserted.cost
    --  , Inserted.type
    --  , Inserted.is_alcohol
    --  , Inserted.status
    --  , Inserted.restrict_single_modifier
    --  , Inserted.track_inventory
    --  , Inserted.inventory_amount
    --  , Inserted.sold_out
    --  , Inserted.mark_as_sold_out
    --  , Inserted._sold_out
    --  , Inserted.show_in_browse
    --  , Inserted.is_clickable
    --  , Inserted.require_additional
    --  , Inserted.original_bundle_cost
    --  , Inserted.add_price_override
    --  , Inserted.upsell_item_id
    --  , Inserted.barcode
    --  , Inserted.sku
    --  , Inserted.active_start
    --  , Inserted.active_end
    --  , Inserted.wizard
    --  , Inserted.isOpenPrice
    --  , Inserted.isWeightItem
    --  , Inserted.weightUnits
    --  , Inserted.last_update
    --  , Inserted.tax_group
    --  , Inserted.item_group
    --  , Inserted.secondary_item_group
    --  , Deleted.item_id
    --  , Deleted.parentItemId
    --  , Deleted.unique_id
    --  , Deleted.vendor_id
    --  , Deleted.subvendor_id
    --  , Deleted.assignment_id
    --  , Deleted.category_group_id
    --  , Deleted.category_name
    --  , Deleted.name
    --  , Deleted.description
    --  , Deleted.show_desc
    --  , Deleted.cost
    --  , Deleted.type
    --  , Deleted.is_alcohol
    --  , Deleted.status
    --  , Deleted.restrict_single_modifier
    --  , Deleted.track_inventory
    --  , Deleted.inventory_amount
    --  , Deleted.sold_out
    --  , Deleted.mark_as_sold_out
    --  , Deleted._sold_out
    --  , Deleted.show_in_browse
    --  , Deleted.is_clickable
    --  , Deleted.require_additional
    --  , Deleted.original_bundle_cost
    --  , Deleted.add_price_override
    --  , Deleted.upsell_item_id
    --  , Deleted.barcode
    --  , Deleted.sku
    --  , Deleted.active_start
    --  , Deleted.active_end
    --  , Deleted.wizard
    --  , Deleted.isOpenPrice
    --  , Deleted.isWeightItem
    --  , Deleted.weightUnits
    --  , Deleted.last_update
    --  , Deleted.tax_group
    --  , Deleted.item_group
    --  , Deleted.secondary_item_group
    --    INTO dbo.Audit_Appetize_Items;

END



GO
