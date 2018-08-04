CREATE TABLE [ods].[Appetize_Items]
(
[ETL__ID] [int] NOT NULL IDENTITY(1, 1),
[ETL__UpdatedDate] [datetime] NULL,
[ETL__DeltaHashKey] [binary] (32) NULL,
[item_id] [int] NULL,
[parentItemId] [int] NULL,
[unique_id] [int] NULL,
[vendor_id] [int] NULL,
[subvendor_id] [int] NULL,
[assignment_id] [int] NULL,
[category_group_id] [int] NULL,
[category_name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[description] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[show_desc] [bit] NULL,
[cost] [numeric] (18, 6) NULL,
[type] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[is_alcohol] [bit] NULL,
[status] [int] NULL,
[restrict_single_modifier] [bit] NULL,
[track_inventory] [bit] NULL,
[inventory_amount] [int] NULL,
[sold_out] [bit] NULL,
[mark_as_sold_out] [bit] NULL,
[_sold_out] [bit] NULL,
[show_in_browse] [bit] NULL,
[is_clickable] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[require_additional] [bit] NULL,
[original_bundle_cost] [decimal] (18, 6) NULL,
[add_price_override] [bit] NULL,
[upsell_item_id] [int] NULL,
[barcode] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[sku] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[active_start] [datetime] NULL,
[active_end] [datetime] NULL,
[wizard] [int] NULL,
[isOpenPrice] [bit] NULL,
[isWeightItem] [bit] NULL,
[weightUnits] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[last_update] [datetime] NULL,
[tax_group] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[item_group] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[secondary_item_group] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO