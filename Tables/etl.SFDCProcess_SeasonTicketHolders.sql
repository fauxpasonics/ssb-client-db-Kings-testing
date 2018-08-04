CREATE TABLE [etl].[SFDCProcess_SeasonTicketHolders]
(
[AccountId] [int] NULL,
[SSID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SeasonYear] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SeasonYr] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Team] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
