SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO











--select * from [segmentation].[vw__Primary_Customer_Information]

CREATE VIEW [segmentation].[vw__Primary_Customer_Aggregates]
AS
    ( SELECT    ssbid.SSB_CRMSYSTEM_CONTACT_ID
              , CASE WHEN tm.LastTMPurchaseDate IS NOT NULL THEN 1
                     ELSE 0
                END Has_Made_Ticket_Master_Purchase
              , LastTMPurchaseDate
              , CASE WHEN tex.LastTEXPurchaseDate IS NOT NULL THEN 1
                     ELSE 0
                END Has_Made_Ticket_Exchange_Purchase
              , tex.LastTEXPurchaseDate
              , CASE WHEN COALESCE(tex.LastTEXPurchaseDate, tm.LastTMPurchaseDate, '') = '' THEN 0
                     ELSE 1
                END Has_Made_Any_Ticket_Purchase
              , CASE WHEN COALESCE(tex.LastTEXPurchaseDate, tm.LastTMPurchaseDate, '') = '' THEN 0
                     ELSE 1
                END Has_Made_Any_Purchase
              , CASE WHEN tex.SSB_CRMSYSTEM_CONTACT_ID IS NOT NULL THEN DATEDIFF(dd, tex.LastTEXPurchaseDate, GETDATE())
                     ELSE NULL
                END Days_Since_Ticket_Exchange_Purchase
              , CASE WHEN tm.SSB_CRMSYSTEM_CONTACT_ID IS NOT NULL THEN DATEDIFF(dd, tm.LastTMPurchaseDate, GETDATE())
                     ELSE NULL
                END Days_Since_Ticket_Master_Purchase
              , CASE WHEN COALESCE(tex.LastTEXPurchaseDate, tm.LastTMPurchaseDate, '') = '' THEN NULL
                     ELSE ( CASE WHEN tex.LastTEXPurchaseDate IS NULL
                                      OR ( tm.LastTMPurchaseDate IS NOT NULL
                                           AND tex.LastTEXPurchaseDate > tm.LastTMPurchaseDate
                                         ) THEN DATEDIFF(dd, tm.LastTMPurchaseDate, GETDATE())
                                 ELSE DATEDIFF(dd, tex.LastTEXPurchaseDate, GETDATE())
                            END )
                END Days_Since_Any_Ticket_Purchase
              , CASE WHEN texSale.LastTEXSaleDate IS NOT NULL THEN 1
                     ELSE 0
                END Has_Made_Ticket_Exchange_Sale
              , texSale.LastTEXSaleDate
              , CASE WHEN texSale.SSB_CRMSYSTEM_CONTACT_ID IS NOT NULL
                     THEN DATEDIFF(dd, texSale.LastTEXSaleDate, GETDATE())
                     ELSE NULL
                END Days_Since_Ticket_Exchange_Sale
              , ssbid.SSB_CRMSYSTEM_PRIMARY_FLAG AS SSB_Primary_Record_Flag

			  
			  
			     --select COUNT(*)
      FROM      dbo.DimCustomerSSBID ssbid WITH ( NOLOCK )
                LEFT JOIN ( SELECT  SSB_CRMSYSTEM_CONTACT_ID
                                  , MAX(R_Transaction_Date) LastTEXPurchaseDate
                            FROM    segmentation.vw__Ticket_Exchange_Recipient
                            GROUP BY SSB_CRMSYSTEM_CONTACT_ID
                          ) tex ON ssbid.SSB_CRMSYSTEM_CONTACT_ID = tex.SSB_CRMSYSTEM_CONTACT_ID
                LEFT JOIN ( SELECT  SSB_CRMSYSTEM_CONTACT_ID
                                  , MAX(O_Transaction_Date) LastTEXSaleDate
                            FROM    segmentation.vw__Ticket_Exchange_Originator
                            GROUP BY SSB_CRMSYSTEM_CONTACT_ID
                          ) texSale ON ssbid.SSB_CRMSYSTEM_CONTACT_ID = texSale.SSB_CRMSYSTEM_CONTACT_ID
                LEFT JOIN ( SELECT  SSB_CRMSYSTEM_CONTACT_ID
                                  , MAX(Order_Date) LastTMPurchaseDate
                            FROM    segmentation.vw__Primary_Ticketing
                            GROUP BY SSB_CRMSYSTEM_CONTACT_ID
                          ) tm ON ssbid.SSB_CRMSYSTEM_CONTACT_ID = tm.SSB_CRMSYSTEM_CONTACT_ID
      WHERE     ssbid.SSB_CRMSYSTEM_PRIMARY_FLAG = 1
    )

	










GO
