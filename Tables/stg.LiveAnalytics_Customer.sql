CREATE TABLE [stg].[LiveAnalytics_Customer]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__LiveAnaly__ETL_C__3265C68A] DEFAULT (getdate()),
[ETL_FileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ult_party_id] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[party_id] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[acct_id] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[la_id] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[cust_first_nm] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[cust_middle_nm] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[cust_last_nm] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[cust_addr_line_1] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[cust_addr_line_2] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[cust_city_nm] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[cust_state_nm] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[cust_postal_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[cust_ctry_nm] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[cust_phn_num_1] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[cust_phn_num_2] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[cust_email_addr] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[psx_classic_clus_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[psx_group_id] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[psx_classic_prec_lvl_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[discretionary_income_index_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[income_est_hh_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_male_18_24_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_female_18_24_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_unk_18_24_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_male_25_34_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_female_25_34_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_unk_25_34_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_male_35_44_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_female_35_44_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_unk_35_44_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_male_45_54_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_female_45_54_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_unk_45_54_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_male_55_64_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_female_55_64_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_unk_55_64_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_male_65_74_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_female_65_74_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_unk_65_74_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_male_75_plus_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_female_75_plus_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_unk_75_plus_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[age_two_yr_incr_1st_indv] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[age_two_yr_incr_2nd_indv] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[age_two_yr_incr_input_indv] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[veh_truck_owner_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[veh_mtrcyc_owner_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[veh_rv_owner_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[veh_new_car_buyer_flg] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[veh_known_owned_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[veh_dominant_lifestyle_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[occpn_input_indv_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[gndr_input_indv_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[gndr_1st_indv_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[gndr_2nd_indv_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[edu_input_indv_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_male_00_02_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_female_00_02_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_unk_00_02_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_male_03_05_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_female_03_05_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_unk_03_05_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_male_06_10_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_female_06_10_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_unk_06_10_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_male_11_15_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_female_11_15_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_unk_11_15_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_male_16_17_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_female_16_17_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_unk_16_17_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[occpn_1st_indv_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[occpn_2nd_indv_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[marital_status_hh_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[wrk_wmn_hh_flg] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[presence_chldn_new_flg] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[adult_hh_num] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[edu_1st_indv_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[edu_2nd_indv_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[int_theatre_perf_arts_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[int_arts_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[int_travel_domestic_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[int_home_stereo_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[int_music_player_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[int_music_avid_lstnr_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[int_music_clctr_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[int_movie_clctr_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[int_auto_motor_racing_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[int_spectator_sport_footb_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[int_spectator_sport_baseb_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[int_spectator_sport_bsktb_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[int_spectator_sport_hockey_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[int_spectator_sport_soccer_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[int_spectator_sport_tennis_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[int_swpstake_contest_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[int_sports_grp_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[int_music_grp_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[int_nascar_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[int_upscale_living_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[int_cultural_living_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[len_of_resdnc_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[dwlng_type_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[mail_ord_donor_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[mail_ord_buyer_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[mail_ord_respndr_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[bank_card_hldr_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[gas_dept_retail_card_hldr_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[travel_ent_card_hldr_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[credit_card_unk_type_hld_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[prem_card_hldr_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[upscale_dept_str_card_hldr_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[infobase_pos_match_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[acx_sources_num] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[acx_overall_match_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[suprs_mail_dma_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[client_event_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[client_tkt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[client_sp] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[client_event_dt_min] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[client_event_dt_max] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[client_pe_tkt_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[client_pe_sp] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[client_tkt_price] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[client_tkt_price_max] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[client_presale_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[client_onsale_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[client_first_wk_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[client_inbetween_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[client_final_wk_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[client_tkt_price_000_025_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[client_tkt_price_026_050_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[client_tkt_price_051_100_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[client_tkt_price_101_200_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[client_tkt_price_201_plus_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r3y_client_event_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r3y_client_tkt_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r3y_client_sp] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r3y_client_pe_tkt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r3y_client_pe_sp] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r3y_client_tkt_price] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r1y_client_event_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r1y_client_tkt_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r1y_client_sp] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r1y_client_pe_tkt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r1y_client_pe_sp] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r1y_client_tkt_price] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[dist_to_client_ven] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[dist_to_client_event] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[sale_dt_max] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[event_dt_max] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_tran_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_event_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_tkt_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_tran_amt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[py_tran_avg] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[py_event_avg] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[py_tkt_avg] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[py_tran_amt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[pe_tran_avg] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[pe_tkt_avg] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[pe_tran_amt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[tkt_price_avg] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[tkt_price_min] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[tkt_price_max] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[tkt_qty_purch_01_02_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[tkt_qty_purch_03_04_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[tkt_qty_purch_05_08_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[tkt_qty_purch_09_plus_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[tkt_price_000_025_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[tkt_price_026_050_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[tkt_price_051_100_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[tkt_price_101_200_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[tkt_price_201_plus_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[tkt_type_low_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[tkt_type_mid_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[tkt_type_high_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[tkt_type_super_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[tkt_type_vip_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[dist_to_ven] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[dist_to_ven_local] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[dist_000_010_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[dist_011_025_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[dist_026_050_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[dist_051_100_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[dist_101_200_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[dist_201_plus_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[prkg_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[pmt_visa_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[pmt_mastercard_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[pmt_amex_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[pmt_discover_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[pmt_oth_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_chnl_inet_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_chnl_phn_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_dlvry_willcall_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_dlvry_ups_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_dlvry_ticketfast_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_dlvry_mail_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_dlvry_paperless_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_dlvry_oth_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[purch_presale_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[purch_onsale_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[purch_first_wk_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[purch_inbetween_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[purch_final_wk_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[m_concerts_presale_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[m_concerts_first_dy_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[m_concerts_first_wk_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[m_concerts_inbetween_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[m_concerts_final_wk_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[m_arts_presale_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[m_arts_first_dy_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[m_arts_first_wk_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[m_arts_inbetween_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[m_arts_final_wk_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[m_fmly_presale_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[m_fmly_first_dy_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[m_fmly_first_wk_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[m_fmly_inbetween_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[m_fmly_final_wk_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[m_sports_presale_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[m_sports_first_dy_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[m_sports_first_wk_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[m_sports_inbetween_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[m_sports_final_wk_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_m_concerts_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_m_arts_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_m_fmly_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_m_sports_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_m_concerts_sp] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_m_arts_sp] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_m_fmly_sp] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_m_sports_sp] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[py_m_concerts_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[py_m_arts_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[py_m_fmly_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[py_m_sports_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[py_m_concerts_sp] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[py_m_arts_sp] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[py_m_fmly_sp] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[py_m_sports_sp] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[pe_m_concerts_tkt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[pe_m_arts_tkt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[pe_m_fmly_tkt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[pe_m_sports_tkt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[pe_m_concerts_sp] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[pe_m_arts_sp] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[pe_m_family_sp] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[pe_m_sports_sp] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[pe_m_concerts_spi] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[pe_m_arts_spi] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[pe_m_fmly_spi] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[pe_m_sports_spi] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[mon_between_purch] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[mon_between_event] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[mon_since_last_event] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[mon_since_last_purch] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r5_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[f5_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[m5_tkt_price_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[m5_tkt_type_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[brkr_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[grp_buyer_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[multi_tkt_16_plus_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[grade_fm_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[grade_rfm_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[score_fm5] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[score_rfm5] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_ms_a_brwymus_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_ms_a_comedy_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_ms_a_clasopera_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_ms_a_oth_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_ms_c_adultcont_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_ms_c_altrock_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_ms_c_ctry_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_ms_c_dancemus_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_ms_c_hardrock_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_ms_c_jazz_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_ms_c_latin_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_ms_c_hiphop_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_ms_c_rbsoul_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_ms_c_rockpop_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_ms_c_oth_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_ms_s_boxmmawres_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_ms_s_motor_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_ms_s_rodeo_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_ms_s_oth_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_ms_f_fmly_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_f_fmly] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_a_brwymus] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_a_arts_oth] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_c_altrock] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_c_comedy] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_c_ctry] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_c_hardrock] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_c_jazz] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_c_latin] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_c_rbsoul] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_c_rap] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_c_rockpop] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_c_oth] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_s_baseb] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_s_bsktb] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_s_footb] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_s_hockey] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_s_motor] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_s_sports_oth] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r3y_event_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r3y_tkt_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r3y_tran_amt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r3y_pe_tkt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r3y_pe_tran_amt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r3y_tkt_price_avg] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r3y_tkt_price_000_025_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r3y_tkt_price_026_050_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r3y_tkt_price_051_100_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r3y_tkt_price_101_200_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r3y_tkt_price_201_plus_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r3y_tkt_type_low_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r3y_tkt_type_mid_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r3y_tkt_type_high_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r3y_tkt_type_super_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r3y_tkt_type_vip_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r3y_dist_000_010_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r3y_dist_011_025_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r3y_dist_026_050_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r3y_dist_051_100_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r3y_dist_101_200_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r3y_dist_201_plus_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r3y_prkg_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r3y_ms_a_brwymus_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r3y_ms_a_comedy_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r3y_ms_a_clasopera_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r3y_ms_a_oth_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r3y_ms_c_adultcont_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r3y_ms_c_altrock_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r3y_ms_c_ctry_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r3y_ms_c_dancemus_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r3y_ms_c_hardrock_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r3y_ms_c_jazz_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r3y_ms_c_latin_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r3y_ms_c_hiphop_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r3y_ms_c_rbsoul_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r3y_ms_c_rockpop_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r3y_ms_c_oth_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r3y_ms_s_boxmmawres_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r3y_ms_s_motor_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r3y_ms_s_rodeo_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r3y_ms_s_oth_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[r3y_ms_f_fmly_ind] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[race_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[net_worth_gold_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[est_hh_inc_higher_ranges_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[est_hh_inc_narrow_ranges_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[est_hh_inc_cd_100pct_inc_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[est_hh_inc_cd_100pct_prec_cd] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[first_indv_first_nm] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[first_indv_md_nm] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[second_indv_first_nm] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[second_indv_md_nm] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[bo_out_sale_dt_min] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[bo_out_sale_dt_max] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[bo_out_event_dt_min] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[bo_out_event_dt_max] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[bo_out_tot_tran_amt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[bo_out_pe_tran_amt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[bo_out_tot_tran_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[bo_out_tot_event_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[bo_out_purch_dy_of_event_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[bo_out_purch_1_wk_before_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[bo_out_purch_2_wk_before_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[bo_out_purch_3_wk_before_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[bo_out_purch_4_wk_before_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[bo_out_purch_5_wk_before_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[bo_out_client_sale_dt_min] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[bo_out_client_sale_dt_max] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[bo_out_client_event_dt_min] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[bo_out_client_event_dt_max] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[bo_out_client_tot_tran_amt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[bo_out_client_pe_tran_amt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[bo_out_client_tot_event_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[bo_out_ven_sale_dt_min] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[bo_out_ven_sale_dt_max] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[bo_out_ven_event_dt_min] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[bo_out_ven_event_dt_max] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[bo_out_ven_tot_tran_amt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[bo_out_ven_pe_tran_amt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[bo_out_ven_tot_event_cnt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[msa_nm] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [stg].[LiveAnalytics_Customer] ADD CONSTRAINT [PK__LiveAnal__7EF6BFCD8705F796] PRIMARY KEY CLUSTERED  ([ETL_ID])
GO
