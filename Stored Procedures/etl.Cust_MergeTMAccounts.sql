SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [etl].[Cust_MergeTMAccounts]
(
	@acct_id_loser INT,
	@acct_id_winner INT,
	@DimCustomerId_loser INT,
	@DimCustomerId_winner INT
)

AS
BEGIN


--DECLARE @acct_id_loser INT = 114085
--DECLARE @acct_id_winner INT = 14783701
--DECLARE @DimCustomerId_loser INT = 1248440
--DECLARE @DimCustomerId_winner INT = 159636


UPDATE ods.TM_PaySchedule SET UpdateDate = GETUTCDATE() , acct_id = @acct_id_winner WHERE acct_id = @acct_id_loser;
UPDATE ods.TM_Plans SET UpdateDate = GETUTCDATE() , acct_id = @acct_id_winner WHERE acct_id = @acct_id_loser;
UPDATE ods.TM_PromoCode SET UpdateDate = GETUTCDATE() , acct_id = @acct_id_winner WHERE acct_id = @acct_id_loser;
UPDATE ods.TM_RetailNonTicket SET UpdateDate = GETUTCDATE() , acct_id = @acct_id_winner WHERE acct_id = @acct_id_loser;
UPDATE ods.TM_Solicit SET UpdateDate = GETUTCDATE() , acct_id = @acct_id_winner WHERE acct_id = @acct_id_loser;
UPDATE ods.TM_Tex SET UpdateDate = GETUTCDATE() , acct_id = @acct_id_winner WHERE acct_id = @acct_id_loser;
UPDATE ods.TM_Tex SET UpdateDate = GETUTCDATE() , assoc_acct_id = @acct_id_winner WHERE assoc_acct_id = @acct_id_loser;
UPDATE ods.TM_Tex SET UpdateDate = GETUTCDATE() , owner_acct_id = @acct_id_winner WHERE owner_acct_id = @acct_id_loser;
UPDATE ods.TM_Tkt SET UpdateDate = GETUTCDATE() , acct_id = @acct_id_winner WHERE acct_id = @acct_id_loser;
UPDATE ods.TM_AltId SET UpdateDate = GETUTCDATE() , acct_id = @acct_id_winner WHERE acct_id = @acct_id_loser;
UPDATE ods.TM_InvLineItem SET UpdateDate = GETUTCDATE() , acct_id = @acct_id_winner WHERE acct_id = @acct_id_loser;
UPDATE ods.TM_Journal SET UpdateDate = GETUTCDATE() , acct_id = @acct_id_winner WHERE acct_id = @acct_id_loser;
UPDATE ods.TM_ListCode SET UpdateDate = GETUTCDATE() , acct_id = @acct_id_winner WHERE acct_id = @acct_id_loser;
UPDATE ods.TM_Note SET UpdateDate = GETUTCDATE() , acct_id = @acct_id_winner WHERE acct_id = @acct_id_loser;
UPDATE ods.TM_HeldSeats SET UpdateDate = GETUTCDATE() , acct_id = @acct_id_winner WHERE acct_id = @acct_id_loser;
UPDATE ods.TM_CustTrace SET UpdateDate = GETUTCDATE() , acct_id = @acct_id_winner WHERE acct_id = @acct_id_loser;
UPDATE ods.TM_CustRep SET UpdatedDate = GETUTCDATE() , acct_id = @acct_id_winner WHERE acct_id = @acct_id_loser;
UPDATE ods.TM_CustAddress SET UpdateDate = GETUTCDATE() , acct_id = @acct_id_winner WHERE acct_id = @acct_id_loser;
UPDATE ods.TM_Cust SET UpdateDate = GETUTCDATE() , acct_id = @acct_id_winner WHERE acct_id = @acct_id_loser;
UPDATE ods.TM_AttendApi SET ETL__UpdatedDate = GETUTCDATE() , acct_id = @acct_id_winner WHERE acct_id = @acct_id_loser;
UPDATE ods.TM_AttendApi SET ETL__UpdatedDate = GETUTCDATE() , ticket_acct_id = @acct_id_winner WHERE ticket_acct_id = @acct_id_loser;
UPDATE ods.TM_Attend SET UpdateDate = GETUTCDATE() , acct_id = @acct_id_winner WHERE acct_id = @acct_id_loser;
UPDATE ods.TM_Tkt_History SET UpdateDate = GETUTCDATE() , acct_id = @acct_id_winner WHERE acct_id = @acct_id_loser;
UPDATE ods.TM_CustAttrib SET UpdateDate = GETUTCDATE() , acct_id = @acct_id_winner WHERE acct_id = @acct_id_loser;
UPDATE ods.TM_Ticket SET UpdateDate = GETUTCDATE() , acct_id = @acct_id_winner WHERE acct_id = @acct_id_loser;
UPDATE ods.TM_PayScheduleMOP SET UpdateDate = GETUTCDATE() , acct_id = @acct_id_winner WHERE acct_id = @acct_id_loser;
UPDATE ods.TM_Donation SET UpdateDate = GETUTCDATE() , acct_id = @acct_id_winner WHERE acct_id = @acct_id_loser;
UPDATE ods.TM_Donation SET UpdateDate = GETUTCDATE() , apply_to_acct_id = @acct_id_winner WHERE apply_to_acct_id = @acct_id_loser;
UPDATE ods.TM_Donation SET UpdateDate = GETUTCDATE() , apply_to_acct_id_display = @acct_id_winner WHERE apply_to_acct_id_display = @acct_id_loser;
UPDATE ods.TM_Donation SET UpdateDate = GETUTCDATE() , matched_acct_id = @acct_id_winner WHERE matched_acct_id = @acct_id_loser;
UPDATE ods.TM_CustMember SET UpdateDate = GETUTCDATE() , acct_id = @acct_id_winner WHERE acct_id = @acct_id_loser;
UPDATE ods.TM_CustEmail SET UpdateDate = GETUTCDATE() , acct_id = @acct_id_winner WHERE acct_id = @acct_id_loser;
UPDATE ods.TM_CustDonorLevel SET UpdateDate = GETUTCDATE() , acct_id = @acct_id_winner WHERE acct_id = @acct_id_loser;
UPDATE ods.TM_Contract SET UpdateDate = GETUTCDATE() , acct_id = @acct_id_winner WHERE acct_id = @acct_id_loser;
UPDATE ods.TM_Plans_History SET UpdateDate = GETUTCDATE() , acct_id = @acct_id_winner WHERE acct_id = @acct_id_loser;
UPDATE ods.TM_Ticket_History SET UpdateDate = GETUTCDATE() , acct_id = @acct_id_winner WHERE acct_id = @acct_id_loser;



