CREATE TABLE [stg].[Host_Trans_Historical]
(
[ETL__ID] [int] NOT NULL IDENTITY(1, 1),
[ETL__SourceFileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EMAIL] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PREFIX] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FIRSTNAME] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MIDDLEINITIAL] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LASTNAME] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SUFFIX] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ADDRESS1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ADDRESS2] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CITY] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[STATE] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ZIP] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ZIPEXT] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DAYPHONE] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EVENINGPHONE] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TM_EVENT_ID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[INTERACTION_SOURCE] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SALEDATE] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TICKETS] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TRANSACTION_AMOUNT] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ACCOUNT] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[VOIDED_FLAG] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[VOIDED_DATE] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PAYMENT_SUBMETHOD] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CAMEFROM_CODE] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SEATINFO] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[QUALIFIERS] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FACILITY_FEE] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SERVICE_CHARGE] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TRANSACTION_NUM] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OPTION_DOLLARS] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[VAXNAME] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MOBILEPHONE] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DMA] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OPCODE] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OPLEVEL] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EXTRA1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EXTRA2] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[COUNTRY] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TICKETS_TRANSFERRED] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TICKETS_RECEIVED] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TICKETS_SURRENDERED] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EVENT_CODE] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TM_MAJORCATNAME] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TM_MINORCATNAME] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[VENUENUM] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[VENUENAME] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EVENTDATE] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ONSALEDATE] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PRESALEONDATE] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PRESALEOFFDATE] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OUTLETDATE] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PHONEDATE] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CANCELLED] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[VENUE_CITY] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[VENUE_STATE] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[VENUE_ZIP] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TICKET_TEXT] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PRIMARYACT] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SECONDARYACT] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PERFNAME] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OPT_IN_FLAG] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
CREATE NONCLUSTERED INDEX [IDX_SaleDate] ON [stg].[Host_Trans_Historical] ([SALEDATE])
GO
CREATE NONCLUSTERED INDEX [IDX_Key] ON [stg].[Host_Trans_Historical] ([TM_EVENT_ID], [SEATINFO])
GO