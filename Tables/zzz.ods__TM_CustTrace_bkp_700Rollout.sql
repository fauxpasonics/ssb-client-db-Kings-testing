CREATE TABLE [zzz].[ods__TM_CustTrace_bkp_700Rollout]
(
[seq_id] [int] NULL,
[acct_id] [int] NULL,
[full_name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[activity_name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[call_reason] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[call_reason_name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[rc] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[error_desc] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ip_address] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[add_user] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[add_datetime] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[cust_name_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[activity_comment] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[InsertDate] [datetime] NULL CONSTRAINT [DF__TM_CustTr__Inser__222BD200] DEFAULT (getdate()),
[UpdateDate] [datetime] NULL CONSTRAINT [DF__TM_CustTr__Updat__231FF639] DEFAULT (getdate()),
[SourceFileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[HashKey] [binary] (32) NULL
)
GO
CREATE NONCLUSTERED INDEX [IDX_acct_id] ON [zzz].[ods__TM_CustTrace_bkp_700Rollout] ([acct_id])
GO
CREATE NONCLUSTERED INDEX [IDX_activity_name] ON [zzz].[ods__TM_CustTrace_bkp_700Rollout] ([activity_name])
GO
CREATE NONCLUSTERED INDEX [IDX_call_reason] ON [zzz].[ods__TM_CustTrace_bkp_700Rollout] ([call_reason])
GO
CREATE NONCLUSTERED INDEX [IDX_cust_name_id] ON [zzz].[ods__TM_CustTrace_bkp_700Rollout] ([cust_name_id])
GO
CREATE NONCLUSTERED INDEX [IDX_seq_id] ON [zzz].[ods__TM_CustTrace_bkp_700Rollout] ([seq_id])
GO
EXEC sp_addextendedproperty N'MS_Description', N'
Customer activity (query/add/update) from AccountManager', 'SCHEMA', N'zzz', 'TABLE', N'ods__TM_CustTrace_bkp_700Rollout', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Account Number', 'SCHEMA', N'zzz', 'TABLE', N'ods__TM_CustTrace_bkp_700Rollout', 'COLUMN', N'acct_id'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Activity that took place. Options include: Account Added Account Login, Account Updated, Email Preferences, Personal Preferences, Upgrade Completed, Upgrade Link Clicked.', 'SCHEMA', N'zzz', 'TABLE', N'ods__TM_CustTrace_bkp_700Rollout', 'COLUMN', N'activity_name'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Code for the Interaction', 'SCHEMA', N'zzz', 'TABLE', N'ods__TM_CustTrace_bkp_700Rollout', 'COLUMN', N'call_reason'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Interaction Names. Options include:SS ,N/A ,OP ,Forgot PW - Requested PIN ,NULL ,Link clicked ,CBM Login ,Invoice Pmt (deep-link) ,Tkt Purchase ,EX ,Seat Upgrade ,CS Support ,Group Sale ,Home Login ,Invoice List (deep-link)', 'SCHEMA', N'zzz', 'TABLE', N'ods__TM_CustTrace_bkp_700Rollout', 'COLUMN', N'call_reason_name'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Describe the error that occured during an activity (if applicable)', 'SCHEMA', N'zzz', 'TABLE', N'ods__TM_CustTrace_bkp_700Rollout', 'COLUMN', N'error_desc'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Full Name of Account Holder', 'SCHEMA', N'zzz', 'TABLE', N'ods__TM_CustTrace_bkp_700Rollout', 'COLUMN', N'full_name'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Originating address of the activity.', 'SCHEMA', N'zzz', 'TABLE', N'ods__TM_CustTrace_bkp_700Rollout', 'COLUMN', N'ip_address'
GO
