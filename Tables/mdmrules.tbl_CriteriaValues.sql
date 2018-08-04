CREATE TABLE [mdmrules].[tbl_CriteriaValues]
(
[CriteriaValueID] [int] NOT NULL IDENTITY(1, 1),
[DimCustomerID] [int] NOT NULL,
[CriteriaID] [int] NOT NULL,
[CriteriaValue] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EntryCreatedDate] [datetime] NULL CONSTRAINT [DF__tbl_Crite__Entry__013FDF81] DEFAULT (getdate())
)
GO
ALTER TABLE [mdmrules].[tbl_CriteriaValues] ADD CONSTRAINT [PK_tbl_CriteriaValues] PRIMARY KEY CLUSTERED  ([DimCustomerID], [CriteriaID])
GO
