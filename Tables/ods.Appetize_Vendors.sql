CREATE TABLE [ods].[Appetize_Vendors]
(
[ETL__ID] [int] NOT NULL IDENTITY(1, 1),
[ETL__UpdatedDate] [datetime] NULL,
[ETL__DeltaHashKey] [binary] (32) NULL,
[id] [int] NULL,
[username] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[printer_ip] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[venue_id] [int] NULL,
[name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[staff_members] [int] NULL,
[order_capacity] [int] NULL,
[fast_pass_lane] [bit] NULL,
[vendor_status] [bit] NULL,
[status] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[status_description] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[drink_limit] [int] NULL,
[promo_enabled] [bit] NULL,
[wait_m] [int] NULL,
[welcome_text] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[pickup_location] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[additional_info] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[first_screen] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[login_required] [bit] NULL,
[tip_enabled] [bit] NULL,
[fee] [decimal] (18, 6) NULL,
[fee_in_percent] [decimal] (18, 6) NULL,
[convince_fee] [decimal] (18, 6) NULL,
[fee_text] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[image_url] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[vendor_type] [int] NULL,
[seat_confirmation] [bit] NULL,
[food_count] [int] NULL,
[drink_count] [int] NULL,
[mixer_count] [int] NULL,
[mixer_built_count] [int] NULL,
[merch_count] [int] NULL,
[bundle_count] [int] NULL,
[collected_tax_rate] [decimal] (18, 6) NULL,
[tax_on_total] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[tax_on_tip] [bit] NULL,
[tax_on_fee] [bit] NULL,
[tax_charge_after_discount] [bit] NULL,
[quick_order_view] [bit] NULL,
[quick_order_image] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[group_name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[is_drink_limit_per_event] [bit] NULL
)
GO
