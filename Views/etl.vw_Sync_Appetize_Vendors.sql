SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [etl].[vw_Sync_Appetize_Vendors] AS (

SELECT COALESCE(b.ETL__UpdatedDate , '1900-01-01') ETL__UpdatedDate
, CAST(a.id AS NVARCHAR(255)) id
, a.username, a.printer_ip, a.venue_id, a.name, a.staff_members, a.order_capacity, a.fast_pass_lane, a.vendor_status, a.status, a.status_description,
  a.drink_limit, a.promo_enabled, a.wait_m, a.welcome_text, a.pickup_location, a.additional_info, a.first_screen, a.login_required, a.tip_enabled, a.fee,
  a.fee_in_percent, a.convince_fee, a.fee_text, a.image_url, a.vendor_type, a.seat_confirmation, a.food_count, a.drink_count, a.mixer_count,
  a.mixer_built_count, a.merch_count, a.bundle_count, a.collected_tax_rate, a.tax_on_total, a.tax_on_tip, a.tax_on_fee, a.tax_charge_after_discount,
  a.quick_order_view, a.quick_order_image, a.group_name, a.is_drink_limit_per_event
FROM dbo.Appetize_Vendors (NOLOCK) a
LEFT OUTER JOIN (
	SELECT inserted_id id, MAX(LOG_DATE) ETL__UpdatedDate
	FROM dbo.Audit_Appetize_Vendors (NOLOCK)
	GROUP BY inserted_id
) b ON a.id = b.id

)


GO
