CREATE TABLE [src].[SkiData_RewardRedemptions]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL,
[ETL_SourceFileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RedemptionID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RewardID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PortalID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UserID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TicketAccountID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PointAuditID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PointsPaid] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Quantity] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Fulfilled] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FulfilledDate] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DateCreated] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DateUpdated] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UpdatedBy] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SeatID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[VoucherCodeID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
