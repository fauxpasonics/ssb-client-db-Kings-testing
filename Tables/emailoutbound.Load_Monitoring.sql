CREATE TABLE [emailoutbound].[Load_Monitoring]
(
[Rundate] [datetime] NULL,
[StartTime] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EndTime] [datetime] NULL,
[Completed] [datetime] NULL,
[LoadCount] [int] NULL,
[ErrorMessage] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ErrorSeverity] [int] NULL,
[ErrorState] [int] NULL,
[procname] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
