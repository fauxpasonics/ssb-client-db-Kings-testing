SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- =============================================
-- Author:		Ismail Fuseini
-- Create date: 11/14/2016
-- Description:	Load sProc for Appetize Vendors
-- =============================================
CREATE PROCEDURE [apietl].[Load_Appetize_Vendors]
AS
    BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
        SET NOCOUNT ON;

    -- Insert statements for procedure here
        MERGE dbo.Appetize_Vendors AS TARGET
        USING
            (
              SELECT    v.id
                      , v.username
                      , v.printer_ip
                      , v.venue_id
                      , v.name
                      , v.staff_members
                      , v.order_capacity
                      , v.fast_pass_lane
                      , v.vendor_status
                      , v.status
                      , v.status_description
                      , v.drink_limit
                      , v.promo_enabled
                      , v.wait_m
                      , v.welcome_text
                      , v.pickup_location
                      , v.additional_info
                      , v.first_screen
                      , v.login_required
                      , v.tip_enabled
                      , v.fee
                      , v.fee_in_percent
                      , v.convince_fee
                      , v.fee_text
                      , v.image_url
                      , v.vendor_type
                      , v.seat_confirmation
                      , v.food_count
                      , v.drink_count
                      , v.mixer_count
                      , v.mixer_built_count
                      , v.merch_count
                      , v.bundle_count
                      , v.collected_tax_rate
                      , v.tax_on_total
                      , v.tax_on_tip
                      , v.tax_on_fee
                      , v.tax_charge_after_discount
                      , v.quick_order_view
                      , v.quick_order_image
                      , vg.name AS group_name
                      , v.is_drink_limit_per_event
              FROM      apietl.Appetize_Vendor_0 AS v
                        LEFT JOIN apietl.Appetize_Vendor_groups_1 AS vg ON vg.ETL__Appetize_Vendor_id = v.ETL__Appetize_Vendor_id
            ) AS SOURCE
        ON ( TARGET.id = SOURCE.id
             AND TARGET.name = SOURCE.name
           )
        WHEN NOT MATCHED THEN
            INSERT ( id
                   , username
                   , printer_ip
                   , venue_id
                   , name
                   , staff_members
                   , order_capacity
                   , fast_pass_lane
                   , vendor_status
                   , status
                   , status_description
                   , drink_limit
                   , promo_enabled
                   , wait_m
                   , welcome_text
                   , pickup_location
                   , additional_info
                   , first_screen
                   , login_required
                   , tip_enabled
                   , fee
                   , fee_in_percent
                   , convince_fee
                   , fee_text
                   , image_url
                   , vendor_type
                   , seat_confirmation
                   , food_count
                   , drink_count
                   , mixer_count
                   , mixer_built_count
                   , merch_count
                   , bundle_count
                   , collected_tax_rate
                   , tax_on_total
                   , tax_on_tip
                   , tax_on_fee
                   , tax_charge_after_discount
                   , quick_order_view
                   , quick_order_image
                   , group_name
                   , is_drink_limit_per_event
                   )
            VALUES ( SOURCE.id
                   , SOURCE.username
                   , SOURCE.printer_ip
                   , SOURCE.venue_id
                   , SOURCE.name
                   , SOURCE.staff_members
                   , SOURCE.order_capacity
                   , SOURCE.fast_pass_lane
                   , SOURCE.vendor_status
                   , SOURCE.status
                   , SOURCE.status_description
                   , SOURCE.drink_limit
                   , SOURCE.promo_enabled
                   , SOURCE.wait_m
                   , SOURCE.welcome_text
                   , SOURCE.pickup_location
                   , SOURCE.additional_info
                   , SOURCE.first_screen
                   , SOURCE.login_required
                   , SOURCE.tip_enabled
                   , SOURCE.fee
                   , SOURCE.fee_in_percent
                   , SOURCE.convince_fee
                   , SOURCE.fee_text
                   , SOURCE.image_url
                   , SOURCE.vendor_type
                   , SOURCE.seat_confirmation
                   , SOURCE.food_count
                   , SOURCE.drink_count
                   , SOURCE.mixer_count
                   , SOURCE.mixer_built_count
                   , SOURCE.merch_count
                   , SOURCE.bundle_count
                   , SOURCE.collected_tax_rate
                   , SOURCE.tax_on_total
                   , SOURCE.tax_on_tip
                   , SOURCE.tax_on_fee
                   , SOURCE.tax_charge_after_discount
                   , SOURCE.quick_order_view
                   , SOURCE.quick_order_image
                   , SOURCE.group_name
                   , SOURCE.is_drink_limit_per_event
                   )
        OUTPUT
            $action
          , GETDATE() AS LOG_DATE
          , Inserted.id
          , Inserted.username
          , Inserted.printer_ip
          , Inserted.venue_id
          , Inserted.name
          , Inserted.staff_members
          , Inserted.order_capacity
          , Inserted.fast_pass_lane
          , Inserted.vendor_status
          , Inserted.status
          , Inserted.status_description
          , Inserted.drink_limit
          , Inserted.promo_enabled
          , Inserted.wait_m
          , Inserted.welcome_text
          , Inserted.pickup_location
          , Inserted.additional_info
          , Inserted.first_screen
          , Inserted.login_required
          , Inserted.tip_enabled
          , Inserted.fee
          , Inserted.fee_in_percent
          , Inserted.convince_fee
          , Inserted.fee_text
          , Inserted.image_url
          , Inserted.vendor_type
          , Inserted.seat_confirmation
          , Inserted.food_count
          , Inserted.drink_count
          , Inserted.mixer_count
          , Inserted.mixer_built_count
          , Inserted.merch_count
          , Inserted.bundle_count
          , Inserted.collected_tax_rate
          , Inserted.tax_on_total
          , Inserted.tax_on_tip
          , Inserted.tax_on_fee
          , Inserted.tax_charge_after_discount
          , Inserted.quick_order_view
          , Inserted.quick_order_image
          , Inserted.group_name
          , Inserted.is_drink_limit_per_event
          , Deleted.id
          , Deleted.username
          , Deleted.printer_ip
          , Deleted.venue_id
          , Deleted.name
          , Deleted.staff_members
          , Deleted.order_capacity
          , Deleted.fast_pass_lane
          , Deleted.vendor_status
          , Deleted.status
          , Deleted.status_description
          , Deleted.drink_limit
          , Deleted.promo_enabled
          , Deleted.wait_m
          , Deleted.welcome_text
          , Deleted.pickup_location
          , Deleted.additional_info
          , Deleted.first_screen
          , Deleted.login_required
          , Deleted.tip_enabled
          , Deleted.fee
          , Deleted.fee_in_percent
          , Deleted.convince_fee
          , Deleted.fee_text
          , Deleted.image_url
          , Deleted.vendor_type
          , Deleted.seat_confirmation
          , Deleted.food_count
          , Deleted.drink_count
          , Deleted.mixer_count
          , Deleted.mixer_built_count
          , Deleted.merch_count
          , Deleted.bundle_count
          , Deleted.collected_tax_rate
          , Deleted.tax_on_total
          , Deleted.tax_on_tip
          , Deleted.tax_on_fee
          , Deleted.tax_charge_after_discount
          , Deleted.quick_order_view
          , Deleted.quick_order_image
          , Deleted.group_name
          , Deleted.is_drink_limit_per_event
            INTO dbo.Audit_Appetize_Vendors;

    END;

GO
