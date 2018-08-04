CREATE TABLE [mdm].[PrimaryFlagRanking_Household]
(
[dimcustomerid] [int] NOT NULL,
[sourcesystem] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ssid] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ssb_crmsystem_acct_id] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SSB_CRMSYSTEM_CONTACT_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SSB_CRMSYSTEM_HOUSEHOLD_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SSB_CRMSYSTEM_PRIMARY_FLAG] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SSB_CRMSYSTEM_ACCT_PRIMARY_FLAG] [int] NULL,
[SSB_CRMSYSTEM_HOUSEHOLD_PRIMARY_FLAG] [int] NULL,
[Source System Priority
] [int] NOT NULL,
[Archtics- Suite/Loft] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Season Ticket Holder - Current Year] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Archtics - PartialPlan - Current Year] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Archtics - Group Seats - Current Year] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Archtics - Single Game - Current Year] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Archtics - Most Recently Updated] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CRM - Most Recently Updated] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Eloqua - Most Recently Updated] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Most Recently Created
] [datetime] NOT NULL,
[Most Recently Updated] [datetime] NULL,
[ranking] [bigint] NULL,
[SS_ranking] [bigint] NULL
)
GO
CREATE CLUSTERED INDEX [ix_tmpRanking] ON [mdm].[PrimaryFlagRanking_Household] ([dimcustomerid])
GO
