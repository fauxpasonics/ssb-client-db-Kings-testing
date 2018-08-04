CREATE TABLE [etl].[MergeAccounts_20170830]
(
[acct_id_loser] [int] NULL,
[acct_id_winner] [int] NULL,
[DimCustomerId_loser] [int] NULL,
[DimCustomerId_winner] [int] NULL,
[Id] [int] NOT NULL IDENTITY(1, 1),
[IsProcessed] [bit] NULL
)
GO
ALTER TABLE [etl].[MergeAccounts_20170830] ADD CONSTRAINT [PK__MergeAcc__3214EC076640D4FC] PRIMARY KEY CLUSTERED  ([Id])
GO
