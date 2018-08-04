CREATE TABLE [ods].[Host_Audit]
(
[ETL__ID] [int] NOT NULL IDENTITY(1, 1),
[ETL__CreatedDate] [datetime] NOT NULL,
[ETL__SourceFileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[System] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[HexVaxEVID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EvCode] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EventName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MajorCategory] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MinorCategory] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ActName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SecondActName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[VenueName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EPDate] [date] NULL,
[EPTime] [time] NULL,
[Sdate] [date] NULL,
[OpType] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PriceLevel] [int] NULL,
[PriceLevelName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TicketTypeID] [int] NULL,
[TicketTypeName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[QualifierString] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AuditEntry] [int] NULL,
[SeriesMaster] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DailyTickets] [int] NULL,
[TotalTickets] [int] NULL,
[SoldFaceValue] [decimal] (18, 6) NULL,
[ServiceCharge] [decimal] (18, 6) NULL,
[FacilityFee] [decimal] (18, 6) NULL,
[ServiceTax] [bit] NULL,
[VATTax] [decimal] (18, 6) NULL,
[AdultPrice] [decimal] (18, 6) NULL,
[PremiumAmount] [decimal] (18, 6) NULL,
[QualifierMaskName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Calc_EPDateTime] [datetime] NULL
)
GO
CREATE CLUSTERED COLUMNSTORE INDEX [CCI__ods_Host_Audit] ON [ods].[Host_Audit]
GO