UPDATE dbo.FactAttendance SET ETL_UpdatedDate = GETUTCDATE(), SSID_acct_id = @acct_id_winner WHERE SSID_acct_id = @acct_id_loser;
UPDATE dbo.FactAttendance_V2 SET ETL__UpdatedDate = GETUTCDATE(), ETL__SSID_TM_acct_id = @acct_id_winner WHERE ETL__SSID_TM_acct_id = @acct_id_loser;
UPDATE dbo.FactHeldSeats_V2 SET ETL__UpdatedDate = GETUTCDATE(), ETL__SSID_TM_acct_id = @acct_id_winner WHERE ETL__SSID_TM_acct_id = @acct_id_loser;
UPDATE dbo.FactTicketSales SET UpdatedDate = GETUTCDATE(), SSID_acct_id = @acct_id_winner WHERE SSID_acct_id = @acct_id_loser;
UPDATE dbo.FactTicketSales_V2 SET ETL__UpdatedDate = GETUTCDATE(), ETL__SSID_TM_acct_id = @acct_id_winner WHERE ETL__SSID_TM_acct_id = @acct_id_loser;
UPDATE dbo.FactTicketSalesHistory SET UpdatedDate = GETUTCDATE(), SSID_acct_id = @acct_id_winner WHERE SSID_acct_id = @acct_id_loser;



UPDATE dbo.FactAttendance SET ETL_UpdatedDate = GETUTCDATE(), DimCustomerId = @DimCustomerId_winner WHERE DimCustomerId = @DimCustomerId_loser;
UPDATE dbo.FactInventory SET ETL_UpdatedDate = GETUTCDATE(), SoldDimCustomerId = @DimCustomerId_winner WHERE SoldDimCustomerId = @DimCustomerId_loser;
UPDATE dbo.FactInventory SET ETL_UpdatedDate = GETUTCDATE(), ResoldDimCustomerId = @DimCustomerId_winner WHERE ResoldDimCustomerId = @DimCustomerId_loser;
UPDATE dbo.FactInventoryHistory SET ETL_UpdatedDate = GETUTCDATE(), SoldDimCustomerId = @DimCustomerId_winner WHERE SoldDimCustomerId = @DimCustomerId_loser;
UPDATE dbo.FactInventoryHistory SET ETL_UpdatedDate = GETUTCDATE(), ResoldDimCustomerId = @DimCustomerId_winner WHERE ResoldDimCustomerId = @DimCustomerId_loser;
UPDATE dbo.FactTicketSales SET UpdatedDate = GETUTCDATE(), DimCustomerId = @DimCustomerId_winner WHERE DimCustomerId = @DimCustomerId_loser;
UPDATE dbo.FactTicketSales SET UpdatedDate = GETUTCDATE(), DimCustomerIdSalesRep = @DimCustomerId_winner WHERE DimCustomerIdSalesRep = @DimCustomerId_loser;
UPDATE dbo.FactTicketSales SET UpdatedDate = GETUTCDATE(), DimCustomerId_TransSalesRep = @DimCustomerId_winner WHERE DimCustomerId_TransSalesRep = @DimCustomerId_loser;
UPDATE dbo.FactTicketSalesHistory SET UpdatedDate = GETUTCDATE(), DimCustomerId = @DimCustomerId_winner WHERE DimCustomerId = @DimCustomerId_loser;
UPDATE dbo.FactTicketSalesHistory SET UpdatedDate = GETUTCDATE(), DimCustomerIdSalesRep = @DimCustomerId_winner WHERE DimCustomerIdSalesRep = @DimCustomerId_loser;
UPDATE dbo.FactTicketSalesHistory SET UpdatedDate = GETUTCDATE(), DimCustomerId_TransSalesRep = @DimCustomerId_winner WHERE DimCustomerId_TransSalesRep = @DimCustomerId_loser;



END
GO
