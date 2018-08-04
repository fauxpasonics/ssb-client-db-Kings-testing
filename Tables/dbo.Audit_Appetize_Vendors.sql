CREATE TABLE [dbo].[Audit_Appetize_Vendors]
(
[ACTION] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LOG_DATE] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[INSERTED_id] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[INSERTED_username] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[INSERTED_printer_ip] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[INSERTED_venue_id] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[INSERTED_name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[INSERTED_staff_members] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[INSERTED_order_capacity] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[INSERTED_fast_pass_lane] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[INSERTED_vendor_status] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[INSERTED_status] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[INSERTED_status_description] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[INSERTED_drink_limit] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[INSERTED_promo_enabled] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[INSERTED_wait_m] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[INSERTED_welcome_text] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[INSERTED_pickup_location] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[INSERTED_additional_info] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[INSERTED_first_screen] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[INSERTED_login_required] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[INSERTED_tip_enabled] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[INSERTED_fee] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[INSERTED_fee_in_percent] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[INSERTED_convince_fee] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[INSERTED_fee_text] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[INSERTED_image_url] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[INSERTED_vendor_type] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[INSERTED_seat_confirmation] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[INSERTED_food_count] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[INSERTED_drink_count] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[INSERTED_mixer_count] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[INSERTED_mixer_built_count] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[INSERTED_merch_count] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[INSERTED_bundle_count] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[INSERTED_collected_tax_rate] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[INSERTED_tax_on_total] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[INSERTED_tax_on_tip] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[INSERTED_tax_on_fee] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[INSERTED_tax_charge_after_discount] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[INSERTED_quick_order_view] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[INSERTED_quick_order_image] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[INSERTED_group_name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[INSERTED_is_drink_limit_per_event] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DELETED_id] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DELETED_username] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DELETED_printer_ip] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DELETED_venue_id] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DELETED_name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DELETED_staff_members] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DELETED_order_capacity] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DELETED_fast_pass_lane] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DELETED_vendor_status] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DELETED_status] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DELETED_status_description] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DELETED_drink_limit] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DELETED_promo_enabled] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DELETED_wait_m] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DELETED_welcome_text] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DELETED_pickup_location] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DELETED_additional_info] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DELETED_first_screen] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DELETED_login_required] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DELETED_tip_enabled] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DELETED_fee] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DELETED_fee_in_percent] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DELETED_convince_fee] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DELETED_fee_text] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DELETED_image_url] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DELETED_vendor_type] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DELETED_seat_confirmation] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DELETED_food_count] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DELETED_drink_count] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DELETED_mixer_count] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DELETED_mixer_built_count] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DELETED_merch_count] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DELETED_bundle_count] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DELETED_collected_tax_rate] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DELETED_tax_on_total] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DELETED_tax_on_tip] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DELETED_tax_on_fee] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DELETED_tax_charge_after_discount] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DELETED_quick_order_view] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DELETED_quick_order_image] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DELETED_group_name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DELETED_is_drink_limit_per_event] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
