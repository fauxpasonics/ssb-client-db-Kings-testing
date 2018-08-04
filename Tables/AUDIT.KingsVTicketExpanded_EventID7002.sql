CREATE TABLE [AUDIT].[KingsVTicketExpanded_EventID7002]
(
[acct_id] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[event_id] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[section_id] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[row_id] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[seat_num] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[num_seats] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[last_seat] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[seat_increment] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[price_code] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[pricing_method] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[full_price] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[disc_amount] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[surchg_amount] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[purchase_price] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[block_full_price] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[block_purchase_price] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[last_event_in_plan] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_num] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[class_id] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[comp_code] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[disc_code] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[surchg_code] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[printed] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[trans_type] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[consignment] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[group_flag] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[group_sales_id] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[upd_user] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[upd_datetime] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[printed_price] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[printed_datetime] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[sell_location_id] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[sell_location] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[aisle] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[sales_source_id] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[sales_source_date] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_line_item] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[order_line_item_seq] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[paid] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[total_events] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[add_usr] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[add_datetime] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[plan_event_id] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[plan_datetime] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[plan_event_name] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[plan_type] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[parent_plan_type] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[expanded] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orig_price_code] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[sold_zip] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[prev_loc_id] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contract_id] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[acct_rep_id] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[delivery_method] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[delivery_instructions] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[delivery_name_first] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[delivery_name_last] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[delivery_addr1] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[delivery_addr2] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[delivery_addr3] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[delivery_city] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[delivery_state] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[delivery_zip] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[delivery_country] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[delivery_phone] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[delivered_date] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[other_info_1] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[other_info_2] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[other_info_3] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[other_info_4] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[other_info_5] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[other_info_6] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[other_info_7] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[other_info_8] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[other_info_9] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[other_info_10] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[event_name] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[section_name] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[row_name] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[team] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[event_date] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[event_time] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[event_day] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[season_name] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[arena_name] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[manifest_name] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[game_number] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[plan_abv] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[event_name_long] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[section_desc] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[section_abv] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[row_desc] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[gate] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ga] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[print_section_name] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[print_row_and_seat] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fse] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[season_id] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[event_sort] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[section_sort] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[row_sort] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[row_index] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[name] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[attn_name] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[company_name] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[zip] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[class_name] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[class_color] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[price_code_price] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[price_code_desc] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[price_code_group] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[pc_ticket] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[pc_tax] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[pc_licfee] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[pc_other1] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[pc_other2] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[tax_rate_a] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[tax_rate_b] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[tax_rate_c] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[pc_color] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[comp_name] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[row_barcode_index] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[row_barcode_index_high] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[section_name_right] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[row_name_right] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[tm_section_name] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[tm_row_name] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[print_ticket_ind] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[tm_event_name] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[returnable] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[dsps_allowed] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[exchange_price_opt] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[barcode_status] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[barcode_season_key] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[barcode_seatcode_adjustment] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[sell_type] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[status] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[section_type] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[event_id_owned] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[event_name_owned] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[assoc_acct_id] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ticket_type_code] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ticket_type] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orig_event_id] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orig_event_name] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[price_code_info1] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[price_code_info2] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[price_code_info3] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[price_code_info4] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[price_code_info5] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ticket_template_id] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[comp_requested_by] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[comp_approved_by] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[comp_comment] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[pid_id] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[pid_number] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[offer_id] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[offer_name] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ledger_id] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ledger_code] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[merchant_id] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[merchant_code] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[merchant_color] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[club_group_id] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[inet_status] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[return_class_id] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[return_class_name] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[attn_name_type] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[attn_owner_name] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[attn_owner_name_full] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[attn_company_name] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[sub_plan_event_id] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[sub_plan_event_name] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[delivery_country_name] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[language_name] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[pc_other3] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[pc_other4] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[pc_other5] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[pc_other6] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[pc_other7] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[pc_other8] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
